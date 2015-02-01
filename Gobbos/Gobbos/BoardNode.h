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
}

- (bool)isOpenSquare;
- (bool)isPlayer1Home;
- (bool)isPlayer2Home;


@end
