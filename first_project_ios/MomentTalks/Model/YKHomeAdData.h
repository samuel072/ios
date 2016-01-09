//
// Created by 杨虎 on 15/8/9.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@protocol YKHomeAdData
@end

@interface YKHomeAdData : JSONModel
@property(nonatomic, copy) NSString <Optional> *id;
@property(nonatomic, copy) NSString <Optional> *bigImage;
@property(nonatomic, copy) NSString <Optional> *smallImage;
@property(nonatomic, copy) NSString <Optional> *type;
@property(nonatomic, copy) NSString <Optional> *platform;
@property(nonatomic, copy) NSString <Optional> *url;
@property(nonatomic, copy) NSString <Optional> *sort;
@property(nonatomic, copy) NSString <Optional> *typeDesc;
@end