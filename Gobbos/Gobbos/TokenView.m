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


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        nc = [NSNotificationCenter defaultCenter];
        data = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}


- (void)snapback {
    
    [self setFrame:oldFrame];
    NSLog(@"Snapback!");
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    oldFrame = self.frame;
    
    CGPoint location = [[touches anyObject] locationInView:self];
    CGRect fingerRect = CGRectMake(location.x-5, location.y-5, 10, 10);
    
    for(UIView *view in self.superview.subviews){
        if (view != self) {
            CGRect subviewFrame = view.frame;
            //NSLog(@"Subviews: %lu", (unsigned long)[self.superview.subviews count]);
            
            if(CGRectIntersectsRect(self.frame, subviewFrame)){
                //we found the finally touched view
                NSLog(@"Yeah !, i found it %@",view);
                [data setValue:view forKey:@"originalBoardNodeView"];
            }
        }
    }
    
    //NSLog(@"TokenView - touchesBegan()");
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *aTouch = [touches anyObject];
    CGPoint loc = [aTouch locationInView:self];
    CGPoint prevloc = [aTouch previousLocationInView:self];
    
    CGRect myFrame = self.frame;
    float deltaX = loc.x - prevloc.x;
    float deltaY = loc.y - prevloc.y;
    myFrame.origin.x += deltaX;
    myFrame.origin.y += deltaY;
    [self setFrame:myFrame];
    
    //NSLog(@"TokenView - touchesMoved()");
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

    bool safe = NO;
    
    //CGPoint location = [[touches anyObject] locationInView:self];
    //CGRect fingerRect = CGRectMake(location.x-5, location.y-5, 10, 10);
    
    for(UIView *view in self.superview.subviews){
        //NSLog(@"Class: %@", NSStringFromClass([view class]));
        if (view != self && [view isKindOfClass:[BoardNodeView class]]) {
            CGRect subviewFrame = view.frame;
            
            if(CGRectIntersectsRect(self.frame, subviewFrame)){
                //we found the finally touched view
                NSLog(@"Yeah !, i found it %@",view);
                [data setValue:view forKey:@"targetBoardNodeView"];
                safe = YES;
            }
        }
    }
    
    if (!safe) {
        [self snapback];
    }
    else {
        
        [data setValue:self forKey:@"tokenView"];
        [nc postNotificationName:@"validateTokenMove" object:data];
    }
    
    //NSLog(@"TokenView - touchesEnded()");
}


- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
    //NSLog(@"TokenView - touchesCancelled()");
}



@end
