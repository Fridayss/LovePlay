//
//  NewsDetailSectionTitleHeaderView.h
//  LovePlay
//
//  Created by weiying on 2017/2/7.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsDetailSectionTitleHeaderView : UITableViewHeaderFooterView

#pragma mark - params
@property (nonatomic, copy) NSString *title;

#pragma mark - interface
+ (instancetype)sectionHeaderWithTableView:(UITableView *)tableView;

@end
