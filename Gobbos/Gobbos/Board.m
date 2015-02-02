//
//  Board.m
//  Gobbos
//
//  Created by Komick on 2015-01-31.
//  Copyright (c) 2015 komick. All rights reserved.
//

#import "Board.h"

@implementation Board


- (id)initWithView:(BoardView *)v_board {
    
    // Create board view
    boardView = v_board;//[[BoardView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 240.0f)];
    
    // Create board spaces
    nodes = [[NSMutableDictionary alloc] init];
    [self initBoardNodes];
    
    // Create game pieces
    tokens = [[NSMutableDictionary alloc] init];
    [self initTokens];
    
    // Setup board for first game
    [self setupBoard];
    
    return self;
}


- (void)initBoardNodes {
    
    CGRect tmpFrame;
    NSArray *rowNames = [[NSArray alloc] initWithObjects:@"spacer", @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", nil];
    
    // Make board nodes for an 8x8 board, and only for playable board squares
    for (int row = 1; row <= 8; row++) {
        for (int col = 1; col <= 4; col++) {
            if (row%2 == 0) {
                tmpFrame = CGRectMake((col*40.0f)+((col-1)*40), (row-1)*40.0f, 40.0f, 40.0f);
            }
            else {
                tmpFrame = CGRectMake(((col-1)*40.0f)+((col-1)*40), (row-1)*40.0f, 40.0f, 40.0f);
            }
            BoardNode *tmpNode = [[BoardNode alloc] initWithFrame:tmpFrame];
            [nodes setValue:tmpNode forKey:[NSString stringWithFormat:@"%@%d",[rowNames objectAtIndex:row], col]];
            [boardView addSubview:[tmpNode getView]];
        }
    }
    
    [self linkBoardNodes];
}


- (void)linkBoardNodes {
    
    BoardNode *tmpNode;
    
    NSArray *rowNames = [[NSArray alloc] initWithObjects:@"spacer", @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", nil];
    
    // Iterate through board nodes, link to P1A, P1B, P2A and P2B values for each
    for (int row = 1; row <= 8; row++) {
        for (int col = 1; col <= 4; col++) {
            
            tmpNode = [nodes objectForKey:[NSString stringWithFormat:@"%@%d",[rowNames objectAtIndex:row], col]];
            
            // Set P2A
            if (row%2 == 0) {
                if (row-1 > 0) {
                    [tmpNode setP2A:[nodes objectForKey:[NSString stringWithFormat:@"%@%d",[rowNames objectAtIndex:row-1], col]]];
                    NSLog(@"%@%d:P2A->%@%d",[rowNames objectAtIndex:row], col, [rowNames objectAtIndex:row-1], col);
                }
            }
            else {
                if (col-1 > 0 && row-1 > 0) {
                    [tmpNode setP2A:[nodes objectForKey:[NSString stringWithFormat:@"%@%d",[rowNames objectAtIndex:row-1], col-1]]];
                    NSLog(@"%@%d:P2A->%@%d",[rowNames objectAtIndex:row], col, [rowNames objectAtIndex:row-1], col-1);
                }
            }
            
            // Set P2B
            if (row%2 != 0) {
                if (row-1 > 0) {
                    [tmpNode setP2B:[nodes objectForKey:[NSString stringWithFormat:@"%@%d",[rowNames objectAtIndex:row-1], col]]];
                    NSLog(@"%@%d:P2B->%@%d",[rowNames objectAtIndex:row], col, [rowNames objectAtIndex:row-1], col);
                }
            }
            else {
                if (col+1 <= 4 && row-1 > 0) {
                    [tmpNode setP2B:[nodes objectForKey:[NSString stringWithFormat:@"%@%d",[rowNames objectAtIndex:row-1], col+1]]];
                    NSLog(@"%@%d:P2B->%@%d",[rowNames objectAtIndex:row], col, [rowNames objectAtIndex:row-1], col+1);
                }
            }
            
            // Set P1A
            if (row%2 == 0) {
                if (row+1 <= 8) {
                    [tmpNode setP1A:[nodes objectForKey:[NSString stringWithFormat:@"%@%d",[rowNames objectAtIndex:row+1], col]]];
                    NSLog(@"%@%d:P1A->%@%d",[rowNames objectAtIndex:row], col, [rowNames objectAtIndex:row+1], col);
                }
            }
            else {
                if (col-1 > 0 && row+1 <= 8) {
                    [tmpNode setP1A:[nodes objectForKey:[NSString stringWithFormat:@"%@%d",[rowNames objectAtIndex:row+1], col-1]]];
                    NSLog(@"%@%d:P1A->%@%d",[rowNames objectAtIndex:row], col, [rowNames objectAtIndex:row+1], col-1);
                }
            }
            
            // Set P1B
            if (row%2 != 0) {
                if (row+1 <= 8) {
                    [tmpNode setP1B:[nodes objectForKey:[NSString stringWithFormat:@"%@%d",[rowNames objectAtIndex:row+1], col]]];
                    NSLog(@"%@%d:P1B->%@%d",[rowNames objectAtIndex:row], col, [rowNames objectAtIndex:row+1], col);
                }
            }
            else {
                if (col+1 <= 4 && row+1 <= 8) {
                    [tmpNode setP1B:[nodes objectForKey:[NSString stringWithFormat:@"%@%d",[rowNames objectAtIndex:row+1], col+1]]];
                    NSLog(@"%@%d:P1B->%@%d",[rowNames objectAtIndex:row], col, [rowNames objectAtIndex:row+1], col+1);
                }
            }
            
        }
    }
}


- (void)initTokens {
    
    // Create Player1's tokens
    NSArray *player1Nodes = [[NSArray alloc] initWithObjects:@"A1", @"A2", @"A3", @"A4", @"B1", @"B2", @"B3", @"B4", @"C1", @"C2", @"C3", @"C4", nil];
    
    Token *tmpToken = [[Token alloc] initWithFrame:[[nodes objectForKey:@"A1"] getView].frame forPlayer:1];
    
    [boardView addSubview:[tmpToken getView]];
    
    Token *tmpToken2 = [[Token alloc] initWithFrame:[[nodes objectForKey:@"B2"] getView].frame forPlayer:2];
    
    [boardView addSubview:[tmpToken2 getView]];
    
    
    // Create Player2's tokens
    NSArray *player2Nodes = [[NSArray alloc] initWithObjects:@"F1", @"F2", @"F3", @"F4", @"G1", @"G2", @"G3", @"G4", @"H1", @"H2", @"H3", @"H4", nil];
    
    
}


- (void)setupBoard {
    
    
}


@end
