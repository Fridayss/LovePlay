//
//  NewsListViewModel.m
//  LovePlay
//
//  Created by Yuns on 2017/2/21.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "NewsListViewModel.h"
#import "NewsListInfoModel.h"

@interface NewsListViewModel ()
@property (nonatomic, strong, readwrite) NSArray *newsListModels;
@property (nonatomic, assign) NSInteger pageIndex;
@end

@implementation NewsListViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initParams];
        [self setupNewsListRACCommand];
    }
    return self;
}

- (void)initParams
{
    _pageIndex = 0;
}

- (void)setupNewsListRACCommand
{
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [self requestNewsListDataWithTopicID:input success:^(NSDictionary *result) {
                NSArray *newsListArray = [NSArray modelArrayWithClass:[NewsListInfoModel class] json:result[@"info"]];
                _listModels = newsListArray;
                [subscriber sendNext:newsListArray];
                [subscriber sendCompleted];
            } failure:^(NSError *error) {
                [subscriber sendError:error];
            }];
            
            return nil;
        }];
        return signal;
    }];
    self.fetchNewsListCommand = command;
}

- (void)requestNewsListDataWithTopicID:(NSString *)topicID success:(void (^)(NSDictionary *result))success failure:(void (^)(NSError *error))failure
{
    NSInteger pageCount = 30;
    NSString *urlString = [NSString stringWithFormat:@"%@/%ld/%ld", NewsListURL, _pageIndex * pageCount, pageCount];
    if (topicID != nil) {
        urlString = [NSString stringWithFormat:@"%@/%@/%ld/%ld", NewsListURL, topicID, _pageIndex * pageCount, pageCount];
    }
    [[HttpRequest sharedInstance] GET:urlString parameters:nil success:^(id response) {
//        NSLog(@"response -- %@", response);
        DLog(@"response -- %@", response);
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        NSLog(@"error -- %@", error);
        
        if (failure) {
            failure(error);
        }
    }];
}

@end
