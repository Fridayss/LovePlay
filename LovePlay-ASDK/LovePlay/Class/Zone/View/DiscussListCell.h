//
//  DiscussListCell.h
//  LovePlay
//
//  Created by Yuns on 2017/2/3.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ForumThread;
@interface DiscussListCell : ASCellNode

- (instancetype)initWithForumThread:(ForumThread *)forumThread;

@end
