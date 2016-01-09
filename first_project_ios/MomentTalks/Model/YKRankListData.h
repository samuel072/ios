//
// Created by 杨虎 on 15/8/4.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
#import "YKExploreListInfoInfoTime.h"

@protocol YKRankListData
@end

@interface YKRankListData : JSONModel
@property(nonatomic, copy) NSString <Optional> *channelId;
@property(nonatomic, copy) NSString <Optional> *describe;
@property(nonatomic, copy) NSString <Optional> *id;
@property(nonatomic, copy) NSString <Optional> *name;
@property(nonatomic, copy) NSString <Optional> *showTime;
@property(nonatomic, copy) NSString <Optional> *sourceDesc;
@property(nonatomic, copy) NSString <Optional> *type;
@property(nonatomic, copy) NSString <Optional> *typeDesc;
@property(nonatomic, copy) NSString <Optional> *videoId;
@property(nonatomic, copy) NSString <Optional> *videoName;
@property(nonatomic, copy) NSString <Optional> *viewCount;
@property(nonatomic, copy) NSString <Optional> *standardPic;
@property(nonatomic, copy) NSString <Optional> *duration;
@property(nonatomic, copy) NSString <Optional> *starringName;
@property(nonatomic, copy) NSString <Optional> *videoDetailUrl;
@property (nonatomic, strong)YKExploreListInfoInfoTime *time;

@end