//
//  AppDelegate.h
//  MomentTalks
//
//  Created by YangHu on 15/7/29.
//  Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "WeiboSDK.h"
#import "RDVTabBarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, WXApiDelegate, ISSShareViewDelegate>

@property(strong, nonatomic) UIWindow *window;
@property(strong, nonatomic) RDVTabBarController *tabBarController;

@end
