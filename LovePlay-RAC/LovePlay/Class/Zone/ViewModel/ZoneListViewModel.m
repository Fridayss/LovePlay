//
//  ZoneListViewModel.m
//  LovePlay
//
//  Created by Yuns on 2017/2/21.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "ZoneListViewModel.h"
#import "ZoneListModel.h"

@interface ZoneListViewModel ()
@property (nonatomic, strong, readwrite) NSArray *listModels;
@property (nonatomic, assign) NSInteger pageIndex;
@end

@implementation ZoneListViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initParams];
        [self setupZoneListRACCommand];
    }
    return self;
}

- (void)initParams
{
    _pageIndex = 0;
}

- (void)setupZoneListRACCommand
{
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [self requestZoneListDataWithSuccess:^(NSDictionary *result) {
                ZoneListModel *listModel = [ZoneListModel modelWithJSON:result[@"info"]];
                _listModels = listModel.discuzList;
                [subscriber sendNext:listModel];
                [subscriber sendCompleted];
            } failure:^(NSError *error) {
                [subscriber sendError:error];
            }];
            
            return nil;
        }];
        return signal;
    }];
    self.fetchZoneListCommand = command;
}

- (void)requestZoneListDataWithSuccess:(void (^)(NSDictionary *result))success failure:(void (^)(NSError *error))failure
{
    [[HttpRequest sharedInstance] GET:ZoneDiscussURL parameters:nil success:^(id response) {
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
