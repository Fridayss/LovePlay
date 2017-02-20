//
//  NewsDetailModel.m
//  LovePlay
//
//  Created by Yuns on 2017/1/30.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "NewsDetailModel.h"

@implementation NewsDetailModel

@end

@implementation NewsArticleModel

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"img" : [NewsDetailImgeInfo class], @"relative_sys" : [NewsRelativeInfo class]};
}

@end

@implementation NewsDetailImgeInfo


@end

@implementation NewsRelativeInfo

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"ID" : @"id"};
}

@end
