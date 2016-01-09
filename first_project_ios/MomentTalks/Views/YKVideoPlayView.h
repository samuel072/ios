//
// Created by 杨虎 on 15/7/30.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKAlbumDetailModel.h"
#import "YKAlbumVideoListData.h"
#import "YKHomeVideoListDataDataModel.h"
#import "YKAlbumDetailDataVideoInfo.h"

@protocol YKVideoPlayViewDelegate;

/** 刷新控件的状态 */
typedef enum {
    YKLiveVideo = 0 ,
    YKUpdataVideo ,
} YKVideoType;



@interface YKVideoPlayView : UIView
/** 自动播放 */
@property(nonatomic, assign) BOOL autoPalyVideo;
@property(nonatomic, strong) YKAlbumDetailDataVideoInfo *videoPlayInfo;
//@property(nonatomic, strong) YKAlbumDetailData *albumDetailData;
//@property(nonatomic, strong) YKAlbumVideoListData *albumVideoListData;
//@property(nonatomic, strong) YKHomeVideoListDataDataModel *homeVideoListDataDataModel;
@property(nonatomic, weak) id <YKVideoPlayViewDelegate> delegate;
@property(nonatomic, assign) YKVideoType videoType;

- (void)playVideoAction;

- (void)cancelPlayVideo;

- (void)restVideoAction;
@end

@protocol YKVideoPlayViewDelegate
- (void)zoomVideoPlay:(BOOL)fillScreen;
@end