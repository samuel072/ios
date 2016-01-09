//
// Created by 杨虎 on 15/8/7.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
#import "YKBaseRequsetDataModel.h"
#import "YKUserEntity.h"

@interface YKUserModel : YKBaseRequsetDataModel
@property(nonatomic, strong) YKUserEntity *userEntity;
@end