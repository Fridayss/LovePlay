//
//  NewsCommentCellNode.h
//  LovePlay
//
//  Created by Yuns on 2017/2/4.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>

@class NewsCommentItem;
@interface NewsCommentCellNode : ASCellNode

//- (instancetype)initWithcommentItem:(NewsCommentItem *)commentItem;

- (instancetype)initWithcommentItems:(NSDictionary *)commentItems commmentIds:(NSArray *)commmentIds;

@end
