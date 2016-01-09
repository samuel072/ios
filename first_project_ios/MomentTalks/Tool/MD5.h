//
//  MD5.h
//  CmsTopMediaCloud
//
//  Created by YangHu on 15/3/2.
//  Copyright (c) 2015年 CmsTop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MD5 : NSObject

/**
*  字符串MD5加密
*
*  @param str 需要加密字符串
*
*/
+ (NSString *)encryptionStr:(NSString *)str;

@end
