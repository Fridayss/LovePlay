//
//  DiscussDetailModel.m
//  LovePlay
//
//  Created by Yuns on 2017/2/2.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "DiscussDetailModel.h"

@implementation DiscussDetailModel

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"postlist" : [DiscuzPost class]};
}


@end

@implementation DiscuzThread

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"typeName" : @"typename"};
}

@end

@implementation DiscuzPost


@end
