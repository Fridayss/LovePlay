//
//  NewsDetailModel.h
//  LovePlay
//
//  Created by Yuns on 2017/1/30.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsCommentModel.h"

@class NewsArticleModel;
@interface NewsDetailModel : NSObject

@property (nonatomic, strong) NewsArticleModel *article;
@property (nonatomic, strong) NewsCommentModel *tie;

@end

@interface NewsArticleModel : NSObject

@property (nonatomic, strong) NSString *articleUrl;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSString *digest;
@property (nonatomic, strong) NSString *docid;
@property (nonatomic, strong) NSArray *img;
@property (nonatomic, strong) NSString *ptime;
@property (nonatomic, assign) NSInteger replyCount;
@property (nonatomic, strong) NSString *shareLink;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *relative_sys;

@end

@interface NewsDetailImgeInfo : NSObject
@property (nonatomic, strong) NSString *alt;
@property (nonatomic, strong) NSString *pixel;
@property (nonatomic, strong) NSString *ref;
@property (nonatomic, strong) NSString *src;

@end

@interface NewsFavorInfo : NSObject

@property (nonatomic, strong) NSString *docID;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *imgsrc;
@property (nonatomic, strong) NSString *ptime;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSString *title;

@end
