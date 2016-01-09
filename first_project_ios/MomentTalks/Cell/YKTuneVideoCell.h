//
//  YKTuneVideoCell.h
//  MomentTalks
//
//  Created by 123 on 15/8/27.
//  Copyright (c) 2015年 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKHomeVideoListDataDataModel.h"
#import "YKTuneListModel.h"

@class YKExploreListTalker;

@interface YKTuneVideoCell :  UITableViewCell
@property (nonatomic, strong) YKExploreListTalker *exploreListTalker;
@property (nonatomic, strong) YKHomeVideoListDataDataModel *videoListDataModel;
@property (nonatomic, strong) YKTuneListData *tuneListData;
@end






