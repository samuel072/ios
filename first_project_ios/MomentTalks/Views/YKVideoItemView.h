//
// Created by 杨虎 on 15/7/30.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKExploreListInfoInfo.h"
#import "YKListenToMeData.h"

@class YKHomeVideoListDataDataModel;


@interface YKVideoItemView : UIView
/** 缩略图 */
@property(nonatomic, strong) UIImageView *thumbImageView;
///** 专辑 */
//@property(nonatomic, strong) UILabel *albumNameLabel;
/** 专辑 */
@property(nonatomic, strong) UILabel *titleLabel;
/** 时间 */
@property(nonatomic, strong) UILabel *timeLabel;
/** 透明View */
@property(nonatomic, strong) UIView *transparentView;
@property(nonatomic, strong) YKExploreListInfoInfo *exploreListInfo;
@property(nonatomic, strong) YKHomeVideoListDataDataModel *homeVideoListDataDataModel;
@property(nonatomic, strong) YKListenToMeData *listenToMeData;

@end