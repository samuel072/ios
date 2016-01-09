//
// Created by 杨虎 on 15/8/11.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKBaseRequsetDataModel.h"
#import "YKCheckVersionData.h"

@interface YKCheckVersionModel : YKBaseRequsetDataModel
@property(nonatomic, strong) YKCheckVersionData *data;

- (void)checkVersion;
@end