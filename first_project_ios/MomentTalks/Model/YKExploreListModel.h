//
// Created by 杨虎 on 15/8/6.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKBaseRequsetDataModel.h"
#import "YKExploreListInfo.h"
#import "YKExploreListTalker.h"

@interface YKExploreListModel : YKBaseRequsetDataModel
@property(nonatomic, strong) NSArray <YKExploreListInfo, Optional> *info;
@property(nonatomic, strong) YKExploreListTalker *talker;
@end