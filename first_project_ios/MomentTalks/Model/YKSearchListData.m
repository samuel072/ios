//
// Created by 杨虎 on 15/8/6.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKSearchListData.h"


@implementation YKSearchListData
- (NSArray <YKSearchListDataVideoList> *)videoList {
    NSMutableArray *arrays = @[].mutableCopy;
    [arrays addObjectsFromArray:_videoList];
    [arrays addObjectsFromArray:_albumList];
    return arrays;
}

@end