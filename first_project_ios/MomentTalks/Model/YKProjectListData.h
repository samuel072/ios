//
// Created by 杨虎 on 15/8/4.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@protocol YKProjectListData
@end

@interface YKProjectListData : JSONModel
@property(nonatomic, copy) NSString <Optional> *name;
@property(nonatomic, copy) NSString <Optional> *standardPic;
@property(nonatomic, copy) NSString <Optional> *id;
@property(nonatomic, copy) NSString <Optional> *url;
@property(nonatomic, copy) NSString <Optional> *type;
@property(nonatomic, copy) NSString <Optional> *albumId;
@property(nonatomic, copy) NSString <Optional> *videoId;
@property(nonatomic, copy) NSString <Optional> *targetId;
@end