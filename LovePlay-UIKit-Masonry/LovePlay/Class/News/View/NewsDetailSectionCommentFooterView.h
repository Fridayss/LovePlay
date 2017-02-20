//
//  NewsDetailSectionCommentFooterView.h
//  LovePlay
//
//  Created by weiying on 2017/2/7.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^commentFooterTouchBlock)();

@interface NewsDetailSectionCommentFooterView : UITableViewHeaderFooterView

#pragma mark - params
@property (nonatomic, copy) NSString *title;

#pragma mark - interface
+ (instancetype)sectionFooterWithTableView:(UITableView *)tableView;

- (void)commentFooterViewTouchBlock:(commentFooterTouchBlock)touchBlock;

@end
