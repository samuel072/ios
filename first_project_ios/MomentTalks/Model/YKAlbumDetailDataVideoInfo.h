//
// Created by 杨虎 on 15/8/6.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@protocol YKAlbumDetailDataVideoInfo
@end

@interface YKAlbumDetailDataVideoInfo : JSONModel
@property(nonatomic, copy) NSString <Optional> *videoId;
@property(nonatomic, copy) NSString <Optional> *videoUrl;
@property(nonatomic, copy) NSString <Optional> *thumbnail;
@end