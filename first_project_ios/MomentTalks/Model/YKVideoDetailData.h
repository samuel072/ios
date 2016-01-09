//
//  YKVideoDetailData.h
//  MomentTalks
//
//  Created by 123 on 15/8/21.
//  Copyright (c) 2015年 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
#import "YKVideoDetailDataVideo.h"
#import "YKAlbumDetailDataVideoInfo.h"


@protocol YKVideoDetailData
@end

@interface YKVideoDetailData : JSONModel

@property(nonatomic, copy) NSString <Optional> *videoId;        // 视频Id
@property(nonatomic, copy) NSString <Optional> *starringNames;  // 视频主角名字
@property(nonatomic, copy) NSString <Optional> *showTime;       //开始时间
@property(nonatomic, copy) NSString <Optional> *endTime;        //结束时间
@property(nonatomic, copy) NSString <Optional> *address;        //地点
@property(nonatomic, copy) NSString <Optional> *vedioType;      //类型
@property(nonatomic, copy) NSString <Optional> *tag;            //标签
@property(nonatomic, copy) NSString <Optional> *activeDetail;    //描述
@property(nonatomic, copy) NSString <Optional> *viewCount;
@property(nonatomic, copy) NSString <Optional> *likeCount;
@property(nonatomic, copy) NSString <Optional> *name;
@property(nonatomic, strong) YKAlbumDetailDataVideoInfo *videoPlayInfo;
@end
