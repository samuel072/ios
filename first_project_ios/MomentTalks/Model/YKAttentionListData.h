//
// Created by 杨虎 on 15/8/25.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@protocol YKAttentionListData
@end

@interface YKAttentionListData : JSONModel

@property(nonatomic, copy) NSString <Optional> *faceUrl;
@end