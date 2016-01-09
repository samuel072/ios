//
// Created by 杨虎 on 15/8/2.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKVideoCommentListModel.h"
#import "YKReservationListModel.h"
#import "YKHomeVideoListModel.h"
#import "YKRankListModel.h"
#import "YKAlbumDetailModel.h"
#import "YKAlbumVideoListMolel.h"
#import "YKExploreListModel.h"
#import "YKSearchListDataVideoList.h"
#import "YKUserModel.h"
#import "YKHomeAdModel.h"
#import "YKProjectListModel.h"
#import "YKHotSearchKeyWordModel.h"
#import "YKCollectionListModel.h"
#import "YKVideoDetailModel.h"
#import "YKListenToMeData.h"
#import "YKAttentionListModel.h"

@class YKCheckVersionModel;


@interface YKApiRequestServer : NSObject

/**
*  微信登录请求
*
*  @param requestUrl url
*  @param success    成功回调
*  @param failure    失败回调
*/
+ (void)wechatGetRequstDataWithUrl:(NSString *)requestUrl
                           success:(void (^)(id responseObject))success
                           failure:(void (^)(NSError *error))failure;

/**
*  获取手机验证码
*
*  @param phoneNumble  手机号
*  @param success      成功回调
*  @param failure      失败回调
*/
+ (void)requestMobileCodeWithPhoneNumble:(NSString *)phoneNumble
                                 success:(void (^)(NSString *code))success
                                 failure:(void (^)(NSString *error))failure;

/**
*  用户登录
*
*  @param account  账号
*  @param password 密码
*  @param failure  失败
*/
+ (void)userLoginWithAccount:(NSString *)account
                    password:(NSString *)password
                     success:(void (^)(YKUserModel *userModel))success
                     failure:(void (^)(NSString *error))failure;

/**
*  请求用户信息
*
*  @param success 成功
*  @param failure 失败
*/
+ (void)requestUserInfoWithSuccess:(void (^)(YKUserModel *userModel))success
                           failure:(void (^)(NSString *error))failure;

/**
*  用户注册
*
*  @param account  账号
*  @param password 密码
*  @param code     验证码
*  @param status   status
*  @param failure  失败
*/
+ (void)userRegisterWithAccount:(NSString *)account
                       password:(NSString *)password
                           code:(NSString *)code
                         status:(NSString *)status
                        success:(void (^)(YKUserModel *userModel))success
                        failure:(void (^)(NSString *error))failure;

/**
*  添加收藏
*
*  @param userId  用户ID
*  @param videoId 视频ID
*  @param success 成功
*  @param failure 失败
*/
+ (void)addCollectionWithVideoId:(NSString *)videoId
                         success:(void (^)())success
                         failure:(void (^)(NSString *error))failure;

/**
*  取消收藏
*
*  @param userId  用户ID
*  @param videoId 视频ID
*  @param success 成功
*  @param failure 失败
*/
+ (void)removeCollectionWithVideoId:(NSString *)videoId
                            success:(void (^)())success
                            failure:(void (^)(NSString *error))failure;

/**
*  注销登录
*
*  @param userId  用户ID
*  @param source  source
*  @param token   token
*  @param success 成功
*  @param failure 失败
*/
+ (void)userLogOutWithSuccess:(void (^)())success
                      failure:(void (^)(NSString *error))failure;

/**
*  视频点赞
*
*  @param resourceId 资源ID
*  @param userId     用户ID
*  @param status     status
*  @param success    成功
*  @param failure    失败
*/
+ (void)videoPraiseWithResourceId:(NSString *)resourceId
                           status:(NSString *)status
                          success:(void (^)())success
                          failure:(void (^)(NSString *error))failure;

/**
*  添加评论
*
*  @param resourceId 资源ID
*  @param userId     用户ID
*  @param status     status
*  @param content    内容
*  @param success    成功
*  @param failure    失败
*/
+ (void)addVideoCommentWithResourceId:(NSString *)resourceId
                               status:(NSString *)status
                              content:(NSString *)content
                              success:(void (^)())success
                              failure:(void (^)(NSString *error))failure;

/**
*  获取评论列表
*
*  @param resourceId 资源ID
*  @param size       每页多少条
*  @param status     status
*  @param page       当前页
*  @param success    成功
*  @param failure    失败
*/
+ (void)requestVideoCommentListWithResourceId:(NSString *)resourceId
                                         size:(NSString *)size
                                       status:(NSString *)status
                                         page:(NSString *)page
                                      success:(void (^)(YKVideoCommentListModel *videoCommentListModel))success
                                      failure:(void (^)(NSString *error))failure;

/**
*  获取预约列表
*
*  @param userId  用户ID
*  @param success 成功
*  @param failure 失败
*/
+ (void)requestReservationListWithSuccess:(void (^)(YKReservationListModel *reservationListModel))success
                                  failure:(void (^)(NSString *error))failure;

/**
*  添加预约
*
*  @param userId    用户ID
*  @param albumId   专辑ID
*  @param albumName 专辑名称
*  @param success   成功
*  @param failure   失败
*/
+ (void)addReservationWithAlbumId:(NSString *)albumId
                          success:(void (^)())success
                          failure:(void (^)(NSString *error))failure;

/**
*  取消预约
*
*  @param userId  用户ID
*  @param albumId 专辑ID
*  @param success 成功
*  @param failure 失败
*/
+ (void)removeReservationWithAlbumId:(NSString *)albumId
                             success:(void (^)())success
                             failure:(void (^)(NSString *error))failure;

/**
*  评论回复
*
*  @param userId    用户ID
*  @param commentId 评论ID
*  @param toUserId  需要回复的用户ID
*  @param content   内容
*  @param status    status
*  @param success   成功
*  @param failure   失败
*/
+ (void)commentReplyWithCommentId:(NSString *)commentId
                         toUserId:(NSString *)toUserId
                          content:(NSString *)content
                           status:(NSString *)status
                          success:(void (^)())success
                          failure:(void (^)(NSString *error))failure;

/**
*  评论点赞
*
*  @param userId    用户ID
*  @param commentId 评论ID
*  @param toUserId  需要回复的ID
*  @param status    status
*  @param success   成功
*  @param failure   失败
*/
+ (void)commentAddPraiseWithCommentId:(NSString *)commentId
                             toUserId:(NSString *)toUserId
                               status:(NSString *)status success:(void (^)())success
                              failure:(void (^)(NSString *error))failure;

/**
*  获取首页数据
*
*  @param success 成功
*  @param failure 失败
*/
+ (void)requestHomePageWithSuccess:(void (^)(YKHomeVideoListModel *homeVideoListModel))success
                           failure:(void (^)(NSString *error))failure;

/**
*  获取直播数据
*
*  @param success 成功(正在播放数据，将要播放数据)
*  @param failure 失败
*/
+ (void)requestLiveListWithSuccess:(void (^)(
        NSMutableArray <YKHomeVideoListDataDataModel> *isPlayVideoDataArray,
        NSMutableArray <YKHomeVideoListDataDataModel> *willPlayVideoDataArray))success
                           failure:(void (^)(NSString *error))failure;

/**
*  获取专题数据
*
*  @param success 成功
*  @param failure 失败
*/
+ (void)requestProjectListWithSuccess:(void (^)(YKProjectListModel *projectListModel))success
                              failure:(void (^)(NSString *error))failure;

/**
*  获取今日排行
*
*  @param success 成功
*  @param failure 失败
*/
+ (void)requestTodayRankWithSuccess:(void (^)(YKRankListModel *rankListModel))success
                            failure:(void (^)(NSString *error))failure;

/**
*  获取当月排行
*
*  @param success 成功
*  @param failure 失败
*/
+ (void)requestMonthRankWithSuccess:(void (^)(YKRankListModel *rankListModel))success
                            failure:(void (^)(NSString *error))failure;

/**
*  获取专题详情
*
*  @param albumId 专辑id
*  @param success 成功
*  @param failure 失败
*/
+ (void)requestAlbumDetailWithAlbumId:(NSString *)albumId
                              success:(void (^)(YKAlbumDetailModel *albumDetailModel))success
                              failure:(void (^)(NSString *error))failure;

/**
*  获取视频详情页——视频时间，地点，类型，标签，详情
*
*  @param videoId 专辑id
*  @param success 成功
*  @param failure 失败       YKVideoDetailModel
*/

+ (void)requestVideoDetailWithAlbumId:(NSString *)albumId
                              success:(void (^)(YKVideoDetailData *videoDetailData))success
                              failure:(void (^)(NSString *error))failure;

/**
*  获取视频详情页---能够播放的视频
*
*  @param albumId 专辑id
*  @param success 成功
*  @param failure 失败       YKVideoDetailModel
*/
//+ (void)requestAlbumDetailWithAlbumId:(NSString *)albumId
//                              success:(void (^)(YKAlbumDetailModel *))success failure:(void (^)(NSString *))failure;
//+ (void)requestVideoDetailWithAlbumId:(NSString *)albumId
//                              success:(void (^)())

/**
*  获取专题里的专辑视频
*
*  @param albumId 专辑id
*  @param success 成功
*  @param failure 失败
*/
+ (void)requestAlbumVideoListWithAlbumId:(NSString *)albumId
                                 success:(void (^)(YKAlbumVideoListMolel *albumVideoListMolel))success
                                 failure:(void (^)(NSString *error))failure;

/**
*  获取探索数据
*
*  @param success 成功
*  @param failure 失败
*/
+ (void)requestExploreListWithSuccess:(void (^)(YKExploreListModel *exploreListModel))success
                              failure:(void (^)(NSString *error))failure;

/**
*  获取猜你喜欢数据
*
*  @param success 成功
*  @param failure 失败
*/
+ (void)requestGuessYouLikeListWithSuccess:(void (^)(YKHomeVideoListModel *homeVideoListModel))success
                                   failure:(void (^)(NSString *error))failure;

/**
*  根据关键字查询
*
*  @param keyWord 关键字
*  @param success 成功
*  @param failure 失败
*/
+ (void)searchVideoWithKeyWord:(NSString *)keyWord
                       success:(void (^)(NSArray <YKSearchListDataVideoList> *videoList))success
                       failure:(void (^)(NSString *error))failure;

/**
*  修改密码
*
*  @param phone    手机
*  @param code     验证码
*  @param password 密码
*  @param success  成功
*  @param failure  失败
*/
+ (void)updatePasswordWithPhone:(NSString *)phone
                           code:(NSString *)code
                       password:(NSString *)password
                        success:(void (^)())success
                        failure:(void (^)(NSString *error))failure;

/**
*  请求首页广告
*
*  @param success 成功
*  @param failure 失败
*/
+ (void)requestHomeAdWithsuccess:(void (^)(YKHomeAdModel *homeAdModel))success
                         failure:(void (^)(NSString *error))failure;

/**
*  请求热门搜索
*
*  @param success 成功
*  @param failure 失败
*/
+ (void)requestHotSearchKeyWordWithsuccess:(void (^)(YKHotSearchKeyWordModel *hotSearchKeyWordModel))success
                                   failure:(void (^)(NSString *error))failure;

/**
*  修改用户昵称
*
*  @param url     头像地址
*  @param success 成功
*  @param failure 失败
*/
+ (void)changeUserNickNameWithName:(NSString *)name
                           success:(void (^)(YKUserModel *userModel))success
                           failure:(void (^)(NSString *error))failure;

/**
*  修改用户头像
*
*  @param url     头像地址
*  @param success 成功
*  @param failure 失败
*/
+ (void)changeUserPicWithUrl:(NSString *)url
                     success:(void (^)(YKUserModel *userModel))success
                     failure:(void (^)(NSString *error))failure;

/**
*  收藏列表
*
*  @param success 成功
*  @param failure 失败
*/
+ (void)requestCollectionListWithSuccess:(void (^)(YKCollectionListModel *collectionListModel))success
                                 failure:(void (^)(NSString *error))failure;

/**
*  版本检测
*/
+ (void)checkVersion;

/**
*  检查是否收藏
*
*  @param videoId 视频id
*  @param success 成功
*  @param failure 失败
*/
+ (void)checkCollectionWithVideoId:(NSString *)videoId
                           success:(void (^)())success
                           failure:(void (^)(NSString *error))failure;


/**
*  报名
*
*  @param videoId 视频id
*  @param success 成功
*  @param failure 失败
*/
+ (void)userApplyWithVideoId:(NSString *)videoId
                     success:(void (^)())success
                     failure:(void (^)(NSString *error))failure;

/**
*  关注
*
*  @param videoId 视频id
*  @param success 成功
*  @param failure 事变
*/
+ (void)userFocusOnWithVideoId:(NSString *)videoId
                       success:(void (^)())success
                       failure:(void (^)(NSString *error))failure;

/**
*  取消关注
*
*  @param videoId 视频id
*  @param success 成功
*  @param failure 失败
*/
+ (void)userUnFocusOnWithVideoId:(NSString *)videoId
                         success:(void (^)())success
                         failure:(void (^)(NSString *error))failure;

+ (void)requestAttentionListWithVideoId:(NSString *)videoId
                                success:(void (^)(NSArray <YKAttentionListData> *data))success
                                failure:(void (^)(NSString *error))failure;

+ (void)requestListenToMeWithsuccess:(void (^)(NSArray <YKListenToMeData> *data))success
                             failure:(void (^)(NSString *error))failure;

@end