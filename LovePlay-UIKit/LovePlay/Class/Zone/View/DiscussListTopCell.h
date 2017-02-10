//
//  DiscussListTopCell.h
//  LovePlay
//
//  Created by Yuns on 2017/2/3.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DiscussListModel;
@interface DiscussListTopCell : UITableViewCell

@property (nonatomic, strong) DiscussListModel *listModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
