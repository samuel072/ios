//
// Created by 杨虎 on 15/7/30.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKExploreListInfo.h"
#import "YKListenToMeData.h"
#import "YKHomeVideoListDataDataModel.h"

#define YKMoreVideoCellMenuViewHeight YKScaleNum(120)         // 菜单高度 CTScaleNum(100)

extern const CGFloat YKMoreVideoCellMenuViewMargin;       // 菜单与菜单之间的边距
extern const CGFloat YKMoreVideoCellSectionHeadHeight;       // 菜单与菜单之间的边距

@protocol YKLiveCellDelegate;
@protocol YKExploreCellDelegate;

@interface YKMoreVideoCell : UITableViewCell
@property(nonatomic, weak) id <YKLiveCellDelegate> liveCellDelegate;
@property(nonatomic, weak) id <YKExploreCellDelegate> exploreCellDelegate;

@property(nonatomic, strong) YKExploreListInfo *exploreListInfo;

@property(nonatomic, strong) NSArray <YKListenToMeData> *listenToMeData;

@property(nonatomic, strong) NSMutableArray <YKHomeVideoListDataDataModel> *videoDataArray;

@property(nonatomic, strong) NSIndexPath *indexPath;
@end

@protocol YKLiveCellDelegate
/**
* 视频点击事件
*/
- (void)menuItemClickWithHomeVideoListDataDataModel:(YKHomeVideoListDataDataModel *)homeVideoListDataDataModel;

@end

@protocol YKExploreCellDelegate
/**
* 视频点击事件
*/
- (void)menuItemClickAtIndexPath:(NSIndexPath *)indexPath;

/**
* 更多点击事件
*/
- (void)moreClickAtIndexPath:(NSIndexPath *)indexPath;

@end