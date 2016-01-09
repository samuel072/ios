//
//  YKColorTools.h
//  MomentTalks
//
//  Created by YangHu on 15/7/29.
//  Copyright (c) 2015年 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YKColorTools : NSObject
/**
*  颜色转化
*
*  @param color 颜色 #23232
*
*  @return 返回颜色
*/
+ (UIColor *)colorWithHexString:(NSString *)color;
@end
