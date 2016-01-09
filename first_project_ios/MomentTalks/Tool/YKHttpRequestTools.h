//
// Created by 杨虎 on 15/8/2.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@class YKBaseRequsetDataModel;

@interface YKHttpRequestTools : NSObject

+ (void)apiRequestForGetWithApi:(NSString *)api
                     parameters:(NSMutableDictionary *)parameters
                        success:(void (^)(id responseObject))success
                        failure:(void (^)(NSString *error))failure;

+ (void)apiRequestForPostWithApi:(NSString *)api
                      parameters:(NSMutableDictionary *)parameters
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSString *error))failure;

+ (AFHTTPRequestOperationManager *)getHttpRequestManager;
@end