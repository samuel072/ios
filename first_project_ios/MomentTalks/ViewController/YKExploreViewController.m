//
// Created by 杨虎 on 15/7/29.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKExploreViewController.h"
#import "YKPlayImageHeaderView.h"
#import "YKMoreVideoCell.h"
#import "YKOneVideoCell.h"
#import "YKTuneVideoCell.h"

static NSString *kTwoVideoCellIdentifier = @"YKMoreVideoCell";      //更多
static NSString *kOneVideoCellIdentifier = @"YKOneVideoCell";       //点他来讲
static NSString *kThreeVideoCellIdentifier = @"YKTuneVideoCell";    //腔调TALKS

@interface YKExploreViewController () <YKPlayImageHeaderViewDelegate, YKExploreCellDelegate>

/** 幻灯片控件 */
@property(nonatomic, strong) YKPlayImageHeaderView *playImageHeaderView;
/** 探索列表数据 */
@property(nonatomic, strong) YKExploreListModel *exploreListModel;
/** 幻灯片数据 */
@property(nonatomic, strong) NSArray <YKHomeAdData> *slideListData;
/** 听我说数据 */
@property(nonatomic, strong) NSArray <YKListenToMeData> *listenToMeData;

@end

@implementation YKExploreViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"探索";

    [self.mainTableView registerClass:[YKMoreVideoCell class] forCellReuseIdentifier:kTwoVideoCellIdentifier];
    [self.mainTableView registerClass:[YKOneVideoCell class] forCellReuseIdentifier:kOneVideoCellIdentifier];

// YKTuneVideoCell  新添的 腔调TALKS
    [self.mainTableView registerClass:[YKTuneVideoCell class] forCellReuseIdentifier:kThreeVideoCellIdentifier];

    [self requestHomePageData];
    [self requestExploreList];
}

/**
* 请求幻灯片数据
*/
- (void)requestHomePageData {
    [YKApiRequestServer requestHomeAdWithsuccess:^(YKHomeAdModel *homeAdModel) {
                self.slideListData = homeAdModel.data;
                self.playImageHeaderView = [[YKPlayImageHeaderView alloc] init];
                self.mainTableView.tableHeaderView = _playImageHeaderView;
                self.playImageHeaderView.delegate = self;
            }
                                         failure:^(NSString *error) {
                                             [YKProgressHDTool reminderWithTitle:error];
                                         }];
}

/**
* 请求探索数据
*/
- (void)requestExploreList {
    [YKProgressHDTool showProgressHUD];
    [YKApiRequestServer requestExploreListWithSuccess:^(YKExploreListModel *exploreListModel) {
                [YKProgressHDTool hideProgressHUD];
                self.exploreListModel = exploreListModel;
                [self.mainTableView reloadData];
            }
                                              failure:^(NSString *error) {
                                                  [YKProgressHDTool hideProgressHUD];
                                                  [YKProgressHDTool reminderWithTitle:error];
                                              }];

    [YKApiRequestServer requestListenToMeWithsuccess:^(NSArray <YKListenToMeData> *data) {
                self.listenToMeData = data;
                [self.mainTableView reloadData];
                [YKProgressHDTool hideProgressHUD];
            }
                                             failure:^(NSString *error) {
                                                 [YKProgressHDTool hideProgressHUD];
                                                 NSLog(@"%@", error);
                                             }];
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [self heightForRowAtIndexPath:self.listenToMeData.count];
    } else if (indexPath.section == 1) {
        return YKScaleNum(130);
    } else {
        YKExploreListInfo *info = ((YKExploreListInfo *) self.exploreListModel.info[0]);
        return [self heightForRowAtIndexPath:info.num];
    }
}

- (CGFloat)heightForRowAtIndexPath:(int)count {
    int line = 1;
    if (count > 0) {
        if (count > 4) {
            count = 4;
        }
        if (count > 2) {
            if (count % 2 == 0) {
                line = count / 2;
            } else {
                line = count / 2 + 1;
            }
        }
        return (CGFloat) (YKMoreVideoCellSectionHeadHeight +
                ((YKMoreVideoCellMenuViewHeight + YKMoreVideoCellMenuViewMargin) * line) +
                YKMoreVideoCellMenuViewMargin +
                0.5);
    } else {
        return 0;
    }
}

// cell之间的间隔
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 13;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        [self pushWebViewControllerWithURL:self.exploreListModel.talker.talkerListUrl];
    }
}


//展示 更多 和 点他来讲
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        YKMoreVideoCell *cell = [self.mainTableView dequeueReusableCellWithIdentifier:kTwoVideoCellIdentifier forIndexPath:indexPath];
        if (!cell) {
            cell = [[YKMoreVideoCell alloc] init];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.exploreCellDelegate = self;
        cell.listenToMeData = self.listenToMeData;
        cell.indexPath = indexPath;
        return cell;
    } else if (indexPath.section == 1) {
        YKOneVideoCell *cell = [self.mainTableView dequeueReusableCellWithIdentifier:kOneVideoCellIdentifier forIndexPath:indexPath];
        if (!cell) {
            cell = [[YKOneVideoCell alloc] init];
        }
        cell.exploreListTalker = self.exploreListModel.talker;
        return cell;
    } else {
        YKMoreVideoCell *cell = [self.mainTableView dequeueReusableCellWithIdentifier:kTwoVideoCellIdentifier forIndexPath:indexPath];
        if (!cell) {
            cell = [[YKMoreVideoCell alloc] init];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.exploreCellDelegate = self;
        int indexRow = 0;
        if (indexPath.section > 0) {
            indexRow = (int) indexPath.section - 2;
        }
        YKExploreListInfo *info = ((YKExploreListInfo *) self.exploreListModel.info[indexRow]);
        cell.exploreListInfo = info;
        cell.indexPath = indexPath;
        return cell;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    int count = 0;
    for (YKExploreListInfo *info in self.exploreListModel.info) {
        if (info.info.count > 0) {
            count++;
        }
    }
    // 额外加上听我说， 点他讲
    return count + (self.exploreListModel ? 1 : 0) + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

#pragma mark  YKPlayImageHeaderViewDelegate

- (void)didSelectImageAtIndex:(NSInteger)index {
    YKHomeAdData *homeAdData = self.slideListData[(NSUInteger) index];
    [self pushWebViewControllerWithURL:homeAdData.url];
}

- (int)numberOfHeadImageView {
    return (int) self.slideListData.count;
}

- (NSString *)iamgeUrlOfHeadImageViewAtIndex:(int)index {
    YKHomeAdData *model = self.slideListData[(NSUInteger) index];
    return model.bigImage;
}

#pragma mark YKExploreCellDelegate

- (void)moreClickAtIndexPath:(NSIndexPath *)indexPath {
    // 第一个是 听我说
    if (indexPath.section == 0) {
        YKListenToMeData *data = self.listenToMeData[(NSUInteger) indexPath.row];
        [self pushWebViewControllerWithURL:data.more_url];
    } else {
        YKExploreListInfo *exploreListInfo = self.exploreListModel.info[(NSUInteger) indexPath.section];
        [self pushWebViewControllerWithURL:exploreListInfo.listUrl];
    }
}

- (void)menuItemClickAtIndexPath:(NSIndexPath *)indexPath {
    // 第一个是 听我说
    if (indexPath.section == 0) {
        YKListenToMeData *data = self.listenToMeData[(NSUInteger) indexPath.row];
        [self pushWebViewControllerWithURL:data.detail_url];
    } else {
        YKExploreListInfo *exploreListInfo = self.exploreListModel.info[(NSUInteger) indexPath.section - 2];
        YKExploreListInfoInfo *exploreListInfoInfo = exploreListInfo.info[(NSUInteger) indexPath.row];
        [self pushWebViewControllerWithURL:exploreListInfoInfo.videoDetailUrl];

    }
}
@end