//
//  BoardNode.h
//  Gobbos
//
//  Created by Komick on 2015-01-31.
//  Copyright (c) 2015 komick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Token.h"

@interface BoardNode : NSObject {
    
    BoardNode *p1a;
    BoardNode *p1b;
    BoardNode *p2a;
    BoardNode *p2b;
    
    Token *currentToken;
    
    UIView *view;
}

- (id)initWithFrame:(CGRect)frame;
- (UIView*)getView;
- (void)setP1A:(BoardNode *)node;
- (void)setP1B:(BoardNode *)node;
- (void)setP2A:(BoardNode *)node;
- (void)setP2B:(BoardNode *)node;
- (BoardNode *)getP1A;
- (BoardNode *)getP1B;
- (BoardNode *)getP2A;
- (BoardNode *)getP2B;
- (void)setCurrentToken:(Token *)token;
- (bool)isOpenSquare;
- (bool)isPlayer1Home;
- (bool)isPlayer2Home;


@end
