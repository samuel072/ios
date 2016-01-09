//
//  YKVideoDetailDataVideoInfo.h
//  MomentTalks
//
//  Created by 123 on 15/8/21.
//  Copyright (c) 2015年 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@protocol YKVideoDeatilDataVideoInfo


@end

@interface YKVideoDetailDataVideoInfo : JSONModel
@property (nonatomic, copy) NSString <Optional> *videoId;
@property (nonatomic, copy) NSString <Optional> *videoUrl;


@end
