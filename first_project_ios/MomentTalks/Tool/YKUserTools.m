//
// Created by 杨虎 on 15/8/7.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKUserTools.h"
#import "UserStandardTool.h"
#import "YKUserModel.h"

const static NSString *kUserInfoKey = @"xxx";

@implementation YKUserTools {

}
+ (void)savaUserInfoWithJsonString:(NSString *)json {
    [UserStandardTool savaObjectForKey:json key:kUserInfoKey];
}

+ (YKUserEntity *)getUserInfo {
    YKUserModel *entity = [[YKUserModel alloc] initWithDictionary:[UserStandardTool getObjForKey:kUserInfoKey] error:nil];
    return entity.userEntity;
}

+ (BOOL)isLogin {
    return nil != [self getUserInfo];
}

+ (NSString *)getUserId {
    return [self isLogin] ? [self getUserInfo].userId : nil;
}

+ (void)clearUserInfo {
    [UserStandardTool clearForKey:kUserInfoKey];
}


@end