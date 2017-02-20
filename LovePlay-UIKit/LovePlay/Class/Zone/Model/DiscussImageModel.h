//
//  DiscussImageModel.h
//  LovePlay
//
//  Created by Yuns on 2017/2/3.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiscussImageModel : NSObject

@property (nonatomic, strong) NSString *bannerUrl;
@property (nonatomic, assign) NSInteger discuzModelTypeId;
@property (nonatomic, assign) NSInteger fid;
@property (nonatomic, strong) NSString *iconUrl;
@property (nonatomic, strong) NSString *modelDesc;
@property (nonatomic, strong) NSString *modelName;
@property (nonatomic, strong) NSString *todayPosts;
@property (nonatomic, assign) NSInteger weight;

@end
