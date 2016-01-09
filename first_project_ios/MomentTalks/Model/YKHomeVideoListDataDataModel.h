//
// Created by 杨虎 on 15/8/4.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@protocol YKHomeVideoListDataDataModel
@end

@interface YKHomeVideoListDataDataModel : JSONModel
@property(nonatomic, copy) NSString <Optional> *name;
// 4:正在   2:将要
@property(nonatomic, copy) NSString <Optional> *type;
@property(nonatomic, copy) NSString <Optional> *category;
@property(nonatomic, copy) NSString <Optional> *pic;
@property(nonatomic, copy) NSString <Optional> *albumId;
@property(nonatomic, copy) NSString <Optional> *videoId;
@property(nonatomic, copy) NSString <Optional> *url;
@property(nonatomic, copy) NSString <Optional> *showtime;
@property(nonatomic, copy) NSString <Optional> *isSubscribe;
@property(nonatomic, copy) NSString <Optional> *sectionHeadTitle;
@property(nonatomic, copy) NSString <Optional> *viewCount;
@property(nonatomic, copy) NSString <Optional> *likeCount;
@property(nonatomic, copy) NSString <Optional> *videoDetailUrl;
@end