//
// Created by 杨虎 on 15/8/11.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKBaseRequsetListDataModel.h"
#import "YKCollectionListData.h"


@interface YKCollectionListModel : YKBaseRequsetListDataModel
@property(nonatomic, strong) NSArray <YKCollectionListData, Optional> *data;
@end