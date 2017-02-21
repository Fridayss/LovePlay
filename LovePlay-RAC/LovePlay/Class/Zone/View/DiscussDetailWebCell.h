//
//  DiscussDetailWebCell.h
//  LovePlay
//
//  Created by weiying on 2017/2/7.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^webViewFinishLoadBlock)(CGFloat webViewHeight);

@interface DiscussDetailWebCell : UITableViewCell

#pragma mark - interface
+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setupHtmlBoby:(NSString *)htmlBody;

- (void)webViewDidFinishLoadBlock:(webViewFinishLoadBlock)finishLoadBlock;

@end
