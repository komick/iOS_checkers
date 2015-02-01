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
    
    // Create game pieces
    tokens = [[NSMutableDictionary alloc] init];
    
    [self setupBoard];
    
    return self;
}


- (void)setupBoard {
    
    // Make board nodes
    BoardNode *node = [[BoardNode alloc] initWithFrame:CGRectMake(0.0f, 80.0f, 40.0f, 40.0f)];
    [nodes setValue:node forKey:@"A1"];
    
    [boardView addSubview:[node getView]];
}


@end
