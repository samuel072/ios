//
//  YKBaseRequsetDataModel.h
//  MomentTalks
//
//  Created by YangHu on 15/8/2.
//  Copyright (c) 2015年 com.yikeyanjiang.tiger. All rights reserved.
//
#import "JSONModel.h"

@interface YKBaseRequsetDataModel : JSONModel
/** 网络请求状态（成功/失败）*/
@property(nonatomic, assign) BOOL status;
/** 接口请求描述 */
@property(nonatomic, copy) NSString *message;
@end
