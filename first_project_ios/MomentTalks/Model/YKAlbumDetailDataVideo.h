//
// Created by 杨虎 on 15/8/6.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
#import "YKAlbumDetailDataVideoInfo.h"

@protocol YKAlbumDetailDataVideo
@end

@interface YKAlbumDetailDataVideo : JSONModel
@property(nonatomic, copy) NSString <Optional> *name;
@property(nonatomic, copy) NSString <Optional> *standardPic;
@property(nonatomic, copy) NSString <Optional> *videoId;
@property(nonatomic, strong) YKAlbumDetailDataVideoInfo *videoPlayInfo;
@end