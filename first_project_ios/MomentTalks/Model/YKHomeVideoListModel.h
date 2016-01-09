//
// Created by 杨虎 on 15/8/4.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKBaseRequsetListDataModel.h"
#import "YKHomeVideoListDataModel.h"


@interface YKHomeVideoListModel : YKBaseRequsetListDataModel
@property(nonatomic, strong) NSArray <YKHomeVideoListDataModel, Optional> *data;
@end