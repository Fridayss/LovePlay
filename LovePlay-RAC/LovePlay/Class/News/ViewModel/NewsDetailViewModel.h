//
//  NewsDetailViewModel.h
//  LovePlay
//
//  Created by Yuns on 2017/2/21.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsDetailModel.h"

@interface NewsDetailViewModel : NSObject

@property (nonatomic, strong, readonly) NewsDetailModel *detailModel;

@property (nonatomic, strong) RACCommand *fetchNewsDetailCommand;
@end
