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
    //UITouch *touch = [[event allTouches] anyObject];
    //CGPoint touchLocation = [touch locationInView:self->view];
    //if (CGRectContainsPoint(self.window.frame, touchLocation)) {
    //    dragging = YES;
    //    oldY = touchLocation.y;
    //}
    NSLog(@"TokenView - touchesBegan()");
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    /*UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    if (touch.view == self) {
        self.center =  touchLocation;
        //CGRect newFrame = CGRectMake(touchLocation.x, touchLocation.y, 40.0f, 40.0f);
        //self.frame = newFrame;
    }
    */
    
    UITouch *aTouch = [touches anyObject];
    CGPoint loc = [aTouch locationInView:self];
    CGPoint prevloc = [aTouch previousLocationInView:self];
    
    CGRect myFrame = self.frame;
    float deltaX = loc.x - prevloc.x;
    float deltaY = loc.y - prevloc.y;
    myFrame.origin.x += deltaX;
    myFrame.origin.y += deltaY;
    [self setFrame:myFrame];
    
    NSLog(@"TokenView - touchesMoved()");
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    //dragging = NO;
    NSLog(@"TokenView - touchesEnded()");
}


- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"TokenView - touchesCancelled()");
}



@end
