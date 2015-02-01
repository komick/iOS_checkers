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
    
    NSArray *rowNames = [[NSArray alloc] initWithObjects:@"spacer", @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", nil];
    
    // Iterate through board nodes, link to P1A, P1B, P2A and P2B values for each
    for (int row = 1; row <= 8; row++) {
        for (int col = 1; col <= 4; col++) {
            if (row == 1) {
                // Don't set p1a or p1b for node
                
            }
            else if (row == 8) {
                // Don't set p2a or p2b for node
                
            }
            else {
                
            }
            
            //[nodes setValue:tmpNode forKey:[NSString stringWithFormat:@"%@%d",[rowNames objectAtIndex:row], col]];
        }
    }
}


- (void)initTokens {
    
    
}


- (void)setupBoard {
    
    
}


@end
