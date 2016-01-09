//
//  AppMacro.h
//  MomentTalks
//
//  Created by YangHu on 15/7/29.
//  Copyright (c) 2015年 com.yikeyanjiang.tiger. All rights reserved.
//

#ifndef MomentTalks_AppMacro_h
#define MomentTalks_AppMacro_h


#endif

#define ThirdLoginSuccess @"WechatLoginSuccess"
#define iOS6 [[[UIDevice currentDevice]systemVersion] floatValue] < 7.0

#define iOS7 [[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0

#define iOS8 [[[UIDevice currentDevice]systemVersion] floatValue] >= 8.0


#define YKScreenFrame  [[UIScreen mainScreen] bounds]

#define YKScreenFrameH (iOS7?CGRectGetHeight(YKScreenFrame):CGRectGetHeight(YKScreenFrame)-20)

#define YKScreenFrameW CGRectGetWidth(YKScreenFrame)

#define YKScaleNum(num)    YKScreenFrameW / 320.0f * num

#define YKSharedAppDelegate ((AppDelegate*)[[UIApplication sharedApplication] delegate]) //默认Application

//转化颜色
#define YKColorString(color)  [YKColorTools colorWithHexString:color];
#define RGBCOLORA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define YKThemeColor RGBCOLORA(48, 82, 131, 1)

