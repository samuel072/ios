//
// Created by 杨虎 on 15/8/2.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKApiRequestServer.h"
#import "YKHttpRequestTools.h"
#import "AppApiUrl.h"
#import "YKSearchListModel.h"
#import "YKUserTools.h"
#import "YKCheckVersionModel.h"
#import "MD5.h"
#import "YKListenToMeModel.h"

@implementation YKApiRequestServer

//f41a6fc3-35e5-4b3c-bf74-888607852ea2
+ (void)wechatGetRequstDataWithUrl:(NSString *)requestUrl
                           success:(void (^)(id responseObject))success
                           failure:(void (^)(NSError *error))failure {
    [[YKHttpRequestTools getHttpRequestManager] GET:requestUrl
                                         parameters:nil
                                            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                if (success) success(responseObject);
                                            }
                                            failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                if (failure) failure(error);
                                            }];
}

+ (void)requestMobileCodeWithPhoneNumble:(NSString *)phoneNumble
                                 success:(void (^)(NSString *code))success
                                 failure:(void (^)(NSString *error))failure {
    NSMutableDictionary *parameter = @{}.mutableCopy;
    parameter[@"emailOrMobile"] = phoneNumble;
    [YKHttpRequestTools apiRequestForPostWithApi:YKAPICode parameters:parameter
                                         success:^(id responseObject) {
                                             success([NSString stringWithFormat:@"%@", responseObject[@"code"]]);
                                         }
                                         failure:^(NSString *error) {
                                             failure(error);
                                         }];
}

+ (void)userLoginWithAccount:(NSString *)account
                    password:(NSString *)password
                     success:(void (^)(YKUserModel *userModel))success
                     failure:(void (^)(NSString *error))failure {
    NSMutableDictionary *parameter = @{}.mutableCopy;
    parameter[@"emailOrMobile"] = account;
    parameter[@"password"] = [MD5 encryptionStr:password];
    [YKHttpRequestTools apiRequestForPostWithApi:YKAPILogin parameters:parameter
                                         success:^(id responseObject) {
                                             YKUserModel *userModel = [[YKUserModel alloc]
                                                     initWithDictionary:responseObject error:nil];
                                             [YKUserTools savaUserInfoWithJsonString:responseObject];
                                             success(userModel);
                                         }
                                         failure:^(NSString *error) {
                                             failure(error);
                                         }];

}

+ (void)requestUserInfoWithSuccess:(void (^)(YKUserModel *userModel))success
                           failure:(void (^)(NSString *error))failure {
    NSMutableDictionary *parameter = @{}.mutableCopy;
    parameter[@"userId"] = [YKUserTools getUserId];
    [YKHttpRequestTools apiRequestForPostWithApi:YKAPIUserInfo parameters:parameter
                                         success:^(id responseObject) {
                                             YKUserModel *userModel = [[YKUserModel alloc]
                                                     initWithDictionary:responseObject error:nil];
                                             NSLog(@"userModel = %@", userModel);
                                             [YKUserTools savaUserInfoWithJsonString:responseObject];
                                             success(userModel);
                                         }
                                         failure:^(NSString *error) {
                                             failure(error);
                                         }];
}


+ (void)userRegisterWithAccount:(NSString *)account
                       password:(NSString *)password
                           code:(NSString *)code status:(NSString *)status
                        success:(void (^)(YKUserModel *userModel))success
                        failure:(void (^)(NSString *error))failure {
    NSMutableDictionary *parameter = @{}.mutableCopy;
    parameter[@"emailOrMobile"] = account;
    parameter[@"password"] = [MD5 encryptionStr:password];
    parameter[@"status"] = status;
    parameter[@"code"] = code;
    [YKHttpRequestTools apiRequestForPostWithApi:YKAPIRegister parameters:parameter
                                         success:^(id responseObject) {
                                             YKUserModel *userModel = [[YKUserModel alloc]
                                                     initWithDictionary:responseObject error:nil];
                                             [YKUserTools savaUserInfoWithJsonString:responseObject];
                                             success(userModel);
                                         }
                                         failure:^(NSString *error) {
                                             failure(error);
                                         }];
}

#pragma mark -  添加预约
+ (void)addCollectionWithVideoId:(NSString *)videoId
                         success:(void (^)())success
                         failure:(void (^)(NSString *error))failure {
    NSMutableDictionary *parameter = @{}.mutableCopy;
    parameter[@"userId"] = [YKUserTools getUserId];;
    parameter[@"videoId"] = videoId;
    [YKHttpRequestTools apiRequestForPostWithApi:YKAPIAddCollection parameters:parameter
                                         success:^(id responseObject) {
                                             success();
                                         }
                                         failure:^(NSString *error) {
                                             failure(error);
                                         }];
}
// 取消收藏
+ (void)removeCollectionWithVideoId:(NSString *)videoId
                            success:(void (^)())success
                            failure:(void (^)(NSString *error))failure {
    NSMutableDictionary *parameter = @{}.mutableCopy;
    parameter[@"userId"] = [YKUserTools getUserId];
    parameter[@"videoId"] = videoId;
    NSLog(@"parameter = %@", parameter);
    [YKHttpRequestTools apiRequestForPostWithApi:YKAPIDeleteCollection parameters:parameter
                                         success:^(id responseObject) {
                                             success();
                                         }
                                         failure:^(NSString *error) {
                                             failure(error);
                                         }];
}


+ (void)userLogOutWithSuccess:(void (^)())success
                      failure:(void (^)(NSString *))failure {
    NSMutableDictionary *parameter = @{}.mutableCopy;
    parameter[@"userId"] = [YKUserTools getUserId];
    [YKHttpRequestTools apiRequestForPostWithApi:YKAPILogout parameters:parameter
                                         success:^(id responseObject) {
                                             NSLog(@"responseObject = %@", responseObject);
                                             success();
                                         }
                                         failure:^(NSString *error) {
                                             failure(error);
                                         }];
}

+ (void)videoPraiseWithResourceId:(NSString *)resourceId
                           status:(NSString *)status
                          success:(void (^)())success
                          failure:(void (^)(NSString *error))failure {
    NSMutableDictionary *parameter = @{}.mutableCopy;
    parameter[@"resourceId"] = resourceId;
    parameter[@"userId"] = [YKUserTools getUserId];;
    parameter[@"status"] = status;
    [YKHttpRequestTools apiRequestForPostWithApi:YKAPIVideoPraise parameters:parameter
                                         success:^(id responseObject) {
                                             success();
                                         }
                                         failure:^(NSString *error) {
                                             failure(error);
                                         }];
}

//添加评论
+ (void)addVideoCommentWithResourceId:(NSString *)resourceId
                               status:(NSString *)status
                              content:(NSString *)content
                              success:(void (^)())success
                              failure:(void (^)(NSString *error))failure {
    NSMutableDictionary *parameter = @{}.mutableCopy;
    parameter[@"resourceId"] = resourceId;
    parameter[@"userId"] = [YKUserTools getUserId];;
    parameter[@"status"] = status;
    parameter[@"content"] = [NSString stringWithFormat:@"[{\"content\":\"%@\",\"type\":\"1\"}]", content];
    [YKHttpRequestTools apiRequestForPostWithApi:YKAPIVideoComment parameters:parameter
                                         success:^(id responseObject) {
                                             success();
                                         }
                                         failure:^(NSString *error) {
                                             failure(error);
                                         }];
}

//获取评论列表
+ (void)requestVideoCommentListWithResourceId:(NSString *)resourceId
                                         size:(NSString *)size
                                       status:(NSString *)status
                                         page:(NSString *)page
                                      success:(void (^)(YKVideoCommentListModel *videoCommentListModel))success
                                      failure:(void (^)(NSString *error))failure {
    NSMutableDictionary *parameter = @{}.mutableCopy;
    parameter[@"resourceId"] = resourceId;
    parameter[@"size"] = size;
    parameter[@"status"] = status;
    parameter[@"page"] = page;
    [YKHttpRequestTools apiRequestForPostWithApi:YKAPICommentList parameters:parameter
                                         success:^(id responseObject) {
                                             YKVideoCommentListModel *model = [[YKVideoCommentListModel alloc]
                                                     initWithDictionary:responseObject
                                                                  error:nil];
                                             success(model);
                                         }
                                         failure:^(NSString *error) {
                                             failure(error);
                                         }];
}

+ (void)requestReservationListWithSuccess:(void (^)(YKReservationListModel *reservationListModel))success
                                  failure:(void (^)(NSString *error))failure {
    NSMutableDictionary *parameter = @{}.mutableCopy;
    parameter[@"userId"] = [YKUserTools getUserId];;
    [YKHttpRequestTools apiRequestForPostWithApi:YKAPItReservationList parameters:parameter
                                         success:^(id responseObject) {
                                             YKReservationListModel *model = [[YKReservationListModel alloc]
                                                     initWithDictionary:responseObject
                                                                  error:nil];
                                             success(model);
                                         }
                                         failure:^(NSString *error) {
                                             failure(error);
                                         }];
}

+ (void)addReservationWithAlbumId:(NSString *)albumId
                          success:(void (^)())success
                          failure:(void (^)(NSString *error))failure {
    NSMutableDictionary *parameter = @{}.mutableCopy;
    parameter[@"userId"] = [YKUserTools getUserId];;
    parameter[@"albumId"] = albumId;
    [YKHttpRequestTools apiRequestForPostWithApi:YKAPIAddReservation parameters:parameter
                                         success:^(id responseObject) {
                                             success();
                                         }
                                         failure:^(NSString *error) {
                                             failure(error);
                                         }];
}


+ (void)removeReservationWithAlbumId:(NSString *)albumId
                             success:(void (^)())success
                             failure:(void (^)(NSString *error))failure {
    NSMutableDictionary *parameter = @{}.mutableCopy;
    parameter[@"userId"] = [YKUserTools getUserId];;
    parameter[@"albumId"] = albumId;
    [YKHttpRequestTools apiRequestForPostWithApi:YKAPIARemoveReservation parameters:parameter
                                         success:^(id responseObject) {
                                             success();
                                         }
                                         failure:^(NSString *error) {
                                             failure(error);
                                         }];
}

+ (void)commentReplyWithCommentId:(NSString *)commentId
                         toUserId:(NSString *)toUserId
                          content:(NSString *)content
                           status:(NSString *)status
                          success:(void (^)())success
                          failure:(void (^)(NSString *error))failure {
    NSMutableDictionary *parameter = @{}.mutableCopy;
    parameter[@"userId"] = [YKUserTools getUserId];;
    parameter[@"commentId"] = commentId;
    parameter[@"toUserId"] = toUserId;
    parameter[@"content"] = content;
    parameter[@"status"] = status;
    [YKHttpRequestTools apiRequestForPostWithApi:YKAPICommentReply parameters:parameter
                                         success:^(id responseObject) {
                                             success();
                                         }
                                         failure:^(NSString *error) {
                                             failure(error);
                                         }];
}

+ (void)commentAddPraiseWithCommentId:(NSString *)commentId
                             toUserId:(NSString *)toUserId
                               status:(NSString *)status success:(void (^)())success
                              failure:(void (^)(NSString *error))failure {
    NSMutableDictionary *parameter = @{}.mutableCopy;
    parameter[@"userId"] = [YKUserTools getUserId];;
    parameter[@"commentId"] = commentId;
    parameter[@"toUserId"] = toUserId;
    parameter[@"status"] = status;
    [YKHttpRequestTools apiRequestForPostWithApi:YKAPICommentAddPraise parameters:parameter
                                         success:^(id responseObject) {
                                             success();
                                         }
                                         failure:^(NSString *error) {
                                             failure(error);
                                         }];

}


+ (void)requestVideoListWithtype:(NSString *)type
                         success:(void (^)(YKHomeVideoListModel *homeVideoListModel))success
                         failure:(void (^)(NSString *error))failure {
    NSMutableDictionary *parameter = @{}.mutableCopy;
    parameter[@"type"] = type;
    [YKHttpRequestTools apiRequestForPostWithApi:YKAPIHomePage parameters:parameter
                                         success:^(id responseObject) {
                                             YKHomeVideoListModel *model = [[YKHomeVideoListModel alloc]
                                                     initWithDictionary:responseObject error:nil];
                                             success(model);
                                         }
                                         failure:^(NSString *error) {
                                             failure(error);
                                         }];
}

+ (void)requestGuessYouLikeListWithSuccess:(void (^)(YKHomeVideoListModel *homeVideoListModel))success
                                   failure:(void (^)(NSString *error))failure {
    [self requestVideoListWithtype:@"2" success:success failure:failure];
}

+ (void)requestHomePageWithSuccess:(void (^)(YKHomeVideoListModel *homeVideoListModel))success
                           failure:(void (^)(NSString *error))failure {
    [self requestVideoListWithtype:@"1" success:success failure:failure];
}


+ (void)requestLiveListWithSuccess:(void (^)(
        NSMutableArray <YKHomeVideoListDataDataModel> *isPlayVideoDataArray,
        NSMutableArray <YKHomeVideoListDataDataModel> *willPlayVideoDataArray))success
                           failure:(void (^)(NSString *error))failure {
    [self requestVideoListWithtype:@"100"
                           success:^(YKHomeVideoListModel *homeVideoListModel) {
                               NSMutableArray <YKHomeVideoListDataDataModel> *isPlayVideoDataArray = @[].mutableCopy;
                               NSMutableArray <YKHomeVideoListDataDataModel> *willPlayVideoDataArray = @[].mutableCopy;
                               YKHomeVideoListDataModel *model = homeVideoListModel.data[0];
                               int a = 0;
                               for (YKHomeVideoListDataDataModel *homeVideoListDataDataModel in model.data) {
                                   // 4:正在   2:将要
//                                   if ([homeVideoListDataDataModel.type intValue] == 2) {
//                                       [willPlayVideoDataArray addObject:homeVideoListDataDataModel];
//                                   } else if ([homeVideoListDataDataModel.type intValue] == 4) {
//                                       [isPlayVideoDataArray addObject:homeVideoListDataDataModel];
//                                   }
                                   if (a > 1) {
                                       homeVideoListDataDataModel.sectionHeadTitle = @"将要";
                                       [willPlayVideoDataArray addObject:homeVideoListDataDataModel];
                                   } else {
                                       homeVideoListDataDataModel.sectionHeadTitle = @"正在";
                                       [isPlayVideoDataArray addObject:homeVideoListDataDataModel];
                                   }
                                   a++;
                               }
                               success(isPlayVideoDataArray, willPlayVideoDataArray);
                           }
                           failure:failure];
}

+ (void)requestProjectListWithSuccess:(void (^)(YKProjectListModel *projectListModel))success
                              failure:(void (^)(NSString *error))failure {
    NSMutableDictionary *parameter = @{}.mutableCopy;
    [YKHttpRequestTools apiRequestForPostWithApi:YKAPIProjectList parameters:parameter
                                         success:^(id responseObject) {
                                             YKProjectListModel *model = [[YKProjectListModel alloc]
                                                     initWithDictionary:responseObject error:nil];
                                             success(model);
                                         }
                                         failure:^(NSString *error) {
                                             failure(error);
                                         }];
}

//排行  今日排行&本月排行
+ (void)requestTodayRankWithSuccess:(void (^)(YKRankListModel *rankListModel))success
                            failure:(void (^)(NSString *error))failure {
    NSMutableDictionary *parameter = @{}.mutableCopy;
    parameter[@"type"] = @"1";
    [YKHttpRequestTools apiRequestForPostWithApi:YKAPIRankList parameters:parameter
                                         success:^(id responseObject) {
                                             YKRankListModel *model = [[YKRankListModel alloc]
                                                     initWithDictionary:responseObject error:nil];
                                             success(model);
                                         }
                                         failure:^(NSString *error) {
                                             failure(error);
                                         }];
}

+ (void)requestMonthRankWithSuccess:(void (^)(YKRankListModel *rankListModel))success
                            failure:(void (^)(NSString *error))failure {
    NSMutableDictionary *parameter = @{}.mutableCopy;
    parameter[@"type"] = @"2";
    [YKHttpRequestTools apiRequestForPostWithApi:YKAPIRankList parameters:parameter
                                         success:^(id responseObject) {
                                             YKRankListModel *model = [[YKRankListModel alloc]
                                                     initWithDictionary:responseObject error:nil];
                                             success(model);
                                         }
                                         failure:^(NSString *error) {
                                             failure(error);
                                         }];
}



//视频详情—时间，地点，类型，标签，详情
#pragma mark ----- 视频详情—时间，地点，类型，标签，详情

+ (void)requestVideoDetailWithAlbumId:(NSString *)albumId
                              success:(void (^)(YKVideoDetailData *videoDetailData))success
                              failure:(void (^)(NSString *error))failure {
    NSMutableDictionary *parameter = @{}.mutableCopy;
    parameter[@"videoId"] = albumId;
    [YKHttpRequestTools apiRequestForPostWithApi:YKAPIVideoDetail parameters:parameter
                                         success:^(id responseObject) {
                                             NSLog(@"详情 = %@", responseObject);
                                             YKVideoDetailModel *model = [[YKVideoDetailModel alloc]
                                                     initWithDictionary:responseObject error:nil];
                                             success(model.data);
                                         }
                                         failure:^(NSString *error) {
                                             failure(error);
                                         }];
}

//  专题详情
+ (void)requestAlbumDetailWithAlbumId:(NSString *)albumId
                              success:(void (^)(YKAlbumDetailModel *albumDetailModel))success
                              failure:(void (^)(NSString *error))failure {
    NSMutableDictionary *parameter = @{}.mutableCopy;
    parameter[@"albumId"] = albumId;
    parameter[@"filter"] = @"latestVideo,name,videoPlayInfo,videoId,videoUrl,standardPic";
    [YKHttpRequestTools apiRequestForPostWithApi:YKAPIAlbumDetail parameters:parameter
                                         success:^(id responseObject) {
                                             YKAlbumDetailModel *model = [[YKAlbumDetailModel alloc]
                                                     initWithDictionary:responseObject error:nil];
                                             success(model);
                                         }
                                         failure:^(NSString *error) {
                                             failure(error);
                                         }];
}

+ (void)requestAlbumVideoListWithAlbumId:(NSString *)albumId
                                 success:(void (^)(YKAlbumVideoListMolel *albumVideoListMolel))success
                                 failure:(void (^)(NSString *error))failure {
    NSMutableDictionary *parameter = @{}.mutableCopy;
    parameter[@"albumId"] = albumId;
    [YKHttpRequestTools apiRequestForPostWithApi:YKAPIAIQueryAllVideoList parameters:parameter
                                         success:^(id responseObject) {
                                             YKAlbumVideoListMolel *model = [[YKAlbumVideoListMolel alloc]
                                                     initWithDictionary:responseObject error:nil];
                                             success(model);
                                         }
                                         failure:^(NSString *error) {
                                             failure(error);
                                         }];
}


//探索页面
+ (void)requestExploreListWithSuccess:(void (^)(YKExploreListModel *exploreListModel))success
                              failure:(void (^)(NSString *error))failure {
    NSMutableDictionary *parameter = @{}.mutableCopy;
    [YKHttpRequestTools apiRequestForPostWithApi:YKAPIAIExplorationList parameters:parameter
                                         success:^(id responseObject) {
                                             YKExploreListModel *model = [[YKExploreListModel alloc]
                                                     initWithDictionary:responseObject error:nil];
                                             success(model);
                                         }
                                         failure:^(NSString *error) {
                                             failure(error);
                                         }];
}


+ (void)searchVideoWithKeyWord:(NSString *)keyWord
                       success:(void (^)(NSArray <YKSearchListDataVideoList> *videoList))success
                       failure:(void (^)(NSString *error))failure {
    NSMutableDictionary *parameter = @{}.mutableCopy;
    parameter[@"keywords"] = keyWord;
    [YKHttpRequestTools apiRequestForPostWithApi:YKAPIAISearchList parameters:parameter
                                         success:^(id responseObject) {
                                             YKSearchListModel *model = [[YKSearchListModel alloc]
                                                     initWithDictionary:responseObject error:nil];
                                             success(model.data.videoList);
                                         }
                                         failure:^(NSString *error) {
                                             failure(error);
                                         }];
}

+ (void)updatePasswordWithPhone:(NSString *)phone
                           code:(NSString *)code
                       password:(NSString *)password
                        success:(void (^)())success
                        failure:(void (^)(NSString *error))failure {
    NSMutableDictionary *parameter = @{}.mutableCopy;
    parameter[@"code"] = code;
    parameter[@"password"] = [MD5 encryptionStr:password];
    parameter[@"mobile"] = phone;
    [YKHttpRequestTools apiRequestForPostWithApi:YKAPIAIUpdatePassword parameters:parameter
                                         success:^(id responseObject) {
                                             NSLog(@"responseObject = %@", responseObject);
                                             success();
                                         }
                                         failure:^(NSString *error) {
                                             failure(error);
                                         }];
}

#pragma mark ----首页上半部分的广告展示，几个图的切换

+ (void)requestHomeAdWithsuccess:(void (^)(YKHomeAdModel *homeAdModel))success
                         failure:(void (^)(NSString *error))failure {
    NSMutableDictionary *parameter = @{}.mutableCopy;
    parameter[@"type"] = @"1";
    [YKHttpRequestTools apiRequestForPostWithApi:YKAPIHomeAd parameters:parameter
                                         success:^(id responseObject) {
                                             NSLog(@"responseObject = %@", responseObject);
                                             YKHomeAdModel *model = [[YKHomeAdModel alloc]
                                                     initWithDictionary:responseObject error:nil];
                                             success(model);
                                         }
                                         failure:^(NSString *error) {
                                             failure(error);
                                         }];
}

+ (void)requestHotSearchKeyWordWithsuccess:(void (^)(YKHotSearchKeyWordModel *hotSearchKeyWordModel))success
                                   failure:(void (^)(NSString *error))failure {
    NSMutableDictionary *parameter = @{}.mutableCopy;
    [YKHttpRequestTools apiRequestForPostWithApi:YKAPIHotSearch parameters:parameter
                                         success:^(id responseObject) {
                                             YKHotSearchKeyWordModel *model = [[YKHotSearchKeyWordModel alloc]
                                                     initWithDictionary:responseObject error:nil];
                                             success(model);
                                         }
                                         failure:^(NSString *error) {
                                             failure(error);
                                         }];
}

+ (void)changeUserNickNameWithName:(NSString *)name
                           success:(void (^)(YKUserModel *userModel))success
                           failure:(void (^)(NSString *error))failure {
    NSMutableDictionary *parameter = @{}.mutableCopy;
    parameter[@"userId"] = [YKUserTools getUserId];
    parameter[@"username"] = name;
    [YKHttpRequestTools apiRequestForPostWithApi:YKAPIUpdateUserInfo parameters:parameter
                                         success:^(id responseObject) {
                                             YKUserModel *userModel = [[YKUserModel alloc]
                                                     initWithDictionary:responseObject error:nil];
                                             [YKUserTools savaUserInfoWithJsonString:responseObject];
                                             success(userModel);
                                         }
                                         failure:^(NSString *error) {
                                             failure(error);
                                         }];
}

+ (void)changeUserPicWithUrl:(NSString *)url
                     success:(void (^)(YKUserModel *userModel))success
                     failure:(void (^)(NSString *error))failure {
    NSMutableDictionary *parameter = @{}.mutableCopy;
    parameter[@"userId"] = [YKUserTools getUserId];
    parameter[@"face_url"] = url;
    [YKHttpRequestTools apiRequestForPostWithApi:YKAPIUpdateUserInfo parameters:parameter
                                         success:^(id responseObject) {
                                             YKUserModel *userModel = [[YKUserModel alloc]
                                                     initWithDictionary:responseObject error:nil];
                                             [YKUserTools savaUserInfoWithJsonString:responseObject];
                                             success(userModel);
                                         }
                                         failure:^(NSString *error) {
                                             failure(error);
                                         }];
}

+ (void)requestCollectionListWithSuccess:(void (^)(YKCollectionListModel *collectionListModel))success
                                 failure:(void (^)(NSString *error))failure {
    NSMutableDictionary *parameter = @{}.mutableCopy;
    parameter[@"userId"] = [YKUserTools getUserId];
    parameter[@"size"] = @"100";
    [YKHttpRequestTools apiRequestForPostWithApi:YKAPICollectionList parameters:parameter
                                         success:^(id responseObject) {
                                             YKCollectionListModel *userModel = [[YKCollectionListModel alloc]
                                                     initWithDictionary:responseObject error:nil];
                                             success(userModel);
                                         }
                                         failure:^(NSString *error) {
                                             failure(error);
                                         }];
}

+ (void)checkVersion {
    NSMutableDictionary *parameter = @{}.mutableCopy;
    [YKHttpRequestTools apiRequestForPostWithApi:YKAPICheckVersion parameters:parameter
                                         success:^(id responseObject) {
                                             NSLog(@"responseObject = %@", responseObject);
                                             YKCheckVersionModel *checkVersionModel = [[YKCheckVersionModel alloc]
                                                     initWithDictionary:responseObject error:nil];
                                             [checkVersionModel checkVersion];
                                         }
                                         failure:^(NSString *error) {
                                             NSLog(@"error = %@", error);
                                         }];
}

+ (void)checkCollectionWithVideoId:(NSString *)videoId
                           success:(void (^)())success
                           failure:(void (^)(NSString *error))failure {
    NSMutableDictionary *parameter = @{}.mutableCopy;
    parameter[@"userId"] = [YKUserTools getUserId];
    parameter[@"videoId"] = videoId;
    NSLog(@"videoId = %@", videoId);
    [YKHttpRequestTools apiRequestForPostWithApi:YKAPICheckCollection parameters:parameter
                                         success:^(id responseObject) {
                                             success();
                                         }
                                         failure:^(NSString *error) {
                                             failure(error);
                                         }];
}

+ (void)userApplyWithVideoId:(NSString *)videoId
                     success:(void (^)())success
                     failure:(void (^)(NSString *error))failure {
    NSMutableDictionary *parameter = @{}.mutableCopy;
    parameter[@"userId"] = [YKUserTools getUserId];
    parameter[@"userName"] = [YKUserTools getUserInfo].userName;
    parameter[@"mobile"] = [YKUserTools getUserInfo].mobile;
    parameter[@"videoId"] = videoId;
    [YKHttpRequestTools apiRequestForPostWithApi:YKAPIUserSignup parameters:parameter
                                         success:^(id responseObject) {
                                             success();
                                         }
                                         failure:^(NSString *error) {
                                             failure(error);
                                         }];
}

// 用户关注视频
+ (void)userFocusOnWithVideoId:(NSString *)videoId
                       success:(void (^)())success
                       failure:(void (^)(NSString *error))failure {
    NSMutableDictionary *parameter = @{}.mutableCopy;
    parameter[@"userId"] = [YKUserTools getUserId];
    parameter[@"resourceId"] = videoId;
    [YKHttpRequestTools apiRequestForPostWithApi:YKAPIUserdo parameters:parameter
                                         success:^(id responseObject) {
                                             success();
                                         }
                                         failure:^(NSString *error) {
                                             failure(error);
                                         }];
}

+ (void)userUnFocusOnWithVideoId:(NSString *)videoId
                         success:(void (^)())success
                         failure:(void (^)(NSString *error))failure {
    NSMutableDictionary *parameter = @{}.mutableCopy;
    parameter[@"userId"] = [YKUserTools getUserId];
    parameter[@"resourceId"] = videoId;// videoId --> resourceId  
    [YKHttpRequestTools apiRequestForPostWithApi:YKAPIUserundo parameters:parameter
                                         success:^(id responseObject) {
                                             success();
                                         }
                                         failure:^(NSString *error) {
                                             failure(error);
                                         }];
}

+ (void)requestAttentionListWithVideoId:(NSString *)videoId
                                success:(void (^)(NSArray <YKAttentionListData> *data))success
                                failure:(void (^)(NSString *error))failure {
    NSMutableDictionary *parameter = @{}.mutableCopy;
    parameter[@"resourceId"] = videoId;
    parameter[@"size"] = @"1000";
    parameter[@"status"] = @"1";
    parameter[@"page"] = @"1";
    [YKHttpRequestTools apiRequestForPostWithApi:YKAPIAttentionList parameters:parameter
                                         success:^(id responseObject) {

                                             YKAttentionListModel *model = [[YKAttentionListModel alloc]
                                                     initWithDictionary:responseObject
                                                                  error:nil];
                                             success(model.data);
                                         }
                                         failure:^(NSString *error) {
                                             failure(error);
                                         }];
}

+ (void)requestListenToMeWithsuccess:(void (^)(NSArray <YKListenToMeData> *data))success
                             failure:(void (^)(NSString *error))failure{
    
    NSMutableDictionary *parameter = @{}.mutableCopy;
    [YKHttpRequestTools apiRequestForPostWithApi:YKAPIAIListenToMe parameters:parameter
                                         success:^(id responseObject) {
                                             YKListenToMeModel * model = [[YKListenToMeModel alloc] initWithDictionary:responseObject error:nil];
                                             success(model.data);
                                         }
                                         failure:^(NSString *error) {
                                             failure(error);
                                         }];
    
}
@end