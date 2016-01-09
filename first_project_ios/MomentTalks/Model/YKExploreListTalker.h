//
// Created by 杨虎 on 15/8/12.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@protocol YKExploreListTalker
@end

@interface YKExploreListTalker : JSONModel
@property(nonatomic, copy) NSString <Optional> *name;
@property(nonatomic, copy) NSString <Optional> *points;
@property(nonatomic, copy) NSString <Optional> *image;
@property(nonatomic, copy) NSString <Optional> *talkerListUrl;
@end