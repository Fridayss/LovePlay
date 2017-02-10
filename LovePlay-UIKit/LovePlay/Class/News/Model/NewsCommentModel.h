//
//  NewsCommentModel.h
//  LovePlay
//
//  Created by Yuns on 2017/1/30.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsCommentModel : NSObject

@property (nonatomic, strong) NSArray *commentIds;
@property (nonatomic, strong) NSDictionary *comments;

@end

@class NewsCommentUser;
@interface NewsCommentItem : NSObject

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *siteName;
@property (nonatomic, strong) NewsCommentUser *user;
@property (nonatomic, assign) NSInteger vote;
@end

@interface NewsCommentUser : NSObject
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *nickname;

@end
