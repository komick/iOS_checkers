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
    
    NSNotificationCenter *nc;
    
    Board *board;
}

@property (nonatomic, retain) IBOutlet BoardView *boardView;
@property (nonatomic, retain) IBOutlet UILabel *p1Score;
@property (nonatomic, retain) IBOutlet UILabel *p2Score;
@property (nonatomic, retain) IBOutlet UILabel *p1Go;
@property (nonatomic, retain) IBOutlet UILabel *p2Go;
@property (nonatomic, retain) IBOutlet UILabel *won;
@property (nonatomic, retain) IBOutlet UILabel *lost;


- (void)showPlayer1Go:(NSNotification *)note;
- (void)hidePlayer1Go:(NSNotification *)note;
- (void)showPlayer2Go:(NSNotification *)note;
- (void)hidePlayer2Go:(NSNotification *)note;
- (void)setPlayer1Score:(NSNotification *)note;
- (void)setPlayer2Score:(NSNotification *)note;


@end
