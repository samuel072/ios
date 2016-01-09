//
// Created by 杨虎 on 15/7/29.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKBaseRefreshTableViewController.h"
#import "MJRefresh.h"

@implementation YKBaseRefreshTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.mainTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                                                 refreshingAction:@selector(loadNewData)];
    self.mainTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self
                                                                     refreshingAction:@selector(loadMoreData)];
    // 马上进入刷新状态
    [self.mainTableView.header beginRefreshing];
}

- (void)loadNewData {
    self.page = 1;
}

- (void)loadMoreData {

}
@end