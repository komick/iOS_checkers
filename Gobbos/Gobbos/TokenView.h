//
//  TokenView.h
//  Gobbos
//
//  Created by Komick on 2015-01-31.
//  Copyright (c) 2015 komick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoardNodeView.h"

@interface TokenView : UIView {
    
    NSNotificationCenter *nc;
    NSMutableDictionary *data;
    CGRect oldFrame;
}

- (id)initWithFrame:(CGRect)frame;
- (void)snapback;

@end
