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
    
    nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self
           selector:@selector(validateTokenMove:)
               name:@"validateTokenMove"
             object:nil];
    
    // Create board view
    boardView = v_board;//[[BoardView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 240.0f)];
    
    // Create board spaces
    nodes = [[NSMutableDictionary alloc] init];
    [self initBoardNodes];
    
    // Create game pieces
    player1Tokens = [[NSMutableArray alloc] init];
    player2Tokens = [[NSMutableArray alloc] init];
    [self initTokens];
    
    // Setup board for first game
    [self setupBoard];
    
    currentPlayersTurn = 1;
    
    [nc postNotificationName:@"showPlayer1Go" object:nil];
    [nc postNotificationName:@"hidePlayer2Go" object:nil];
    
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
            [[tmpNode getView] setNodeName:[NSString stringWithFormat:@"%@%d",[rowNames objectAtIndex:row], col]];
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
    
    Token *tmpToken;
    
    // Create Player1's tokens
    NSArray *player1Nodes = [[NSArray alloc] initWithObjects:@"A1", @"A2", @"A3", @"A4", @"B1", @"B2", @"B3", @"B4", @"C1", @"C2", @"C3", @"C4", nil];
    
    for(NSString *item in player1Nodes) {
        tmpToken = [[Token alloc] initWithFrame:[[nodes objectForKey:item] getView].frame forPlayer:1];
        [tmpToken setCurrentBoardNode:item];
        [[nodes objectForKey:item] setCurrentToken:tmpToken];
        [boardView addSubview:[tmpToken getView]];
        
        [player1Tokens addObject:tmpToken];
    }
    
    // Create Player2's tokens
    NSArray *player2Nodes = [[NSArray alloc] initWithObjects:@"F1", @"F2", @"F3", @"F4", @"G1", @"G2", @"G3", @"G4", @"H1", @"H2", @"H3", @"H4", nil];
    
    for(NSString *item in player2Nodes) {
        tmpToken = [[Token alloc] initWithFrame:[[nodes objectForKey:item] getView].frame forPlayer:2];
        [tmpToken setCurrentBoardNode:item];
        [[nodes objectForKey:item] setCurrentToken:tmpToken];
        [boardView addSubview:[tmpToken getView]];
        
        [player2Tokens addObject:tmpToken];
    }
}


- (void)setupBoard {
    
    
}


- (void)validateTokenMove:(NSNotification *)note {
    
    NSLog(@"validateTokenMove: %@ -> %@ :: Player %d", [[[note object] objectForKey:@"originalBoardNodeView"] getNodeName], [[[note object] objectForKey:@"targetBoardNodeView"] getNodeName], 1);
    
    if (currentPlayersTurn == 1) {
        bool valid = NO;
        
        BoardNode *startNode = [nodes objectForKey:[[[note object] objectForKey:@"originalBoardNodeView"] getNodeName]];
        
        BoardNode *endNode = [nodes objectForKey:[[[note object] objectForKey:@"targetBoardNodeView"] getNodeName]];
        
        BoardNode *nodeToClear = nil;
        
        // Verify player is moving a token belonging to them
        if ([[startNode getToken] owningPlayer] == 1) {
        
            // Determine if this is a valid move to an adjacent square
            if ([self isValidMoveFrom:startNode toNode:endNode forPlayer:1]) {
                valid = YES;
                NSLog(@"Winner winner chicken dinner!");
            }
            else {
                // Determine if this is a valid jump
                if ([self isValidJumpFrom:startNode toNode:endNode forPlayer:1]) {
                    
                    if ([[[startNode getP1A] getP1A] isEqual:endNode] && [endNode isOpenSquare]) {
                        if (![[startNode getP1A] isOpenSquare] && [[[startNode getP1A] getToken] owningPlayer] != 1) {
                            nodeToClear = [startNode getP1A];
                            NSLog(@"Player 1 jumps along P1A");
                            valid = YES;
                        }
                    }
                    else if ([[[startNode getP1B] getP1B] isEqual:endNode] && [endNode isOpenSquare]) {
                        if (![[startNode getP1B] isOpenSquare] && [[[startNode getP1B] getToken] owningPlayer] != 1) {
                            nodeToClear = [startNode getP1B];
                            NSLog(@"Player 1 jumps along P1B");
                            valid = YES;
                        }
                    }
                    
                    valid = YES;
                    NSLog(@"Winner winner jumping dinner!");
                }
                
            }
        }
        
        if (valid) {
            [self moveTokenFrom:startNode toNode:endNode clearingNode:nodeToClear];
            currentPlayersTurn = 2;
            [nc postNotificationName:@"showPlayer2Go" object:nil];
            [nc postNotificationName:@"hidePlayer1Go" object:nil];
            [self findValidAIMove];
        }
        else {
            [[[note object] objectForKey:@"tokenView"] snapback];
        }
        
    }
    else {
        // Not Player 1's turn, undo move
        [[[note object] objectForKey:@"tokenView"] snapback];
    }
}


- (bool)isValidMoveFrom:(BoardNode *)start toNode:(BoardNode *)end forPlayer:(int)player {
    
    bool valid = NO;
    
    if (player == 1) {
        if ([[start getP1A] isEqual:end] && [end isOpenSquare]) {
            NSLog(@"P1A is a match");
            valid = YES;
        }
        else if ([[start getP1B] isEqual:end] && [end isOpenSquare]) {
            NSLog(@"P1B is a match");
            valid = YES;
        }
        else {
            NSLog(@"P1 move is not valid!");
        }
    }
    else {
        if ([[start getP2A] isEqual:end] && [end isOpenSquare]) {
            NSLog(@"P2A is a match");
            valid = YES;
        }
        else if ([[start getP2B] isEqual:end] && [end isOpenSquare]) {
            NSLog(@"P2B is a match");
            valid = YES;
        }
        else {
            NSLog(@"P2 move is not valid!");
        }
    }
    
    return valid;
}


- (bool)isValidJumpFrom:(BoardNode *)start toNode:(BoardNode *)end forPlayer:(int)player {
    
    bool valid = NO;
    
    if (player == 1) {
        if ([[[start getP1A] getP1A] isEqual:end] && [end isOpenSquare]) {
            if (![[start getP1A] isOpenSquare] && [[[start getP1A] getToken] owningPlayer] != player) {
                NSLog(@"P1A is a valid jump");
                valid = YES;
            }
        }
        else if ([[[start getP1B] getP1B] isEqual:end] && [end isOpenSquare]) {
            if (![[start getP1B] isOpenSquare] && [[[start getP1B] getToken] owningPlayer] != player) {
                NSLog(@"P1B is a valid jump");
                valid = YES;
            }
        }
        else {
            NSLog(@"Jump is not valid!");
        }
    }
    else {
        if ([[[start getP2A] getP2A] isEqual:end] && [end isOpenSquare]) {
            if (![[start getP2A] isOpenSquare] && [[[start getP2A] getToken] owningPlayer] != player) {
                NSLog(@"P2A is a jump");
                valid = YES;
            }
        }
        else if ([[[start getP2B] getP2B] isEqual:end] && [end isOpenSquare]) {
            if (![[start getP2B] isOpenSquare] && [[[start getP2B] getToken] owningPlayer] != player) {
                NSLog(@"P2B is a jump");
                valid = YES;
            }
        }
        else {
            NSLog(@"Jump is not valid!");
        }
    }
    
    return valid;
}


- (void)moveTokenFrom:(BoardNode *)start toNode:(BoardNode *)end clearingNode:(BoardNode *)clear {
    
    // Move token to new node
    [end setCurrentToken:[start getToken]];
    [[start getToken] setCurrentBoardNode:[[end getView] getNodeName]];
    [[start getToken] snapToFrame:[end getView].frame];
    
    // Clear old node
    [start setCurrentToken:nil];
    
    // Clear opponent's token from node if applicable
    if (clear != nil) {
        [[[clear getToken] getView] removeFromSuperview];
        if ([[clear getToken] owningPlayer] == 1) {
            [player1Tokens removeObject:[clear getToken]];
            NSLog(@"Player 1 has %lu tokens left", (unsigned long)[player1Tokens count]);
            [nc postNotificationName:@"setPlayer1Score" object:[NSString stringWithFormat:@"%lu", (unsigned long)[player1Tokens count]]];
        }
        else {
            [player2Tokens removeObject:[clear getToken]];
            NSLog(@"Player 2 has %lu tokens left", (unsigned long)[player2Tokens count]);
            [nc postNotificationName:@"setPlayer2Score" object:[NSString stringWithFormat:@"%lu", (unsigned long)[player2Tokens count]]];
        }
        [clear setCurrentToken:nil];
    }
    
}


- (void)findValidAIMove {
    
    bool validMoveFound = NO;
    
    for (Token *p2t in player2Tokens) {
        
        // Check all tokens for valid jump
        if (!validMoveFound && [self isValidJumpFrom:[nodes objectForKey:[p2t getCurrentBoardNode]] toNode:[[[nodes objectForKey:[p2t getCurrentBoardNode]] getP2A] getP2A] forPlayer:2]) {
            
            [self moveTokenFrom:[nodes objectForKey:[p2t getCurrentBoardNode]] toNode:[[[nodes objectForKey:[p2t getCurrentBoardNode]] getP2A] getP2A] clearingNode:[[nodes objectForKey:[p2t getCurrentBoardNode]] getP2A]];
            
            validMoveFound = YES;
            NSLog(@"Player 2 jumps along P2A");
        }
        else if (!validMoveFound && [self isValidJumpFrom:[nodes objectForKey:[p2t getCurrentBoardNode]] toNode:[[[nodes objectForKey:[p2t getCurrentBoardNode]] getP2B] getP2B] forPlayer:2]) {
            
            [self moveTokenFrom:[nodes objectForKey:[p2t getCurrentBoardNode]] toNode:[[[nodes objectForKey:[p2t getCurrentBoardNode]] getP2B] getP2B] clearingNode:[[nodes objectForKey:[p2t getCurrentBoardNode]] getP2B]];
            
            validMoveFound = YES;
            NSLog(@"Player 2 jumps along P2B");
        }
        
        if (validMoveFound) break;
    }
    
    if (!validMoveFound) {
        for (Token *p2t in player2Tokens) {
            
            // If no jump available, check for valid moves
            if (!validMoveFound && [self isValidMoveFrom:[nodes objectForKey:[p2t getCurrentBoardNode]] toNode:[[nodes objectForKey:[p2t getCurrentBoardNode]] getP2A] forPlayer:2]) {  // Is there a valid move along P2A
                
                [self moveTokenFrom:[nodes objectForKey:[p2t getCurrentBoardNode]] toNode:[[nodes objectForKey:[p2t getCurrentBoardNode]] getP2A] clearingNode:nil];
                
                validMoveFound = YES;
                NSLog(@"Player 2 moves along P2A");
            }
            else if (!validMoveFound && [self isValidMoveFrom:[nodes objectForKey:[p2t getCurrentBoardNode]] toNode:[[nodes objectForKey:[p2t getCurrentBoardNode]] getP2B] forPlayer:2]) {// Is there a valid move along P2B
                
                [self moveTokenFrom:[nodes objectForKey:[p2t getCurrentBoardNode]] toNode:[[nodes objectForKey:[p2t getCurrentBoardNode]] getP2B] clearingNode:nil];
                
                validMoveFound = YES;
                NSLog(@"Player 2 moves along P2B");
            }
            
            if (validMoveFound) break;
        }
    }
    
    if (validMoveFound) {
        currentPlayersTurn = 1;
        [nc postNotificationName:@"showPlayer1Go" object:nil];
        [nc postNotificationName:@"hidePlayer2Go" object:nil];
        NSLog(@"Player 1's turn");
    }
    else {
        NSLog(@"Player 2 unable to move");
        [nc postNotificationName:@"hidePlayer1Go" object:nil];
        [nc postNotificationName:@"hidePlayer2Go" object:nil];
        [nc postNotificationName:@"showWon" object:nil];
    }
    
}



@end
