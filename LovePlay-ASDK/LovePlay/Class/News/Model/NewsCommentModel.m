//
//  NewsCommentModel.m
//  LovePlay
//
//  Created by Yuns on 2017/1/30.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "NewsCommentModel.h"

@implementation NewsCommentModel

- (void)setComments:(NSDictionary *)comments
{
    NSMutableDictionary *commentDict = [NSMutableDictionary dictionary];
    [comments enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NewsCommentItem *commentItem = [NewsCommentItem modelWithJSON:obj];
        [commentDict setObject:commentItem forKey:key];
    }];
    _comments = [commentDict copy];
}

- (void)setCommentIds:(NSArray *)commentIds
{
    NSMutableArray *commentIdArray = [NSMutableArray array];
    for (NSString *floor in commentIds) {
        NSArray *floors = [floor componentsSeparatedByString:@","];
        [commentIdArray addObject:floors];
    }
    _commentIds = [commentIdArray copy];
}

@end

@implementation NewsCommentItem


@end

@implementation NewsCommentUser


@end
