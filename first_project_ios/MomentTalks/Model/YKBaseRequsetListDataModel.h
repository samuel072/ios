//
// Created by 杨虎 on 15/8/4.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKBaseRequsetDataModel.h"


@interface YKBaseRequsetListDataModel : YKBaseRequsetDataModel
@property(nonatomic, assign) int page;
@property(nonatomic, assign) int size;
@property(nonatomic, assign) int total;
@property(nonatomic, copy) NSString <Optional> *timestamp;
@end