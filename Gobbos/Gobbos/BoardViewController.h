//
//  BoardViewController.h
//  Gobbos
//
//  Created by Komick on 2015-01-31.
//  Copyright (c) 2015 komick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Board.h"
#import "BoardView.h"
#import "BoardNode.h"
#import "Token.h"
#import "TokenView.h"

@interface BoardViewController : UIViewController {
    
    Board *board;
}

@property (assign) IBOutlet BoardView *boardView;

- (IBAction)startNewGame:(id)sender;

@end
