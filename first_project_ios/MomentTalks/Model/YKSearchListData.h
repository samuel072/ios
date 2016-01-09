//
// Created by 杨虎 on 15/8/6.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
#import "YKSearchListDataVideoList.h"

@protocol YKSearchListData
@end

@interface YKSearchListData : JSONModel
@property(nonatomic, strong) NSArray <YKSearchListDataVideoList, Optional> *videoList;
@property(nonatomic, strong) NSArray <YKSearchListDataVideoList, Optional> *albumList;
@end