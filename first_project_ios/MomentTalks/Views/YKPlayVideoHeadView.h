//
// Created by 杨虎 on 15/8/9.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YKHomeVideoListDataDataModel;
@protocol YKPlayVideoHeadViewDelegate;
@class YKAlbumDetailData;

@interface YKPlayVideoHeadView : UIView
@property(nonatomic, copy) NSString *videoName;
@property(nonatomic, copy) NSString *imageViewUrl;
@property(nonatomic, copy) NSString *videoId;
@property(nonatomic, weak) id <YKPlayVideoHeadViewDelegate> delegate;
@end

@protocol YKPlayVideoHeadViewDelegate
/**
* 点击播放按钮
*/
- (void)playVideoHeadViewCheckAction;

- (void)playVideoHeadViewShareCheckAction;
@end