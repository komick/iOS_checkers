//
//  Board.m
//  Gobbos
//
//  Created by Komick on 2015-01-31.
//  Copyright (c) 2015 komick. All rights reserved.
//

#import "Board.h"

@implementation Board


- (id)init {
    
    // Create board view
    boardview = [[BoardView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 240.0f)];
    
    // Create board spaces
    nodes = [[NSMutableDictionary alloc] init];
    
    // Create game pieces
    tokens = [[NSMutableDictionary alloc] init];
    
    
    return self;
}


- (void)setupBoard {
    
    
}


@end
