//
// Created by 杨虎 on 15/8/6.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@protocol YKExploreListInfoInfoTime
@end

@interface YKExploreListInfoInfoTime : JSONModel
@property(nonatomic, copy) NSString<Optional> *date;
@property(nonatomic, copy) NSString<Optional> *day;
@property(nonatomic, copy) NSString<Optional> *hours;
@property(nonatomic, copy) NSString<Optional> *minutes;
@property(nonatomic, copy) NSString<Optional> *month;
@property(nonatomic, copy) NSString<Optional> *seconds;
@property(nonatomic, copy) NSString<Optional> *time;
@property(nonatomic, copy) NSString<Optional> *timezoneOffset;
@property(nonatomic, copy) NSString<Optional> *year;
@end