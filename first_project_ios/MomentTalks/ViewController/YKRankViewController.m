
//
// Created by 杨虎 on 15/7/29.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKRankViewController.h"
#import "YKRankChangeHeadView.h"
#import "YKRankCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "YKVideoDetailViewController.h"

static NSString *identifier = @"YKRankCell";

@interface YKRankViewController () <YKRankChangeHeadViewDelegate>
/** 切换排行数据view */
@property(nonatomic, strong) YKRankChangeHeadView *rankChangeHeadView;
/** 今日排行榜 */
@property(nonatomic, strong) YKRankListModel *todayRankListModel;
/** 当月排行榜 */
@property(nonatomic, strong) YKRankListModel *monthRankListModel;
/** 显示今日排行 */
@property(nonatomic, assign) BOOL showTodayRankListData;
@end

@implementation YKRankViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"排行";
    _rankChangeHeadView = [YKRankChangeHeadView new];
    [self.view addSubview:_rankChangeHeadView];
    _rankChangeHeadView.delegate = self;
    [_rankChangeHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(45);
    }];

    [self.mainTableView registerClass:[YKRankCell class] forCellReuseIdentifier:identifier];
    [self.mainTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_rankChangeHeadView.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];

    self.showTodayRankListData = YES;
    [self requestTodatRankListData];
}

/**
* 请求当月排行榜
*/
- (void)requestMonthRankListData {
    [YKApiRequestServer requestMonthRankWithSuccess:^(YKRankListModel *rankListModel) {
        self.monthRankListModel = rankListModel;
        [self.mainTableView reloadData];
    }                                       failure:^(NSString *error) {
        [YKProgressHDTool reminderWithTitle:error];
    }];
}

/**
* 请求今日排行榜
*/
- (void)requestTodatRankListData {
    [YKApiRequestServer requestTodayRankWithSuccess:^(YKRankListModel *rankListModel) {
        self.todayRankListModel = rankListModel;
        [self.mainTableView reloadData];

    }                                       failure:^(NSString *error) {
        [YKProgressHDTool reminderWithTitle:error];
    }];
}

- (YKRankListData *)rankListDataWithIndexPath:(NSIndexPath *)indexPath {
    YKRankListData *rankListData = nil;
    if (self.showTodayRankListData) {
        rankListData = self.todayRankListModel.data[(NSUInteger) indexPath.section];
    } else {
        rankListData = self.monthRankListModel.data[(NSUInteger) indexPath.section];
    }
    return rankListData;
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:identifier
                                    cacheByIndexPath:indexPath
                                       configuration:^(id cell) {
                                       }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.showTodayRankListData) {
        return self.todayRankListModel.data.count;
    } else {
        return self.monthRankListModel.data.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

// cell之间的间隔
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
// 使用阿能H5页面
    [self pushWebViewControllerWithURL:[self rankListDataWithIndexPath:indexPath].videoDetailUrl];
    
// 使用原生页面
//    YKRankListData *rankListData = [self rankListDataWithIndexPath:indexPath];
//    YKVideoDetailViewController *videoDetailViewController = [[YKVideoDetailViewController alloc] init];
//    videoDetailViewController.videoId = rankListData.videoId;
//    [self.navigationController pushViewController:videoDetailViewController animated:YES];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YKRankCell *rankCell = [tableView dequeueReusableCellWithIdentifier:identifier
                                                           forIndexPath:indexPath];
    rankCell.rankListData = [self rankListDataWithIndexPath:indexPath];
    return rankCell;
}

#pragma mark YKRankChangeHeadViewDelegate

- (void)dayRankItemViewClickAcion {
    self.showTodayRankListData = YES;
    if (!self.todayRankListModel) {
        [self requestTodatRankListData];
    }
    [self.mainTableView reloadData];
    [self.mainTableView setContentOffset:CGPointMake(0, 0) animated:NO];
}

- (void)monthRankItemViewClickAcion {
    self.showTodayRankListData = NO;
    if (!self.monthRankListModel) {
        [self requestMonthRankListData];
    }
    [self.mainTableView reloadData];
    [self.mainTableView setContentOffset:CGPointMake(0, 0) animated:NO];
}




@end