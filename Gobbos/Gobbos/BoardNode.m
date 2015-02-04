//
//  BoardNode.m
//  Gobbos
//
//  Created by Komick on 2015-01-31.
//  Copyright (c) 2015 komick. All rights reserved.
//

#import "BoardNode.h"

@implementation BoardNode


- (id)initWithFrame:(CGRect)frame {
    
    view = [[BoardNodeView alloc]initWithFrame:frame];
    view.backgroundColor = [UIColor brownColor];
    
    return self;
}


- (UIView *)getView {
    return view;
}


- (void)setP1A:(BoardNode *)node {
    p1a = node;
}


- (void)setP1B:(BoardNode *)node {
    
    p1b = node;
}


- (void)setP2A:(BoardNode *)node {
    
    p2a = node;
}


- (void)setP2B:(BoardNode *)node {
    
    p2b = node;
}


- (BoardNode *)getP1A {
    
    return p1a;
}


- (BoardNode *)getP1B {
    
    return p1b;
}


- (BoardNode *)getP2A {
    
    return p2a;
}


- (BoardNode *)getP2B {
    
    return p2b;
}


- (void)setCurrentToken:(Token *)token {

    currentToken = token;
}


- (bool)isOpenSquare {
    
    return currentToken == nil;
}


- (bool)isPlayer1Home {
    
    return YES;
}


- (bool)isPlayer2Home {
    
    return YES;
}


@end
