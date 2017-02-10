//
//  NewsTitleImageCellNode.h
//  LovePlay
//
//  Created by Yuns on 2017/1/29.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsListInfoModel;

@interface NewsTitleImageCellNode : UITableViewCell

@property (nonatomic, strong) NewsListInfoModel *listInfoModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
