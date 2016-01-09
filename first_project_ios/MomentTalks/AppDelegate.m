//
//  AppDelegate.m
//  MomentTalks
//
//  Created by YangHu on 15/7/29.
//  Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//


#import "YKExploreViewController.h"
#import "YKHomeViewController.h"
#import "YKRankViewController.h"
#import "YKLiveViewController.h"
#import "YKBaseNavigationController.h"
#import "RDVTabBarItem.h"


#define kShareSDKKey  @"9492974944d2"
#define kShareSDKSecret  @"ceac0a2203c0371d287a97de13d33715"
#define kWeChatKey  @"wx9bc1eb80f65c4279"
#define kWeChatSecret  @"a35f69da5210287f36f1f9584fd6cdd4"

#define kSinaKey    @"3417876944"
#define kSinaSectet @"ab15206ef545e0207f43aabeed646518"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // 设置状态栏为白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

////启动页上停留5秒
//    [NSThread sleepForTimeInterval:4];
    

    [UITabBar appearance].barTintColor = [UIColor whiteColor];
    // 状态栏栏颜色
    [[UINavigationBar appearance] setBarTintColor:YKThemeColor];

    YKExploreViewController *exploreViewController = [[YKExploreViewController alloc] init];

    YKHomeViewController *homeViewController = [[YKHomeViewController alloc] init];

    YKProjectViewController *projectViewController = [[YKProjectViewController alloc] init];

    YKRankViewController *rankViewController = [[YKRankViewController alloc] init];

    YKLiveViewController *liveViewController = [[YKLiveViewController alloc] init];

    self.tabBarController = [[RDVTabBarController alloc] init];


    self.tabBarController.viewControllers = @[
            [[YKBaseNavigationController alloc] initWithRootViewController:homeViewController],
            [[YKBaseNavigationController alloc] initWithRootViewController:liveViewController],
            [[YKBaseNavigationController alloc] initWithRootViewController:exploreViewController],
            [[YKBaseNavigationController alloc] initWithRootViewController:rankViewController],
            [[YKBaseNavigationController alloc] initWithRootViewController:projectViewController]];


    RDVTabBar *tabBar = [self.tabBarController tabBar];
    [tabBar setFrame:CGRectMake(CGRectGetMinX(tabBar.frame), CGRectGetMinY(tabBar.frame), CGRectGetWidth(tabBar.frame), 49)];
    NSArray *tabBarItemImages = @[@"TabBarHomeIcon", @"TabBarLiveIcon", @"TabBarExploreIcon", @"TabBarRankIcon", @"TabBarProjectIcon"];
    NSArray *tabBarItemSelectImages = @[@"TabBarHomePressIcon", @"TabBarLivePressIcon", @"TabBarExplorePressIcon", @"TabBarRankPressIcon", @"TabBarProjectPressIcon"];
    NSArray *tabBarItemTitle = @[@"首页", @"直播", @"探索", @"排行", @"专题"];
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[self.tabBarController tabBar] items]) {
        [item setBackgroundColor:[UIColor whiteColor]];
        // 设置图片
        UIImage *selectedImage = [UIImage imageNamed:tabBarItemSelectImages[index]];
        UIImage *unselectedImage = [UIImage imageNamed:tabBarItemImages[index]];
        [item setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:unselectedImage];
        item.title = tabBarItemTitle[index];
        // 设置文字风格
        item.selectedTitleAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:11],
                NSForegroundColorAttributeName : YKThemeColor};
        item.unselectedTitleAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:11],
                NSForegroundColorAttributeName : [UIColor blackColor]};
        // 调整Title位置
        UIOffset offset;
        offset.horizontal = 0.0;
        offset.vertical = 3;
        item.titlePositionAdjustment = offset;
        index++;
    }
    [ShareSDK registerApp:kShareSDKKey];
    [self ResignShareSDK];
//    [WXApi registerApp:kWeChatKey withDescription:@"微信登录"];

    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];



    NSDate *date = [NSDate date];
    NSTimeInterval timeStamp= [date timeIntervalSince1970];
    NSLog(@"日期转换为时间戳 %@ = %f", date, timeStamp);


    return YES;
}


- (void)ResignShareSDK {
    [ShareSDK connectSinaWeiboWithAppKey:kSinaKey
                               appSecret:kSinaSectet
                             redirectUri:@"http://www.sharesdk.cn"];
    //当使用新浪微博客户端分享的时候需要按照下面的方法来初始化新浪的平台
    [ShareSDK connectSinaWeiboWithAppKey:kSinaKey
                               appSecret:kSinaSectet
                             redirectUri:@"http://www.sharesdk.cn"
                             weiboSDKCls:[WeiboSDK class]];

    //添加QQ应用  注册网址  http://open.qq.com/
    [ShareSDK connectQQWithQZoneAppKey:@"1104732199"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];

    //添加微信应用 注册网址 http://open.weixin.qq.com
    [ShareSDK connectWeChatWithAppId:kWeChatKey
                           wechatCls:[WXApi class]];

    [ShareSDK connectWeChatWithAppId:kWeChatKey
                           appSecret:kWeChatSecret
                           wechatCls:[WXApi class]];

    [ShareSDK connectQQWithAppId:@"100371282" qqApiCls:[QQApi class]];


}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {

    return [ShareSDK handleOpenURL:url wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [ShareSDK handleOpenURL:url
          sourceApplication:sourceApplication
                 annotation:annotation
                 wxDelegate:self];
    [WXApi handleOpenURL:url delegate:self];
    return [TencentOAuth HandleOpenURL:url];
}

- (void)onResp:(BaseResp *)resp {
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        if (resp.errCode == 0) {
            /* ERR_OK = 0(用户同意)
             ERR_AUTH_DENIED = -4（用户拒绝授权）
             ERR_USER_CANCEL = -2（用户取消）*/

            SendAuthResp *auth = (SendAuthResp *) resp;
            NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code", kWeChatKey, kWeChatSecret, auth.code];
            [YKApiRequestServer wechatGetRequstDataWithUrl:url success:^(id responseObject) {
                NSString *url2 = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/refresh_token?appid=%@&grant_type=refresh_token&refresh_token=%@", kWeChatKey, [responseObject objectForKey:@"refresh_token"]];
                [YKApiRequestServer wechatGetRequstDataWithUrl:url2 success:^(id responseObject) {
                    NSString *url3 = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@", [responseObject objectForKey:@"access_token"], [responseObject objectForKey:@"openid"]];
                    [YKApiRequestServer wechatGetRequstDataWithUrl:url3 success:^(id responseObject) {
                        NSLog(@"%@", responseObject);
                        [[NSNotificationCenter defaultCenter] postNotificationName:ThirdLoginSuccess object:responseObject];
                    }                                      failure:^(NSError *error) {

                    }];
                }                                      failure:^(NSError *error) {

                }];
            }                                      failure:^(NSError *error) {

            }];
        } else {
            [YKProgressHDTool hideProgressHUD];
        }

    }

}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end