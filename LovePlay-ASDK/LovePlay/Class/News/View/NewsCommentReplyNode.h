//
//  NewsCommentReplyNode.h
//  LovePlay
//
//  Created by weiying on 2017/2/6.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>

@class NewsCommentItem;
@interface NewsCommentReplyNode : ASDisplayNode

#pragma mark - interface
- (instancetype)initWithcommentItem:(NewsCommentItem *)commentItem floor:(NSInteger)floor;

@end
