//
//  NewsImageTitleCellNode.h
//  LovePlay
//
//  Created by Yuns on 2017/1/29.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsListInfoModel;

@interface NewsImageTitleCellNode : UITableViewCell

#pragma mark - interface
+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setupListInfoModel:(NewsListInfoModel *)listInfoModel;
@end
