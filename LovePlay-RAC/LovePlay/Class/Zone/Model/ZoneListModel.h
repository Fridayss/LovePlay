//
//  ZoneListModel.h
//  LovePlay
//
//  Created by Yuns on 2017/2/2.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZoneListModel : NSObject
@property (nonatomic, strong) NSArray *discuzList;
@end

@class ZoneDiscussType;
@interface ZoneDiscussDetail : NSObject

@property (nonatomic, strong) NSArray *detailList;
@property (nonatomic, strong) ZoneDiscussType *type;

@end


@interface ZoneDiscussItem : NSObject

@property (nonatomic, strong) NSString *bannerUrl;
@property (nonatomic, assign) NSInteger discuzModelTypeId;
@property (nonatomic, assign) NSInteger fid;
@property (nonatomic, strong) NSString *iconUrl;
@property (nonatomic, strong) NSString *modelDesc;
@property (nonatomic, strong) NSString *modelName;
@property (nonatomic, strong) NSString *todayPosts;
@property (nonatomic, assign) NSInteger weight;

@end

@interface ZoneDiscussType : NSObject

@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSString *typeId;
@property (nonatomic, strong) NSString *typeName;
@property (nonatomic, strong) NSString *weight;

@end
