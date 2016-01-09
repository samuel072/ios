//
// Created by 杨虎 on 15/8/10.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@protocol YKHotSearchKeyWordDataRow
@end

@interface YKHotSearchKeyWordDataRow : JSONModel
@property(nonatomic, copy) NSString *word;
@property(nonatomic, copy) NSString *count;
@end