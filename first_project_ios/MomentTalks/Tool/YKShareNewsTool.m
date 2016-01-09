//
//  YKShareNewsTool.m
//  CmsTopMediaCloud
//
//  Created by bilbo on 15/3/19.
//  Copyright (c) 2015年 CmsTop. All rights reserved.
//

#import "YKShareNewsTool.h"
#import "SDImageCache.h"

@implementation YKShareNewsTool







+ (void)shareWithTitle:(NSString *)title
               summary:(NSString *)summary
              shareUrl:(NSString *)shareUrl
              imageUrl:(NSString *)imageUrl
                  type:(ShareType)type {
    [ShareSDK shareContent:[self getPublishContentWithTitle:title
                                                    summary:summary
                                                   shareUrl:shareUrl
                                                   imageUrl:imageUrl]
                      type:type
               authOptions:[YKShareNewsTool getAuthOptions]
              shareOptions:[YKShareNewsTool getShareOptions]
             statusBarTips:NO
                    result:^(ShareType type, SSResponseState state, id <ISSPlatformShareInfo> statusInfo, id <ICMErrorInfo> error, BOOL end) {
                        if (state == SSResponseStateSuccess) {
                            [YKProgressHDTool reminderWithTitle:@"分享成功!"];
                            NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
                        } else if (state == SSResponseStateFail) {
                            NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                            if ([error errorCode] == -22003) {
                                [YKProgressHDTool reminderWithTitle:@"尚未安装微信!"];
                            } else if ([error errorCode] == -24002) {
                                [YKProgressHDTool reminderWithTitle:@"尚未安装QQ!"];
                            } else if ([error errorCode] == -24003) {
                                [YKProgressHDTool reminderWithTitle:@"当前QQ版本不支持该功能!"];
                            } else if ([error errorCode] == -24003) {
                                [YKProgressHDTool reminderWithTitle:@"当前微信版本不支持该功能!"];
                            } else  {
                                [YKProgressHDTool reminderWithTitle:@"分享失败!"];
                            }
                        }
                    }];
}


+ (id <ISSContent>)getPublishContentWithTitle:(NSString *)title
                                      summary:(NSString *)summary
                                     shareUrl:(NSString *)shareUrl
                                     imageUrl:(NSString *)imageUrl {
    //构造分享内容
    id <ISSContent> publishContent = [ShareSDK content:[NSString stringWithFormat:@"%@ %@", title, shareUrl]
                                        defaultContent:@""
                                                 image:[ShareSDK imageWithUrl:imageUrl]
                                                 title:title
                                                   url:shareUrl
                                           description:summary
                                             mediaType:SSPublishContentMediaTypeNews];

    UIImage *image = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:shareUrl];

    [publishContent addSinaWeiboUnitWithContent:INHERIT_VALUE
                                          image:[ShareSDK pngImageWithImage:image]];

    [publishContent addWeixinSessionUnitWithType:INHERIT_VALUE
                                         content:summary
                                           title:INHERIT_VALUE
                                             url:INHERIT_VALUE
                                           image:INHERIT_VALUE
                                    musicFileUrl:INHERIT_VALUE
                                         extInfo:INHERIT_VALUE
                                        fileData:INHERIT_VALUE
                                    emoticonData:INHERIT_VALUE];

    [publishContent addQQUnitWithType:INHERIT_VALUE content:summary
                                title:INHERIT_VALUE
                                  url:INHERIT_VALUE
                                image:INHERIT_VALUE];



    return publishContent;
}

+ (id <ISSShareOptions>)getShareOptions {
    AppDelegate *app = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    id <ISSShareOptions> shareOptions = [ShareSDK defaultShareOptionsWithTitle:@"内容分享"
                                                               oneKeyShareList:[NSArray defaultOneKeyShareList]
                                                                qqButtonHidden:YES
                                                         wxSessionButtonHidden:YES
                                                        wxTimelineButtonHidden:YES
                                                          showKeyboardOnAppear:NO
                                                             shareViewDelegate:app
                                                           friendsViewDelegate:nil
                                                         picViewerViewDelegate:nil];
    return shareOptions;
}

+ (id <ISSAuthOptions>)getAuthOptions {
    id <ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                          allowCallback:YES
                                                          authViewStyle:SSAuthViewStyleModal
                                                           viewDelegate:nil
                                                authManagerViewDelegate:nil];
    [authOptions setPowerByHidden:YES];

    return authOptions;
}

/**
* 注销第三方登录
*/
+ (void)cancelLoginWithType:(ShareType)type {
    [ShareSDK cancelAuthWithType:type];
}

@end
