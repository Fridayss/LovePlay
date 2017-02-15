//
//  RecommendTopicModel.h
//  LovePlay
//
//  Created by Yuns on 2017/1/26.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendTopicModel : NSObject

@property (nonatomic, strong) NSString *bannerUrl;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *iconUrl;
@property (nonatomic, strong) NSString *topicIconName;
@property (nonatomic, strong) NSString *topicId;
@property (nonatomic, strong) NSString *topicName;
@property (nonatomic, assign) NSInteger followUserCount;
@property (nonatomic, assign) NSInteger platform;
@property (nonatomic, assign) NSInteger sourceType;

@end
