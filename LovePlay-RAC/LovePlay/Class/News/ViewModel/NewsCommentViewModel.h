//
//  NewsCommentViewModel.h
//  LovePlay
//
//  Created by Yuns on 2017/2/21.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsCommentModel.h"

@interface NewsCommentViewModel : NSObject

@property (nonatomic, strong, readonly) NewsCommentModel *hotComments;

@property (nonatomic, strong, readonly) NewsCommentModel *latestComments;

@property (nonatomic, strong) RACCommand *fetchNewsCommentCommand;

@end
