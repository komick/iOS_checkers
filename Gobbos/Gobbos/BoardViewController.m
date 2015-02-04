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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self
           selector:@selector(validateTokenMove:)
               name:@"validateTokenMove"
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


- (IBAction)startNewGame:(id)sender {
    
    NSLog(@"Start New Game");
}


- (void)validateTokenMove:(NSNotification *)note {
    
    [[[note object] objectForKey:@"tokenView"] snapback];
    
    
    NSLog(@"validateTokenMove: %@ -> %@ :: Player %d", [[[note object] objectForKey:@"originalBoardNodeView"] getNodeName], [[[note object] objectForKey:@"targetBoardNodeView"] getNodeName], 1);
}


- (IBAction)forceAIMove:(id)sender {
    
    //for () {
        
    //}
}


@end
