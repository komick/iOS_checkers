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
    
    view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = [UIColor brownColor];
    
    NSLog(@"BoardNode - initWithFrame()");
    
    return self;
}


- (UIView *)getView {
    return view;
}


- (bool)isOpenSquare {
    
    return YES;
}


- (bool)isPlayer1Home {
    
    return YES;
}


- (bool)isPlayer2Home {
    
    return YES;
}


@end
