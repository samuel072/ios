//
// Created by 杨虎 on 15/8/9.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKBaseRequsetListDataModel.h"
#import "YKHomeAdData.h"

@interface YKHomeAdModel : YKBaseRequsetListDataModel
@property(nonatomic, strong) NSArray <YKHomeAdData, Optional> *data;
@end