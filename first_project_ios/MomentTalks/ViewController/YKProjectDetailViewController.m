//
// Created by 杨虎 on 15/7/31.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKProjectDetailViewController.h"
#import "YKPlayVideoHeadView.h"
#import "YKProjectDetailCell.h"
#import "YKShareNewsTool.h"
#import "ShareBackView.h"

static const NSString *identifier = @"YKProjectDetailCell";

@interface YKProjectDetailViewController () <YKPlayVideoHeadViewDelegate>
@property(nonatomic, strong) YKAlbumVideoListMolel *albumVideoListMolel;
@property(nonatomic, strong) YKPlayVideoHeadView *playVideoHeadView;
@property(nonatomic, strong) NSIndexPath *selectIndexPath;
@end

@implementation YKProjectDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"专题详情";

    self.playVideoHeadView = [[YKPlayVideoHeadView alloc] init];
    self.playVideoHeadView.y = 64;
    self.playVideoHeadView.delegate = self;
    
   

    [self.mainTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.playVideoHeadView.yh);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(YKScreenFrameW);
    }];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginSuccessAction)
                                                 name:YKLoginSuccessNotificationKey
                                               object:nil];

    [self requestAlbumDetail];
}

- (void)backViewControllerAction {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:YKLoginSuccessNotificationKey object:nil];
    [super backViewControllerAction];
}

- (void)loginSuccessAction {
    YKAlbumVideoListData *albumVideoListData = self.albumVideoListMolel.data[self.selectIndexPath.row];
    self.playVideoHeadView.videoId = albumVideoListData.videoId;
}

/**
* 请求专题详情列表
*/
- (void)requestAlbumDetail {
    [YKProgressHDTool showProgressHUD];
    [YKApiRequestServer requestAlbumVideoListWithAlbumId:self.albumId
                                                 success:^(YKAlbumVideoListMolel *albumVideoListMolel) {
                                                     self.albumVideoListMolel = albumVideoListMolel;
                                                     if (self.albumVideoListMolel.data.count ==0) {
                                                         [YKProgressHDTool reminderWithTitle:@"专辑为空"];
                                                     }else{
                                                         [YKProgressHDTool hideProgressHUD];
                                                         [self.mainTableView reloadData];
                                                         self.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                                                         [self changeCellStatusWithIndexPath:self.selectIndexPath];
                                                         YKAlbumVideoListData *albumVideoListData = self.albumVideoListMolel.data[0];
                                                         self.playVideoHeadView.imageViewUrl = albumVideoListData.videoPlayInfo.thumbnail;
                                                         self.playVideoHeadView.videoId = albumVideoListData.videoId;
                                                         self.playVideoHeadView.videoName = albumVideoListData.name;
                                                         [self.view addSubview:self.playVideoHeadView];
                                                     }

                                                 }
                                                 failure:^(NSString *error) {
                                                     [YKProgressHDTool reminderWithTitle:error];
                                                 }];
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

- (void)changeCellStatusWithIndexPath:(NSIndexPath *)indexPath {
    YKProjectDetailCell *lastProjectDetailCell = (YKProjectDetailCell *) [self.mainTableView cellForRowAtIndexPath:self.selectIndexPath];
    lastProjectDetailCell.select = NO;

    YKProjectDetailCell *projectDetailCell = (YKProjectDetailCell *) [self.mainTableView cellForRowAtIndexPath:indexPath];
    projectDetailCell.select = YES;
    self.selectIndexPath = indexPath;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self changeCellStatusWithIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self changeCellStatusWithIndexPath:indexPath];
    YKAlbumVideoListData *albumVideoListData = self.albumVideoListMolel.data[indexPath.row];
    self.playVideoHeadView.imageViewUrl = albumVideoListData.videoPlayInfo.thumbnail;
    self.playVideoHeadView.videoName = albumVideoListData.name;
    self.playVideoHeadView.videoId = albumVideoListData.videoId;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YKProjectDetailCell *projectDetailCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!projectDetailCell) {
        projectDetailCell = [[YKProjectDetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    YKAlbumVideoListData *albumVideoListData = self.albumVideoListMolel.data[indexPath.row];
    projectDetailCell.albumVideoListData = albumVideoListData;
    return projectDetailCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.albumVideoListMolel.data.count;
}

#pragma mark  YKPlayVideoHeadViewDelegate

- (void)playVideoHeadViewCheckAction {
    YKAlbumVideoListData *albumVideoListData = self.albumVideoListMolel.data[(NSUInteger) self.selectIndexPath.section];
    [self pushWebViewControllerWithURL:albumVideoListData.videoPlayInfo.videoUrl];
}

/**
* 分享
*/
- (void)playVideoHeadViewShareCheckAction {
    YKAlbumVideoListData *albumVideoListData = self.albumVideoListMolel.data[(NSUInteger) self.selectIndexPath.row];
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
        [YKShareNewsTool shareWithTitle:albumVideoListData.name
                                summary:@""
                               shareUrl:albumVideoListData.videoPlayInfo.videoUrl
                               imageUrl:albumVideoListData.videoPlayInfo.thumbnail
                                   type:type];
    }];
}

@end