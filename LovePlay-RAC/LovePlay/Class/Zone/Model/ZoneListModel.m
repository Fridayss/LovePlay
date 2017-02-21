//
//  ZoneListModel.m
//  LovePlay
//
//  Created by Yuns on 2017/2/2.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "ZoneListModel.h"

@implementation ZoneListModel

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"discuzList" : [ZoneDiscussDetail class]};
}

@end

@implementation ZoneDiscussDetail

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"detailList" : [ZoneDiscussItem class]};
}

@end

@implementation ZoneDiscussItem


@end

@implementation ZoneDiscussType

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"typeId" : @"id"};
}

@end
