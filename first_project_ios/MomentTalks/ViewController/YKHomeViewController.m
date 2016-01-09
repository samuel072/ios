//
// Created by 杨虎 on 15/7/29.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKHomeViewController.h"
#import "YKPlayImageHeaderView.h"
#import "YKProjectCell.h"
#import "YKVideoDetailViewController.h"

static NSString *identifier = @"YKProjectCell";

@interface YKHomeViewController () <YKPlayImageHeaderViewDelegate>
@property(nonatomic, strong) YKPlayImageHeaderView *playImageHeaderView;
@property(nonatomic, strong) YKHomeVideoListDataModel *videoListDataModel;
@property(nonatomic, strong) NSArray <YKHomeAdData> *slideListData;
@end

@implementation YKHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [YKApiRequestServer checkVersion];
    self.title = @"首页";
    [self.mainTableView registerClass:[YKProjectCell class] forCellReuseIdentifier:identifier];
    [self requestHomePageData];
}

/**
* 请求首页数据
*/
- (void)requestHomePageData {

    [YKProgressHDTool showProgressHUD];
    [YKApiRequestServer requestHomeAdWithsuccess:^(YKHomeAdModel *homeAdModel) {
                [YKProgressHDTool hideProgressHUD];
                self.slideListData = homeAdModel.data;
                self.playImageHeaderView = [[YKPlayImageHeaderView alloc] init];
                self.mainTableView.tableHeaderView = _playImageHeaderView;
                self.playImageHeaderView.delegate = self;
            }
                                         failure:^(NSString *error) {
                                             [YKProgressHDTool reminderWithTitle:error];
                                         }];
// 首页的数据，取 data 数组
    [YKApiRequestServer requestHomePageWithSuccess:^(YKHomeVideoListModel *homeVideoListModel) {
                [YKProgressHDTool hideProgressHUD];
                if (homeVideoListModel.data.count > 0) {
                    self.videoListDataModel = homeVideoListModel.data[0];
                }
                [self.mainTableView reloadData];
            }
                                           failure:^(NSString *error) {
                                               [YKProgressHDTool reminderWithTitle:error];
                                           }];
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return YKProjectCellHeigth + 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}

// 首页页面的弹出值
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YKHomeVideoListDataDataModel *videoListDataModel = self.videoListDataModel.data[indexPath.section];
    [self pushWebViewControllerWithURL:videoListDataModel.videoDetailUrl];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YKProjectCell *rankCell = [tableView dequeueReusableCellWithIdentifier:identifier
                                                              forIndexPath:indexPath];
    YKHomeVideoListDataDataModel *videoListDataModel = self.videoListDataModel.data[indexPath.section];
    rankCell.videoListDataModel = videoListDataModel;
    return rankCell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.videoListDataModel.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

#pragma mark  YKPlayImageHeaderViewDelegate

- (void)didSelectImageAtIndex:(NSInteger)index {
//    YKHomeAdData *homeAdData = self.slideListData[(NSUInteger) index];
//    YKVideoDetailViewController *videoDetailViewController = [[YKVideoDetailViewController alloc] init];
//    [self.navigationController pushViewController:videoDetailViewController animated:YES];
//    [self pushWebViewControllerWithURL:homeAdData.url];
}

- (int)numberOfHeadImageView {
    return self.slideListData.count;
}

- (NSString *)iamgeUrlOfHeadImageViewAtIndex:(int)index {
    YKHomeAdData *model = self.slideListData[index];
    return model.bigImage;
}

@end