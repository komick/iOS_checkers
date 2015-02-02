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
    
    owningPlayer = player;
    
    view = [[TokenView alloc] initWithFrame:frame];
    
    // Set up the shape of the circle
    int radius = 15;
    CAShapeLayer *circle = [CAShapeLayer layer];
    
    // Make a circular shape
    circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.0f, 0.0f, 2.0*radius, 2.0*radius)
                                             cornerRadius:radius].CGPath;
    
    circle.position = CGPointMake(5.0f,5.0f);
    
    // Configure the apperence of the circle
    if (owningPlayer == 1) {
        circle.fillColor = [UIColor purpleColor].CGColor;
        circle.strokeColor = [UIColor yellowColor].CGColor;
    }
    else {
        circle.fillColor = [UIColor redColor].CGColor;
        circle.strokeColor = [UIColor yellowColor].CGColor;
    }
    circle.lineWidth = 2;
    
    // Add layer to tokenview
    [view.layer addSublayer:circle];
    
    return self;
}

- (TokenView *)getView {
    
    return view;
}

@end
