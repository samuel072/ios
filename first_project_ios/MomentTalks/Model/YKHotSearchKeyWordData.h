//
// Created by 杨虎 on 15/8/10.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKHotSearchKeyWordDataRow.h"

@protocol YKHotSearchKeyWordData
@end

@interface YKHotSearchKeyWordData : JSONModel
@property(nonatomic, strong) NSArray <YKHotSearchKeyWordDataRow, Optional> *rows;
@end