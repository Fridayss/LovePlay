//
//  NewsCommentReplyCell.h
//  LovePlay
//
//  Created by weiying on 2017/2/14.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsCommentItem;
@interface NewsCommentReplyCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setupCommentItem:(NewsCommentItem *)commentItem floor:(NSInteger)floor;

@end
