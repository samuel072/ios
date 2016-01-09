//
//  StandardUserUtils.h
//  XinHuaShe
//
//  Created by YangHu on 14-11-15.
//  Copyright (c) 2014年 CmsTop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserStandardTool : NSObject
/**
*  保存
*
*  @param value       值
*  @param defaultName key
*/
+ (void)savaObjectForKey:(id)value key:(NSString *)key;

/**
*  根据key获取
*
*  @param defaultName key
*
*  @return 值
*/
+ (id)getObjForKey:(NSString *)key;

/**
*  根据key清除
*
*  @param defaultName key
*/
+ (void)clearForKey:(NSString *)key;

/**
*  保存一个实体类
*
*  @param entity      实体
*  @param defaultName key
*/
+ (void)savaEntityForKey:(id)entity key:(NSString *)key;
@end
