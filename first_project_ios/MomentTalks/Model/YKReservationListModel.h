//
// Created by 杨虎 on 15/8/3.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKBaseRequsetDataModel.h"
#import "YKReservationListData.h"
#import "YKBaseRequsetListDataModel.h"

@interface YKReservationListModel : YKBaseRequsetListDataModel
@property(nonatomic, strong) NSArray <YKReservationListData, Optional> *data;

@end

