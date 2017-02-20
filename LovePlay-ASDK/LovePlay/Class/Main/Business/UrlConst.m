//
//  UrlConst.m
//  LovePlay
//
//  Created by Yuns on 2017/1/26.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "UrlConst.h"

@implementation UrlConst

NSString * const BaseURL = @"http://i.play.163.com";

NSString * const NewsListURL = @"/user/article/list";
NSString * const NewsDetailURL = @"/news/appDetail";
NSString * const NewsHotCommentURL = @"/news/v2/hottie";
NSString * const NewsLatestCommentURL = @"/news/v2/newtie";

NSString * const RecommendTopicURL = @"/news/topicOrderSource/list";
NSString * const RecommendImageInfosURL = @"/news/config/config_focus_img/list/";

NSString * const ZoneDiscussURL = @"/news/discuz/discuz_model_v2/list/center/0";
NSString * const DiscussListURL = @"http://bbs.d.163.com/api/mobile/index.php";
NSString * const DiscussListImgURL = @"/news/discuz/discuz_model/fid_img";
NSString * const DiscussDetailURL = @"http://bbs.d.163.com/api/mobile/index.php";
@end
