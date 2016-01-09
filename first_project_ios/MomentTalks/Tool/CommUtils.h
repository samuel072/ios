//
//  CommUtils.h
//  CmsTopMediaCloud
//
//  Created by bilbo on 15/3/17.
//  Copyright (c) 2015年 CmsTop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommUtils : NSObject
/**
*  判断字符串是否为空
*
*  @param str 输入字符串
*
*  @return 返回结果
*/
+ (BOOL)isNull:(NSString *)str;

/**
*  检查邮箱格式
*
*  @param inputText 输入内容
*
*  @return 返回结果
*/
+ (BOOL)checkEmail:(NSString *)inputText;

/**
*  颜色转化
*
*  @param color 颜色 #23232
*
*  @return 返回颜色
*/
+ (UIColor *)colorWithHexString:(NSString *)color;

/**
*  时间转化
*
*  @param d 时间戳
*
*  @return 时间字符串
*/
+ (NSString *)intervalSinceNow:(NSDate *)d;

/**
*  返回天气图标
*
*  @param wid 天气参数
*
*  @return return value description
*/
+ (NSString *)getWeather:(int)wid;

/**
*  判断距离上次刷新是否超过五分钟
*
*  @param viewId 页面id
*
*  @return 返回结果
*/
+ (BOOL)needRefreshByViewId:(NSString *)viewId;

/**
*  检测是否含有特殊符号
*
*  @param str 需要检测的字符串
*
*  @return
*/
+ (BOOL)isIncludeSpecialCharact:(NSString *)str;


/**
获取视频的第一帧图片
*/
+ (UIImage *)generateVideoThumb:(NSString *)videoPath;

@end
