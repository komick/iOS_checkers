//
//  Token.h
//  Gobbos
//
//  Created by Komick on 2015-01-31.
//  Copyright (c) 2015 komick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TokenView.h"

@interface Token : NSObject {
    
    int owningPlayer;
    NSString *currentBoardNode;
    
    TokenView *view;
    
}

- (id)initWithFrame:(CGRect)frame forPlayer:(int)player;
- (TokenView *)getView;

- (int)owningPlayer;
- (void)setCurrentBoardNode:(NSString *)node;
- (NSString *)getCurrentBoardNode;

@end
