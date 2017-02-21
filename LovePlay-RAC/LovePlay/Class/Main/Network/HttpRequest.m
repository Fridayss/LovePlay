//
//  HttpRequest.m
//  LovePlay
//
//  Created by Yuns on 2017/1/26.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "HttpRequest.h"
#import "AFNetworking.h"

typedef NS_ENUM(NSUInteger, NetworkResponsMethod) {
    NetworkResponsMethod_GET = 1,   //GET
    NetworkResponsMethod_POST= 2    //POST
};

typedef NS_ENUM(NSUInteger, NetworkRequestType) {
    NetworkRequestType_JSON = 1,    // 默认
    NetworkRequestType_Data = 2     // 二进制格式
};

typedef NS_ENUM(NSUInteger, NetworkResponseType) {
    NetworkResponseType_JSON = 1,   // 默认
    NetworkResponseType_XML  = 2,   // XML
    NetworkResponseType_Data = 3,   // 二进制格式
};

@interface HttpRequest ()
@property (nonatomic, copy) NSString *baseURL;
@property (nonatomic, strong) NSDictionary *httpHeader;
@end

@implementation HttpRequest

+ (instancetype)sharedInstance
{
    static HttpRequest *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (void)configBaseURL:(NSString *)baseURL
{
    _baseURL = baseURL;
}

- (void)configHttpHeader:(NSDictionary *)httpHeader
{
    _httpHeader = httpHeader;
}

//GET方法
- (NSURLSessionTask *)GET:(NSString *)URLString
               parameters:(id)parameters
                  success:(NetworkResponseSuccess)success
                  failure:(NetworkResponseFail)failure
{
    return [self REQUEST:URLString parameters:parameters httpMethod:NetworkResponsMethod_GET requestType:NetworkRequestType_Data responseType:NetworkResponseType_JSON progress:nil success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//POST方法
- (NSURLSessionTask *)POST:(NSString *)URLString
                parameters:(id)parameters
                   success:(NetworkResponseSuccess)success
                   failure:(NetworkResponseFail)failure
{
    return [self REQUEST:URLString parameters:parameters httpMethod:NetworkResponsMethod_POST requestType:NetworkRequestType_Data responseType:NetworkResponseType_JSON progress:nil success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (NSURLSessionTask *)REQUEST:(NSString *)URLString
                   parameters:(id)parameters
                   httpMethod:(NetworkResponsMethod)httpMethod
                  requestType:(NetworkRequestType)requestType
                 responseType:(NetworkResponseType)responseType
                     progress:(NetworkProgress)progress
                      success:(NetworkResponseSuccess)success
                      failure:(NetworkResponseFail)failure
{
    //1、初始化：
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2、设置请求超时时间：
    manager.requestSerializer.timeoutInterval = 30.0f;
    //3、设置请求和响应数据格式:需要注意的是,默认提交请求的数据是二进制的,返回格式是JSON
    switch (requestType) {
        case NetworkRequestType_JSON:
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            break;
        case NetworkRequestType_Data:
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
        default:
            break;
    }
    switch (responseType) {
        case NetworkResponseType_JSON:
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        case NetworkResponseType_XML:
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        case NetworkResponseType_Data:
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        default:
            break;
    }
    
    //4、设置允许接收返回数据类型：
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/html",@"text/json",@"text/plain",@"text/javascript",@"text/xml",@"image/*"]];
    //5、是否有请求头和baseUrl
    if (_httpHeader) {
        for (NSString *key in _httpHeader.allKeys) {
            if (_httpHeader[key] != nil) {
                [manager.requestSerializer setValue:_httpHeader[key] forHTTPHeaderField:key];
            }
        }
    }
    
    if (![URLString containsString:@"http"]) {
        if (_baseURL) {
            URLString = [_baseURL stringByAppendingString:URLString];
        }
    }
    //6、发起网络请求：
    NSURLSessionTask *sessionTask = nil;
    if (httpMethod == NetworkResponsMethod_GET) {//GET请求
        sessionTask = [manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            if (progress) {
                progress(downloadProgress);
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
    }else if (httpMethod == NetworkResponsMethod_POST){//POST请求
        sessionTask = [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            if (progress) {
                progress(downloadProgress);
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
    }
    return sessionTask;
}

@end
