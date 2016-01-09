//
// Created by 杨虎 on 15/8/25.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@protocol YKVideoDetailAlbum
@end

@interface YKVideoDetailAlbum : JSONModel
@property(nonatomic, copy) NSString *showtimes;
@end