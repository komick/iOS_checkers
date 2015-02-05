//
//  Token.m
//  Gobbos
//
//  Created by Komick on 2015-01-31.
//  Copyright (c) 2015 komick. All rights reserved.
//

#import "Token.h"
#import "TokenView.h"

@implementation Token

- (id)initWithFrame:(CGRect)frame forPlayer:(int)player {
    
    currentBoardNode = nil;
    
    owningPlayer = player;
    
    view = [[TokenView alloc] initWithFrame:CGRectMake(frame.origin.x+5, frame.origin.y+5, 30.0f, 30.0f)];
    
    // Set up the shape of the circle
    int radius = 15;
    CAShapeLayer *circle = [CAShapeLayer layer];
    
    // Make a circular shape
    circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.0f, 0.0f, 2.0*radius, 2.0*radius)
                                             cornerRadius:radius].CGPath;
    
    circle.position = CGPointMake(0.0f,0.0f);
    
    // Configure the apperence of the circle
    if (owningPlayer == 1) {
        circle.fillColor = [UIColor redColor].CGColor;
        circle.strokeColor = [UIColor yellowColor].CGColor;
    }
    else {
        circle.fillColor = [UIColor greenColor].CGColor;
        circle.strokeColor = [UIColor blackColor].CGColor;
    }
    circle.lineWidth = 2;
    
    // Add layer to tokenview
    [view.layer addSublayer:circle];
    
    return self;
}

- (TokenView *)getView {
    
    return view;
}

- (void)snapToFrame:(CGRect)frame {
    
    [view setFrame:CGRectMake(frame.origin.x+5, frame.origin.y+5, 30.0f, 30.0f)];
}


- (void)setCurrentBoardNode:(NSString *)node {
    
    currentBoardNode = node;
}

- (NSString *)getCurrentBoardNode {
    
    return currentBoardNode;
}


- (int)owningPlayer {
    
    return owningPlayer;
}

@end
