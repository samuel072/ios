//
// Created by 杨虎 on 15/8/4.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKBaseRequsetListDataModel.h"
#import "YKRankListData.h"


@interface YKRankListModel : YKBaseRequsetListDataModel
@property(nonatomic, strong) NSArray <YKRankListData, Optional> *data;
@end