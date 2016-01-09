//
// Created by 杨虎 on 15/8/6.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKAlbumDetailDataVideoInfo.h"

@protocol YKAlbumVideoListData
@end

@interface YKAlbumVideoListData : JSONModel
@property(nonatomic, copy) NSString <Optional> *videoId;
@property(nonatomic, copy) NSString <Optional> *name;
@property(nonatomic, copy) NSString <Optional> *standardPic;
@property(nonatomic, copy) NSString <Optional> *showTime;
@property(nonatomic, copy) NSString <Optional> *duration;
@property(nonatomic, copy) NSString <Optional> *summary;
@property(nonatomic, strong) YKAlbumDetailDataVideoInfo <Optional> *videoPlayInfo;

- (NSString *)getDurationTime;
@end