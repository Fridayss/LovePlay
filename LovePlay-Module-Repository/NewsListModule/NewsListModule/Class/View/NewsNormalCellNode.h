//
//  NewsNormalCellNode.h
//  LovePlay
//
//  Created by Yuns on 2017/1/30.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsListInfoModel;

@interface NewsNormalCellNode : UITableViewCell

#pragma mark - interface
+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setupListInfoModel:(NewsListInfoModel *)listInfoModel;

@end
