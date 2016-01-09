//
// Created by 杨虎 on 15/8/7.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKUserEntity.h"

@interface YKUserTools : NSObject
+ (void)savaUserInfoWithJsonString:(NSString *)json;

+ (YKUserEntity *)getUserInfo;

+ (BOOL)isLogin;

+ (NSString *)getUserId;

+ (void)clearUserInfo;
@end