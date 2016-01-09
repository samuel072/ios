//
// Created by 杨虎 on 15/7/29.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKHomeVideoListDataDataModel.h"
#import "YKProjectListModel.h"

#define YKProjectCellHeigth YKScaleNum(105)

@interface YKProjectCell : UITableViewCell
@property(nonatomic, strong) YKHomeVideoListDataDataModel *videoListDataModel;
@property(nonatomic, strong) YKProjectListData *projectListData;
@end