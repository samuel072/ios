//
// Created by 杨虎 on 15/8/4.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
#import "YKHomeVideoListDataDataModel.h"

@protocol YKHomeVideoListDataModel
@end

@interface YKHomeVideoListDataModel : JSONModel
@property(nonatomic, copy) NSString <Optional> *displayOrder;
@property(nonatomic, copy) NSString <Optional> *focusName;
@property(nonatomic, copy) NSString <Optional> *id;
@property(nonatomic, copy) NSString <Optional> *objectId;
@property(nonatomic, copy) NSString <Optional> *subscribe;
@property(nonatomic, copy) NSString <Optional> *type;
@property(nonatomic, copy) NSString <Optional> *typeDesc;
@property(nonatomic, copy) NSString <Optional> *total;
@property(nonatomic, strong) NSArray <YKHomeVideoListDataDataModel, Optional> *data;
@end