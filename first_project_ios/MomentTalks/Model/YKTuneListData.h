//
//  YKTuneListData.h
//  MomentTalks
//
//  Created by 123 on 15/8/27.
//  Copyright (c) 2015年 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@protocol  YKTuneListData

@end

@interface YKTuneListData : JSONModel
@property (nonatomic, copy) NSString <Optional> *name;
@property (nonatomic, copy) NSString <Optional> *standardPic;
@property (nonatomic, copy) NSString <Optional> *id;
@property (nonatomic, copy) NSString <Optional> *url;
@property (nonatomic, copy) NSString <Optional> *type;
@property (nonatomic, copy) NSString <Optional> *albumId;
@property (nonatomic, copy) NSString <Optional> *videoId;
@property (nonatomic, copy) NSString <Optional> *targetId;


@end






