//
//  BoardViewController.m
//  Gobbos
//
//  Created by Komick on 2015-01-31.
//  Copyright (c) 2015 komick. All rights reserved.
//

#import "BoardViewController.h"


@interface BoardViewController ()

@end

@implementation BoardViewController

@synthesize boardView;
@synthesize p1Score;
@synthesize p2Score;
@synthesize p1Go;
@synthesize p2Go;
@synthesize won;
@synthesize lost;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self
           selector:@selector(showPlayer1Go:)
               name:@"showPlayer1Go"
             object:nil];
    
    [nc addObserver:self
           selector:@selector(hidePlayer1Go:)
               name:@"hidePlayer1Go"
             object:nil];
    
    [nc addObserver:self
           selector:@selector(showPlayer2Go:)
               name:@"showPlayer2Go"
             object:nil];
    
    [nc addObserver:self
           selector:@selector(hidePlayer2Go:)
               name:@"hidePlayer2Go"
             object:nil];
    
    [nc addObserver:self
           selector:@selector(setPlayer1Score:)
               name:@"setPlayer1Score"
             object:nil];
    
    [nc addObserver:self
           selector:@selector(setPlayer2Score:)
               name:@"setPlayer2Score"
             object:nil];
    
    [nc addObserver:self
           selector:@selector(showWon:)
               name:@"showWon"
             object:nil];
    
    [nc addObserver:self
           selector:@selector(showLost:)
               name:@"showLost"
             object:nil];
    
    board = [[Board alloc] initWithView:boardView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)showPlayer1Go:(NSNotification *)note {
    [p1Go setHidden:NO];
}


- (void)hidePlayer1Go:(NSNotification *)note {
    [p1Go setHidden:YES];
}


- (void)showPlayer2Go:(NSNotification *)note {
    [p2Go setHidden:NO];
}


- (void)hidePlayer2Go:(NSNotification *)note {
    [p2Go setHidden:YES];
}


- (void)setPlayer1Score:(NSNotification *)note {
    p1Score.text = [note object];
}


- (void)setPlayer2Score:(NSNotification *)note {
    p2Score.text = [note object];
}


- (void)showWon:(NSNotification *)note {
    [won setHidden:NO];
}


- (void)ShowLost:(NSNotification *)note {
    [lost setHidden:NO];
}


@end
