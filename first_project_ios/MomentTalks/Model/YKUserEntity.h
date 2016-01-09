//
// Created by 杨虎 on 15/8/7.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@protocol YKUserEntity
@end

@interface YKUserEntity : JSONModel
@property(nonatomic, copy) NSString <Optional> *userName;
@property(nonatomic, copy) NSString <Optional> *faceUrl;
@property(nonatomic, copy) NSString <Optional> *email;
@property(nonatomic, copy) NSString <Optional> *mobile;
@property(nonatomic, copy) NSString <Optional> *sex;
@property(nonatomic, copy) NSString <Optional> *rongcloudToken;
@property(nonatomic, copy) NSString <Optional> *userId;
@end