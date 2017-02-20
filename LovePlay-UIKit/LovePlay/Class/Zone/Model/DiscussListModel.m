//
//  DiscussListModel.m
//  LovePlay
//
//  Created by Yuns on 2017/2/2.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "DiscussListModel.h"

@implementation DiscussListModel

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"forum_threadlist" : [ForumThread class]};
}


@end

@implementation ForumThread

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"typeId" : @"typeid"};
}

@end
