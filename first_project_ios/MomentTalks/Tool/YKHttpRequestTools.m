//
// Created by 杨虎 on 15/8/2.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKHttpRequestTools.h"
#import "YKBaseRequsetDataModel.h"

static AFHTTPRequestOperationManager *requestOperationManager;


@implementation YKHttpRequestTools


/**
* 统一处理接口返回数据
*/
+ (void)requestResultWithSuccess:(void (^)(id responseObject))success
                         failure:(void (^)(NSString *error))failure
                  responseObject:(id)responseObject {
    if (responseObject) {
        YKBaseRequsetDataModel *dataModel = [[YKBaseRequsetDataModel alloc]
                initWithDictionary:responseObject error:nil];
        if (dataModel.status) {
            success(responseObject);
        } else {
            failure(dataModel.message);
        }
    } else {
        failure([self requestError]);
    }
}

/**
* 网络请求失败信息
*/
+ (NSString *)requestError {
    return @"请求失败";
}

+ (void)apiRequestForGetWithApi:(NSString *)api
                     parameters:(NSMutableDictionary *)parameters
                        success:(void (^)(id responseObject))success
                        failure:(void (^)(NSString *error))failure {
    [[self getHttpRequestManager] GET:api
                           parameters:parameters
                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                  [self requestResultWithSuccess:success failure:failure responseObject:responseObject];
                              }
                              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                  failure([self requestError]);
                              }];
}

+ (void)apiRequestForPostWithApi:(NSString *)api
                      parameters:(NSMutableDictionary *)parameters
                         success:(void (^)(id responseObject))success
                         failure:(void (^)(NSString *error))failure {
    [[self getHttpRequestManager] POST:api
                            parameters:parameters
                               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                   [self requestResultWithSuccess:success failure:failure responseObject:responseObject];
                               }
                               failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                   NSLog(@"error = %@", error);
                                   failure([self requestError]);
                               }];
}

+ (AFHTTPRequestOperationManager *)getHttpRequestManager {
    if (!requestOperationManager) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        requestOperationManager = manager;
        requestOperationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                @"application/json",
                @"text/plain",
                @"text/json",
                @"text/javascript",
                @"text/html", nil];
        manager.requestSerializer.timeoutInterval = 10;
        [manager.operationQueue cancelAllOperations];

    }
    return requestOperationManager;
}
@end