//
//  NewsCommentViewModel.m
//  LovePlay
//
//  Created by Yuns on 2017/2/21.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "NewsCommentViewModel.h"

@interface NewsCommentViewModel ()
@property (nonatomic, strong, readwrite) NewsCommentModel *hotCommentModel;
@property (nonatomic, strong, readwrite) NewsCommentModel *latestCommentModel;
@property (nonatomic, assign) NSInteger pageIndex;
@end

@implementation NewsCommentViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initParams];
        [self setupNewsCommentRACCommand];
    }
    return self;
}

- (void)initParams
{
    _pageIndex = 0;
}

- (void)setupNewsCommentRACCommand
{
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *hotCommentSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [self requestNewsHotCommentDataWithNewsID:input success:^(NSDictionary *result) {
                NewsCommentModel *commentModel = [NewsCommentModel modelWithJSON:result];
                _hotCommentModel = commentModel;
            } failure:^(NSError *error) {
                
            }];
            return nil;
        }];
        
        RACSignal *latestCommentSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [self requestNewsLatesCommentDataWithNewsID:input success:^(NSDictionary *result) {
                NewsCommentModel *commentModel = [NewsCommentModel modelWithJSON:result];
                _latestCommentModel = commentModel;

            } failure:^(NSError *error) {
                
            }];
            return nil;
        }];
        
        RACSignal *signal = nil;
        return signal;
    }];
    _fetchNewsCommentCommand = command;
}

- (void)requestNewsHotCommentDataWithNewsID:(NSString *)newsID success:(void (^)(NSDictionary *result))success failure:(void (^)(NSError *error))failure
{
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/0/10/11/2/2",NewsHotCommentURL, newsID];
    [[HttpRequest sharedInstance] GET:urlString parameters:nil success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)requestNewsLatesCommentDataWithNewsID:(NSString *)newsID success:(void (^)(NSDictionary *result))success failure:(void (^)(NSError *error))failure
{
    NSInteger pageSize = 10;
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/%ld/%ld/6/2/2",NewsLatestCommentURL, newsID, _pageIndex * pageSize, pageSize];
    [[HttpRequest sharedInstance] GET:urlString parameters:nil success:^(id response) {
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
