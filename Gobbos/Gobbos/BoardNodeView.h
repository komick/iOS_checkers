//
//  BoardNodeView.h
//  Gobbos
//
//  Created by Komick on 2015-02-03.
//  Copyright (c) 2015 komick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoardNodeView : UIView {
    
    NSString *nodeName;
}

- (void)setNodeName:(NSString *)node;
- (NSString *)getNodeName;

@end
