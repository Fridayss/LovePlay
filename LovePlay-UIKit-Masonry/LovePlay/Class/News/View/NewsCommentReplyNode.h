//
//  NewsCommentReplyNode.h
//  LovePlay
//
//  Created by weiying on 2017/2/6.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsCommentItem;
@interface NewsCommentReplyNode : UIView

- (instancetype)initWithcommentItem:(NewsCommentItem *)commentItem floor:(NSInteger)floor;

@end
