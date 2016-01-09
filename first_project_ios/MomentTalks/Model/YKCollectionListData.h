//
// Created by 杨虎 on 15/8/11.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@protocol YKCollectionListData
@end

@interface YKCollectionListData : JSONModel
@property(nonatomic, copy) NSString <Optional> *albumId;
@property(nonatomic, copy) NSString <Optional> *albumName;
@property(nonatomic, copy) NSString <Optional> *collectionTime;
@property(nonatomic, copy) NSString <Optional> *userId;
@property(nonatomic, copy) NSString <Optional> *videoId;
@property(nonatomic, copy) NSString <Optional> *videoName;
@property(nonatomic, copy) NSString <Optional> *videoPic;
@property(nonatomic, copy) NSString <Optional> *viewCount;
@end