//
// Created by 杨虎 on 15/7/29.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKBaseTableViewController.h"

@interface YKBaseRefreshTableViewController : YKBaseTableViewController
@property(nonatomic, assign) int page;

/**
* 下拉刷新
*/
- (void)loadNewData;

/**
* 加载更多
*/
- (void)loadMoreData;
@end