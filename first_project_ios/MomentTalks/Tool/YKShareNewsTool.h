//
//  YKShareNewsTool.h
//  CmsTopMediaCloud
//
//  Created by bilbo on 15/3/19.
//  Copyright (c) 2015年 CmsTop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKThirdLoadUserModel.h"

@class MAppDelegate;


@interface YKShareNewsTool : NSObject <ISSShareViewDelegate> {
@private
    MAppDelegate *_appDelegate;
}


/**
*  第三方登入
*
*  @param shareType  登入平台
*  @param objcMethod 登入成功
*/
+ (void)theThirdLoad:(ShareType)shareType :(void (^)(YKThirdLoadUserModel *))objcMethod;


/**
*  注销登录
*/
+ (void)cancelLoginWithType:(ShareType)type;


/**
*  自定义分享内容（直播列表中分享会用到）
*
*  @param title    标题
*  @param summary  内容
*  @param shareUrl url
*  @param imageUrl 缩略图
*  @param success 分享成功回调
*/
+ (void)shareNewsWithTitle:(NSString *)title summary:(NSString *)summary
                  shareUrl:(NSString *)shareUrl
                  imageUrl:(NSString *)imageUrl
                   success:(void (^)(void))success;


+ (void)shareWithTitle:(NSString *)title summary:(NSString *)summary shareUrl:(NSString *)shareUrl imageUrl:(NSString *)imageUrl type:(ShareType)type;

//js 调用分享
+ (void)jsSDKShareWithType:(ShareType)type andData:(NSDictionary *)data;

+ (void)jsSDKShare:(NSDictionary *)data;

@property(nonatomic, retain) TencentOAuth *tencentOAuth;


@end
