//
//  NewsDetailViewModel.m
//  LovePlay
//
//  Created by Yuns on 2017/2/21.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "NewsDetailViewModel.h"

@interface NewsDetailViewModel ()
@property (nonatomic, strong, readwrite) NewsDetailModel *newsDetailModel;
@end

@implementation NewsDetailViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupNewsDetailRACCommand];
    }
    return self;
}


- (void)setupNewsDetailRACCommand
{
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [self requestNewsDetailDataWithNewsID:input success:^(NSDictionary *result) {
                NewsDetailModel *detailModel = [NewsDetailModel modelWithJSON:result[@"info"]];
                _detailModel = detailModel;
                [subscriber sendNext:detailModel];
                [subscriber sendCompleted];
            } failure:^(NSError *error) {
                [subscriber sendError:error];
            }];
            
            return nil;
        }];
        return signal;
    }];
    self.fetchNewsDetailCommand = command;
}

- (void)requestNewsDetailDataWithNewsID:(NSString *)newsID success:(void (^)(NSDictionary *result))success failure:(void (^)(NSError *error))failure
{
    NSString *urlString = [NSString stringWithFormat:@"%@/%@",  NewsDetailURL, newsID];
    NSDictionary *params = @{@"tieVersion":@"v2",@"platform":@"ios",@"width":@(kScreenWidth*2),@"height":@(kScreenHeight*2),@"decimal":@"75"};
    [[HttpRequest sharedInstance] GET:urlString parameters:params success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
