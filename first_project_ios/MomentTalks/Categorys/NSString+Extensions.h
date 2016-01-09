//
//  NSString+Extensions.h
//  17Snooker
//
//  Created by LookMedia-China on 14-4-14.
//  Copyright (c) 2014年 LookMedia-China. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extensions)

/**
*  小写
*
*  @return
*/
- (NSString *)lowercaseFirstCharacter;

/**
*  大写
*
*  @return
*/
- (NSString *)uppercaseFirstCharacter;

/**
*  除空
*
*  @return
*/
- (NSString *)trim;

/**
*  是否是有效手机格式
*
*  @return
*/
- (BOOL)isValidMobileNumber;

/**
*  是否是有效邮箱格式
*
*  @param email 邮箱
*
*  @return
*/
- (BOOL)isValidEmail;

/**
*  根据 “211,211,211” 格式生成对应UIColor
*
*  @return 对应颜色
*/
- (UIColor *)toColor;

- (NSURL *)toUrl;


/**
*  判断文字是否为空
*/
- (BOOL)isEmpty;

/**
*  md5加密
*/
- (NSString *)md5;

/**
*  根据字体大计算高度
*
*  @param fontSize 字体大小
*  @param width    控件宽度
*
*  @return 高度
*/
- (CGFloat)heightForSizeWithFont:(UIFont *)fontSize andWidth:(float)width;

/**
*  根据字体大戏计算宽度
*
*  @param fontSize 字体大小
*  @param height   控件高度
*
*  @return 宽度
*/
- (CGFloat)widthForSizeFont:(UIFont *)fontSize andHeight:(float)height;

/**
*  jason字符串转化
*
*  @return 返回的json数据
*/
- (NSDictionary *)jsonValue;
@end
