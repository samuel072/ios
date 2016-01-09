//
// Created by 杨虎 on 15/8/6.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
#import "YKExploreListInfoInfoTime.h"

@protocol YKExploreListInfoInfo
@end

@interface YKExploreListInfoInfo : JSONModel
@property(nonatomic, copy) NSString<Optional> *address;
@property(nonatomic, copy) NSString<Optional> *categoryId;
@property(nonatomic, copy) NSString<Optional> *isDelete;
@property(nonatomic, copy) NSString<Optional> *id;
@property(nonatomic, copy) NSString<Optional> *isFree;
@property(nonatomic, copy) NSString<Optional> *likeNum;
@property(nonatomic, copy) NSString<Optional> *position;
@property(nonatomic, copy) NSString<Optional> *pv;
@property(nonatomic, strong) YKExploreListInfoInfoTime<Optional> *startTime;
@property(nonatomic, strong) YKExploreListInfoInfoTime<Optional> *endTime;
@property(nonatomic, copy) NSString<Optional> *state;
@property(nonatomic, copy) NSString<Optional> *tagListStr;
@property(nonatomic, copy) NSString<Optional> *thumbnail;
@property(nonatomic, copy) NSString<Optional> *title;
@property(nonatomic, copy) NSString<Optional> *userUuid;
@property(nonatomic, copy) NSString<Optional> *videoId;
@property(nonatomic, copy) NSString<Optional> *videoDetailUrl;
@end