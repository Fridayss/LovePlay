//
//  NewsDetailSectionTitleHeaderView.h
//  LovePlay
//
//  Created by weiying on 2017/2/7.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsDetailSectionTitleHeaderView : UITableViewHeaderFooterView

@property (nonatomic, copy) NSString *title;

+ (instancetype)sectionHeaderWithTableView:(UITableView *)tableView;

@end
