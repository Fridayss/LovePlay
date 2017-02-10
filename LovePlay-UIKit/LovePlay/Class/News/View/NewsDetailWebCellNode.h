//
//  NewsDetailWebCellNode.h
//  LovePlay
//
//  Created by Yuns on 2017/2/4.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^webViewFinishLoadBlock)();

@interface NewsDetailWebCellNode : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setupHtmlBoby:(NSString *)htmlBody;

- (void)webViewDidFinishLoadBlock:(webViewFinishLoadBlock)finishLoadBlock;

@end
