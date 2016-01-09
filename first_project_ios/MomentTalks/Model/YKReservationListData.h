//
// Created by 杨虎 on 15/8/3.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@protocol YKReservationListData
@end

@interface YKReservationListData : JSONModel
@property(nonatomic, copy) NSString <Optional> *albumId;
@property(nonatomic, copy) NSString <Optional> *albumName;
@property(nonatomic, copy) NSString <Optional> *buildTime;
@property(nonatomic, copy) NSString <Optional> *userId;
@property(nonatomic, copy) NSString <Optional> *id;
@end
