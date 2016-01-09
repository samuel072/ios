//
// Created by 杨虎 on 15/8/9.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKHomeVideoListDataDataModel.h"

#define WillPlayVideoCellHeight  YKScaleNum(130)
@protocol YKWillPlayVideoCellDelegate;

@interface YKWillPlayVideoCell : UITableViewCell
@property(nonatomic, strong) NSMutableArray <YKHomeVideoListDataDataModel> *videoDataArray;
@property(nonatomic, weak) id <YKWillPlayVideoCellDelegate> delegate;
@end

@protocol YKWillPlayVideoCellDelegate
- (void)willPlayVideoCellCheckActionWithModel:(YKHomeVideoListDataDataModel *)model;
- (void)reservationActionWithModel:(YKHomeVideoListDataDataModel *)model;

@end