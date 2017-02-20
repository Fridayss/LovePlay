//
//  NewsListViewController.h
//  LovePlay
//
//  Created by Yuns on 2017/1/29.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface NewsListViewController : ASViewController

#pragma mark - params
@property (nonatomic, assign) NSInteger sourceType;
@property (nonatomic, copy) NSString *topicID;

@end
