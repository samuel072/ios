//
// Created by 杨虎 on 15/8/6.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
#import "YKExploreListInfoInfo.h"

@protocol YKExploreListInfo
@end

@interface YKExploreListInfo : JSONModel
@property(nonatomic, copy) NSString <Optional> *name;
@property(nonatomic, copy) NSString <Optional> *listUrl;
@property(nonatomic, assign) int num;
@property(nonatomic, strong) NSArray <YKExploreListInfoInfo, Optional> *info;
@end