//
//  Board.h
//  Gobbos
//
//  Created by Komick on 2015-01-31.
//  Copyright (c) 2015 komick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BoardView.h"
#import "BoardNode.h"

@interface Board : NSObject {
    
    NSDictionary *nodes;
    NSMutableArray *player1Tokens;
    NSMutableArray *player2Tokens;
    
    BoardView *boardView;
}

- (id)initWithView:(BoardView *)v_board;
- (void)initBoardNodes;
- (void)linkBoardNodes;
- (void)initTokens;
- (void)setupBoard;

@end
