//
// Created by 杨虎 on 15/7/31.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKAlbumDetailData.h"
#import "YKAlbumVideoListData.h"
#import "YKHomeVideoListDataDataModel.h"

@protocol YKVideoBottomMenuViewDelegate;

@interface YKVideoBottomMenuView : UIView
@property(nonatomic, copy) NSString *videoId;
@property(nonatomic, copy) NSString *videoName;
@property(nonatomic, strong) UIViewController *showViewController;
@property(nonatomic, weak) id <YKVideoBottomMenuViewDelegate> delegate;
@end

@protocol YKVideoBottomMenuViewDelegate
/**
* 喜欢
*/
- (void)videoBottomMenuLikeAction:(UIButton *)button;

/**
* 分享
*/
- (void)videoBottomMenuShareAction;

/**
* 收藏
*/
- (void)videoBottomMenuCollectAction:(UIButton *)button;

@end