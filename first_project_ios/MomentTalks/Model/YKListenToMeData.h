//
//  YKListenToMeData.h
//  MomentTalks
//
//  Created by YangHu on 15/9/11.
//  Copyright (c) 2015年 com.yikeyanjiang.tiger. All rights reserved.
//

#import "JSONModel.h"
@protocol YKListenToMeData
@end

@interface YKListenToMeData : JSONModel
@property(nonatomic, copy) NSString <Optional> *title;
@property(nonatomic, copy) NSString <Optional> *start_time;
@property(nonatomic, copy) NSString <Optional> *end_time;
@property(nonatomic, copy) NSString <Optional> *detail_url;
@property(nonatomic, copy) NSString <Optional> *more_url;
@property(nonatomic, copy) NSString <Optional> *thumbnail;
@end
