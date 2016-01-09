//
// Created by 杨虎 on 15/8/6.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKBaseRequsetListDataModel.h"
#import "YKAlbumVideoListData.h"


@interface YKAlbumVideoListMolel : YKBaseRequsetListDataModel
@property(nonatomic, strong) NSArray <YKAlbumVideoListData, Optional> *data;
@end