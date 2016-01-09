//
// Created by 杨虎 on 15/7/29.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKLiveViewController.h"
#import "YKMoreVideoCell.h"
#import "YKWillPlayVideoCell.h"
#import "YKVideoPlayView.h"
#import "YKPlayVideoHeadView.h"
#import "YKLoginViewController.h"
#import "YKUserTools.h"
#import "ShareBackView.h"

static const NSInteger kTableHeadViewBackgroudImageViewTag = 995;
static const NSString *kTwoVideoCellIdentifier = @"YKLiveViewControllerYKTwoVideoCell";
static const NSString *kWillPlayVideoCellIdentifier = @"YKLiveViewControllerYKWillPlayVideoCell";

@interface YKLiveViewController () <YKVideoPlayViewDelegate, YKPlayVideoHeadViewDelegate, YKLiveCellDelegate, YKWillPlayVideoCellDelegate>
/** 正在直播数据 */
@property(nonatomic, strong) NSMutableArray <YKHomeVideoListDataDataModel> *playingVideoDataArray;
/** 将要直播数据 */
@property(nonatomic, strong) NSMutableArray <YKHomeVideoListDataDataModel> *willPlayVideoDataArray;
@property(nonatomic, strong) YKPlayVideoHeadView *playVideoHeadView;
@end

@implementation YKLiveViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"直播";

    [self.mainTableView registerClass:[YKMoreVideoCell class] forCellReuseIdentifier:kTwoVideoCellIdentifier];
    [self.mainTableView registerClass:[YKWillPlayVideoCell class] forCellReuseIdentifier:kWillPlayVideoCellIdentifier];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deleteCollectionAction:)
                                                 name:YKDeleteCollectionNotificationKey
                                               object:nil];

    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginSuccessAction)
                                                 name:YKLoginSuccessNotificationKey
                                               object:nil];

    [self requestLiveListData];
}

- (void)backViewControllerAction {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:YKLoginSuccessNotificationKey object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:YKDeleteCollectionNotificationKey object:nil];
    [super backViewControllerAction];
}

- (void)loginSuccessAction {
    YKHomeVideoListDataDataModel *dataDataModel = self.playingVideoDataArray[0];
    self.playVideoHeadView.videoId = dataDataModel.videoId;
}

- (void)deleteCollectionAction:(NSNotification *)note {
    NSString *videoId = [note object];
    if ([videoId isEqualToString:self.playVideoHeadView.videoId]) {
        self.playVideoHeadView.videoId = [note object];
    }
}

/**
* 请求直播信息列表
*/
- (void)requestLiveListData {
    [YKApiRequestServer requestLiveListWithSuccess:^(
                    NSMutableArray <YKHomeVideoListDataDataModel> *isPlayVideoDataArray,
                    NSMutableArray <YKHomeVideoListDataDataModel> *willPlayVideoDataArray) {
                self.playingVideoDataArray = isPlayVideoDataArray;
                self.willPlayVideoDataArray = willPlayVideoDataArray;
                // 如果有正在直播的视频，将列表中第一个视频放在顶部
                if (self.playingVideoDataArray.count > 0) {
                    self.playVideoHeadView = [[YKPlayVideoHeadView alloc] init];

                    YKHomeVideoListDataDataModel *dataDataModel = self.playingVideoDataArray[0];
                    self.playVideoHeadView.imageViewUrl = dataDataModel.pic;
                    self.playVideoHeadView.videoId = dataDataModel.videoId;
                    self.playVideoHeadView.videoName =dataDataModel.name;
                    self.playVideoHeadView.delegate = self;
                    self.mainTableView.tableHeaderView = self.playVideoHeadView;
                }
                // 和顶部数据不能重复出现
                // 避免只有一个正在直播的视频，如果删掉之后会正在会出现空白
                if (self.playingVideoDataArray.count > 1) {
                    [self.playingVideoDataArray removeObjectAtIndex:0];
                }
                [self.mainTableView reloadData];
            }
                                           failure:^(NSString *error) {

                                           }];
}

- (CGFloat)willPlayVideoCellHeightForRowAtIndexPath:(int)count {
    if (count > 0) {
        return (CGFloat) (YKMoreVideoCellSectionHeadHeight +
                ((WillPlayVideoCellHeight + YKMoreVideoCellMenuViewMargin) * count) +
                YKMoreVideoCellMenuViewMargin +
                0.5);;
    } else {
        return 0;
    }
}

#pragma mark YKPlayVideoHeadViewDelegate

/**
* 顶部视频点击事件
*/
- (void)playVideoHeadViewCheckAction {
    YKHomeVideoListDataDataModel *model = self.playingVideoDataArray[0];
    [self pushWebViewControllerWithURL:model.videoDetailUrl];
}

/**
* 分享
*/
- (void)playVideoHeadViewShareCheckAction {
    YKHomeVideoListDataDataModel *dataDataModel = self.playingVideoDataArray[0];
    [ShareBackView showBackViewWithBlock:^(NSInteger i) {
        ShareType type = nil;
        if (i == 0) {
            type = ShareTypeWeixiTimeline;
        } else if (i == 1) {
            type = ShareTypeWeixiSession;
        } else if (i == 2) {
            type = ShareTypeSinaWeibo;
        } else if (i == 3) {
            type = ShareTypeQQ;
        }
        [YKShareNewsTool shareWithTitle:dataDataModel.name
                                summary:@""
                               shareUrl:dataDataModel.url   //videoDetailUrl
                               imageUrl:dataDataModel.pic
                                   type:type];
    }];
}

#pragma mark UITableViewDelegate

- (CGFloat)heightForRowAtIndexPath:(int)count {
    int line = 1;
    if (count > 0) {
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        // 考虑有可能“正在”或者“将要”里面其中一个没有数据
        if (self.playingVideoDataArray.count > 0) {
            return [self heightForRowAtIndexPath:self.playingVideoDataArray.count];
        } else if (self.willPlayVideoDataArray.count > 0) {
            return [self willPlayVideoCellHeightForRowAtIndexPath:self.willPlayVideoDataArray.count];
        }
    } else if (indexPath.section == 1) {
        // 将要
        return [self willPlayVideoCellHeightForRowAtIndexPath:self.willPlayVideoDataArray.count];
    }
    return 0;
}

// cell之间的间隔
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 13;
}

- (UITableViewCell *)createPlayVideoCellWithtableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YKMoreVideoCell *twoVideoCell = [self.mainTableView dequeueReusableCellWithIdentifier:kTwoVideoCellIdentifier
                                                                             forIndexPath:indexPath];
    twoVideoCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!twoVideoCell) {
        twoVideoCell = [[YKMoreVideoCell alloc] init];
    }
    twoVideoCell.videoDataArray = self.playingVideoDataArray;
    twoVideoCell.liveCellDelegate = self;
    return twoVideoCell;
}

- (UITableViewCell *)createWillPlayVideoCellWithtableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YKWillPlayVideoCell *willPlayVideoCell = [self.mainTableView dequeueReusableCellWithIdentifier:kWillPlayVideoCellIdentifier
                                                                                      forIndexPath:indexPath];
    willPlayVideoCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!willPlayVideoCell) {
        willPlayVideoCell = [[YKWillPlayVideoCell alloc] init];
    }
    willPlayVideoCell.delegate = self;
    willPlayVideoCell.videoDataArray = self.willPlayVideoDataArray;
    return willPlayVideoCell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        // 考虑有可能“正在”或者“将要”里面其中一个没有数据
        if (self.playingVideoDataArray.count > 0) {
            return [self createPlayVideoCellWithtableView:tableView cellForRowAtIndexPath:indexPath];
        } else if (self.willPlayVideoDataArray.count > 0) {
            return [self createWillPlayVideoCellWithtableView:tableView cellForRowAtIndexPath:indexPath];
        }
    } else if (indexPath.section == 1) {
        // 将要
        return [self createWillPlayVideoCellWithtableView:tableView cellForRowAtIndexPath:indexPath];
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    int sectionNumber = 0;
    if (self.playingVideoDataArray.count > 0) {
        sectionNumber++;
    }
    if (self.willPlayVideoDataArray.count > 0) {
        sectionNumber++;
    }
    return sectionNumber;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

#pragma mark YKVideoPlayViewDelegate

- (void)zoomVideoPlay:(BOOL)fillScreen {
    [YKSharedAppDelegate.tabBarController setTabBarHidden:fillScreen animated:YES];
}

#pragma  mark YKLiveCellDelegate
// 直播页面  正在
- (void)menuItemClickWithHomeVideoListDataDataModel:(YKHomeVideoListDataDataModel *)homeVideoListDataDataModel {
    [self pushWebViewControllerWithURL:homeVideoListDataDataModel.videoDetailUrl];//videoDeatilUrl
    /*
    self.backgroundImageView.hidden = NO;
    self.playImageView.hidden = NO;
    [self.view sendSubviewToBack:self.videoPlayView];
    [self.backgroundImageView sd_setImageWithURL:[homeVideoListDataDataModel.pic toUrl]];
    self.videoBottomMenuView.homeVideoListDataDataModel = homeVideoListDataDataModel;
    self.selectPlayVideoModel = homeVideoListDataDataModel;*/
}

// 首页的URL 和 直播页面的 播放 URL 和 videoDetailUrl 的访问  将要
- (void)willPlayVideoCellCheckActionWithModel:(YKHomeVideoListDataDataModel *)model {
    NSLog(@"model = %@", model);
    [self pushWebViewControllerWithURL:model.videoDetailUrl]; //videoDetailUrl
}

- (void)reservationActionWithModel:(YKHomeVideoListDataDataModel *)model {
    NSLog(@"model = %@", model);
    if (![YKUserTools isLogin]) {
        YKLoginViewController *loginViewController = [[YKLoginViewController alloc] init];
        [self.navigationController pushViewController:loginViewController animated:YES];
        return;
    }
    [YKApiRequestServer addReservationWithAlbumId:model.albumId success:^{
                [YKProgressHDTool reminderWithTitle:@"预约成功"];
            }
                                          failure:^(NSString *error) {
                                              [YKProgressHDTool reminderWithTitle:error];
                                          }];
}
@end