//
//  TokenView.m
//  Gobbos
//
//  Created by Komick on 2015-01-31.
//  Copyright (c) 2015 komick. All rights reserved.
//

#import "TokenView.h"

@implementation TokenView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /*UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self->view];
    if (CGRectContainsPoint(self.window.frame, touchLocation)) {
        dragging = YES;
        oldY = touchLocation.y;
    }*/
    NSLog(@"TokenView - touchesBegan()");
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    /*UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self->view];
    if (dragging) {
        CGRect frame = self.window.frame;
        frame.origin.y =  self.window.frame.origin.y + touchLocation.y - oldY;
        self.window.frame = frame;
    }*/
    NSLog(@"TokenView - touchesMoved()");
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    //dragging = NO;
    NSLog(@"TokenView - touchesEnded()");
}


@end
