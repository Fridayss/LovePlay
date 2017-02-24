//
//  Mediator.h
//  BaseModule
//
//  Created by weiying on 2017/2/24.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mediator : NSObject

+ (instancetype)sharedInstance;

- (id)performTarget:(NSString *)targetName
             action:(NSString *)actionName
             params:(NSDictionary *)params
      isCacheTarget:(BOOL)isCacheTarget;

- (void)releaseCacheTarget:(NSString *)targetName;
@end
