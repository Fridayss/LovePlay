//
//  HttpRequest.h
//  LovePlay
//
//  Created by Yuns on 2017/1/26.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^NetworkResponseSuccess)(id response);
typedef void (^NetworkResponseFail)(NSError *error);
typedef void (^NetworkProgress)(NSProgress *loadProgress);

@interface HttpRequest : NSObject

+ (instancetype)sharedInstance;

- (void)configBaseURL:(NSString *)baseURL;

- (void)configHttpHeader:(NSDictionary *)httpHeader;

//GET方法
- (NSURLSessionTask *)GET:(NSString *)URLString
               parameters:(id)parameters
                  success:(NetworkResponseSuccess)success
                  failure:(NetworkResponseFail)failure;

//POST方法
- (NSURLSessionTask *)POST:(NSString *)URLString
                parameters:(id)parameters
                   success:(NetworkResponseSuccess)success
                   failure:(NetworkResponseFail)failure;

@end
