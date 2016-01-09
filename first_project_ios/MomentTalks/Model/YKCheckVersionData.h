//
// Created by 杨虎 on 15/8/11.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@protocol YKCheckVersionData
@end

@interface YKCheckVersionData : JSONModel
@property(nonatomic, copy) NSString <Optional> *message;
@property(nonatomic, copy) NSString <Optional> *type;
@property(nonatomic, copy) NSString <Optional> *url;
@property(nonatomic, copy) NSString <Optional> *version;
@end