//
//  DiscussListModel.h
//  LovePlay
//
//  Created by Yuns on 2017/2/2.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiscussListModel : NSObject

@property (nonatomic, strong) NSArray *forum_threadlist;

@end

@interface ForumThread : NSObject

@property (nonatomic, strong) NSString *tid;
@property (nonatomic, strong) NSString *typeId;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *authorid;
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) NSString *dateline;
@property (nonatomic, strong) NSString *lastpost;
@property (nonatomic, strong) NSString *lastposter;
@property (nonatomic, strong) NSString *replies;
@property (nonatomic, assign) NSInteger displayorder;

@end
