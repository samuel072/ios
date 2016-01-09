//
// Created by 杨虎 on 15/8/3.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKBaseRequsetDataModel.h"
#import "YKVideoCommentData.h"

@interface YKVideoCommentListModel : YKBaseRequsetDataModel
@property(nonatomic, assign) int praiseCount;
@property(nonatomic, assign) int commentCount;
@property(nonatomic, assign) BOOL isPraise;
@property(nonatomic, strong) NSArray <YKVideoCommentData, Optional> *data;
@end

