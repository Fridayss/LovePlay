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

@property (nonatomic, strong, readonly) NewsCommentModel *hotCommentModel;

@property (nonatomic, strong, readonly) NewsCommentModel *latestCommentModel;

@property (nonatomic, strong) RACCommand *fetchNewsCommentCommand;

@end
