//
// Created by 杨虎 on 15/8/3.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
#import "YKVideoCommentContent.h"
#import "YKUserEntity.h"

@protocol YKVideoCommentData
@end

@interface YKVideoCommentData : JSONModel
@property(nonatomic, copy) NSString <Optional> *userId;
@property(nonatomic, copy) NSString <Optional> *buildTime;
@property(nonatomic, copy) NSString <Optional> *commentId;
@property(nonatomic, copy) NSString <Optional> *lastUpdateTime;
@property(nonatomic, copy) NSString <Optional> *resourceId;
@property(nonatomic, copy) NSString <Optional> *toUserId;
@property(nonatomic, assign) int praiseCount;
@property(nonatomic, assign) int commentCount;
@property(nonatomic, assign) BOOL isPraise;
@property(nonatomic, strong) YKUserEntity *userEntity;
@property(nonatomic, strong) NSArray <YKVideoCommentContent, Optional> *content;
@end