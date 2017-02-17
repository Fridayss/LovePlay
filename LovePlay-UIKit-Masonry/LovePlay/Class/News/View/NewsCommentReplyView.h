//
//  NewsCommentReplyView.h
//  LovePlay
//
//  Created by weiying on 2017/2/14.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^replyTableViewDidReload)(CGFloat contentSizeHeight);
@interface NewsCommentReplyView : UIView

- (void)setupCommentItems:(NSDictionary *)commentItems floors:(NSArray *)floors;

- (void)setupCommentItems:(NSDictionary *)commentItems floors:(NSArray *)floors didReloadBlock:(replyTableViewDidReload)reloadBlock;

@end
