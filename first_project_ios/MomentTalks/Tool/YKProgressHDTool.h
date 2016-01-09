//
//  YKProgressHDTool.h
//  CmsTopMediaCloud
//
//  Created by bilbo on 15/7/31.
//  Copyright (c) 2015年 CmsTop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YKProgressHDTool : NSObject
/**
*  展示加载状态
*/
+ (void)showProgressHUD;

/**
*  隐藏加载状态
*/
+ (void)hideProgressHUD;

/**
*  展示带文字的加载状态
*/
+ (void)showProgressWithTitle:(NSString *)title;

/**
*  展示提示信息
*/
+ (void)reminderWithTitle:(NSString *)title;
@end
