//
// Created by 杨虎 on 15/8/25.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKBaseRequsetListDataModel.h"
#import "YKAttentionListData.h"

@interface YKAttentionListModel : YKBaseRequsetDataModel
@property(nonatomic, strong) NSArray <YKAttentionListData, Optional> *data;
@end