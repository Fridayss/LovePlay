//
//  DiscussDetailModel.h
//  LovePlay
//
//  Created by Yuns on 2017/2/2.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DiscuzThread;
@interface DiscussDetailModel : NSObject

@property (nonatomic, strong) NSString *fid;
@property (nonatomic, strong) DiscuzThread *thread;
@property (nonatomic, strong) NSArray *postlist;

@end

@interface DiscuzThread : NSObject

@property (nonatomic, strong) NSString *tid;
@property (nonatomic, strong) NSString *fid;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) NSString *lastpost;
@property (nonatomic, strong) NSString *lastposter;
@property (nonatomic, strong) NSString *views;
@property (nonatomic, strong) NSString *replies;
@property (nonatomic, strong) NSString *typeName;

@end

@interface DiscuzPost : NSObject

@property (nonatomic, strong) NSString *pid;
@property (nonatomic, strong) NSString *tid;
@property (nonatomic, assign) NSInteger first;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *authorid;
@property (nonatomic, strong) NSString *dateline;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *replyText;

@end
