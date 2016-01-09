//
// Created by 杨虎 on 15/8/1.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <MJRefresh/UIScrollView+MJRefresh.h>
#import <MJRefresh/MJRefreshComponent.h>
#import <MJRefresh/MJRefreshHeader.h>
#import <MJRefresh/MJRefreshFooter.h>
#import "YKVideoDetailViewController.h"
#import "YKVideoPlayView.h"
#import "YKVideoDetailDescribeCell.h"
#import "YKCommentCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "YKVideoBottomCommentView.h"
#import "YKEditCommentView.h"
#import "YKVideoDetailAppointmentCell.h"
#import "YKVideoDetailInfoCell.h"
#import "YKLoginViewController.h"
#import "YKUserTools.h"
#import "ShareBackView.h"

static const NSString *identifier = @"YKCommentCell";
static const CGFloat KBottomMenuHeight = 49;

@interface YKVideoDetailViewController () <
        YKVideoPlayViewDelegate,
        YKVideoDetailDescribeCellDelegate,
        YKVideoBottomCommentViewDelegate,
        YKEditCommentViewDelegate,
        YKVideoDetailAppointmentCellDelegate>
/** 视频播放器 */
@property(nonatomic, strong) YKVideoPlayView *videoPlayView;
/** 视频描述cell */
@property(nonatomic, strong) YKVideoDetailDescribeCell *detailDescribeCell;
@property(nonatomic, strong) YKVideoDetailAppointmentCell *videoDetailAppointmentCell;
@property(nonatomic, strong) YKVideoDetailInfoCell *videoDetailInfoCell;
@property(nonatomic, strong) NSMutableArray <YKVideoCommentData> *commentListData;
@property(nonatomic, strong) YKVideoDetailData *videoDetailData;
/** 是否展开视频描述 */
@property(nonatomic, assign) BOOL packDescribe;
/** 底部评论，分享布局*/
@property(nonatomic, strong) YKVideoBottomCommentView *bottomCommentView;
// 评论小框 取消按钮
@property (nonatomic, weak) YKEditCommentView *editCommentView;
@end

@implementation YKVideoDetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情";
    // 设置导航栏为透明
//    self.customNavigation.backgroundColor = [UIColor clearColor];

    self.packDescribe = NO;
    self.commentListData = (NSMutableArray <YKVideoCommentData> *) @[].mutableCopy;
    CGFloat videoPlayViewheight = YKScreenFrameW / 16 * 9;
    // 这里使用绝对布局，因为使用相对布局VMediaPlayer会变得很小，不识别父视图size
    _videoPlayView = [[YKVideoPlayView alloc] initWithFrame:CGRectMake(0, 64, YKScreenFrameW, videoPlayViewheight)];
    _videoPlayView.delegate = self;
    [self.view addSubview:_videoPlayView];

//    // 背景图遮挡住了导航栏
//    [self.view sendSubviewToBack:_videoPlayView];

    _bottomCommentView = [[YKVideoBottomCommentView alloc]
            initWithFrame:CGRectMake(0, YKScreenFrameH - KBottomMenuHeight, YKScreenFrameW, KBottomMenuHeight)];
    _bottomCommentView.delegate = self;
    [self.view addSubview:_bottomCommentView];

    [self.mainTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_videoPlayView.yh);
        make.bottom.mas_equalTo(_bottomCommentView.mas_top);
        make.width.mas_equalTo(YKScreenFrameW);
    }];
//
    [self.mainTableView registerClass:[YKCommentCell class] forCellReuseIdentifier:identifier];
    [self requestVideoDetail];
}

- (void)backViewControllerAction{
    [super backViewControllerAction];
    [self.videoPlayView cancelPlayVideo];
    self.videoPlayView = nil;
}

#pragma mark  请求数据

//评论列表
- (void)requestCommentList {
    [YKApiRequestServer requestVideoCommentListWithResourceId:self.videoId
                                                         size:@"15"
                                                       status:@"1"
                                                         page:[NSString stringWithFormat:@"%i", self.page]
                                                      success:^(YKVideoCommentListModel *videoCommentListModel) {
                                                          [self.mainTableView.header endRefreshing];
                                                          [self.mainTableView.footer endRefreshing];
                                                          if (self.page == 1) {
                                                              if (videoCommentListModel.data.count == 0) {
                                                                  [YKProgressHDTool reminderWithTitle:@"暂无数据"];
                                                              }
                                                              [self.commentListData removeAllObjects];
                                                              [self.commentListData addObjectsFromArray:videoCommentListModel.data];
                                                              [self.mainTableView reloadData];
                                                          } else {
                                                              if (videoCommentListModel.data.count == 0) {
                                                                  [YKProgressHDTool reminderWithTitle:@"没有更多"];
                                                              } else {
                                                                  [self.commentListData addObjectsFromArray:videoCommentListModel.data];
                                                                  [self.mainTableView reloadData];
                                                              }
                                                          }
                                                          self.page++;
                                                      }
                                                      failure:^(NSString *error) {
                                                          [YKProgressHDTool reminderWithTitle:error];
                                                      }];
}

//视频详情文字介绍
- (void)requestVideoDetail {
    [YKApiRequestServer requestVideoDetailWithAlbumId:self.videoId
                                              success:^(YKVideoDetailData *videoDetailData) {
                                                  self.videoDetailData = videoDetailData;
                                                  
                                                  
                                                  _videoPlayView.videoPlayInfo= videoDetailData.videoPlayInfo;
                                                  [self.mainTableView reloadData];
                                              }
                                              failure:^(NSString *error) {

                                              }];
}

- (void)loadNewData {
    [super loadNewData];
    [self requestCommentList];
}

- (void)loadMoreData {
    [self requestCommentList];
}

#pragma mark YKVideoDetailDescribeCellDelegate

- (void)videoDetailDescribeCellPackDescribe:(BOOL)pack {
    self.packDescribe = pack;
    [self.mainTableView reloadData];
}

#pragma mark YKVideoPlayViewDelegate

- (void)zoomVideoPlay:(BOOL)fillScreen {
    if (fillScreen) {
        [self.view bringSubviewToFront:_videoPlayView];
    } else {
        [self.view sendSubviewToBack:_videoPlayView];
        [self.view sendSubviewToBack:self.mainTableView];
    }
}


//评论上方的活动详情
#pragma mark UITableViewDelegate

- (CGFloat)calculateDescribeCellHeight {
    CGFloat describeCellHeight = 40;
    if (!self.packDescribe) {
        NSString *text = self.videoDetailData.activeDetail;
        describeCellHeight += [text heightForSizeWithFont:[UIFont systemFontOfSize:15] andWidth:YKScreenFrameW - 20];
        describeCellHeight += 20;
    }
    return describeCellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:
        (NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 240;
    } else if (indexPath.section == 1) {
        return [self calculateDescribeCellHeight];
    } else if (indexPath.section == 2) {
        return 44;
    } else {
        return [tableView fd_heightForCellWithIdentifier:identifier cacheByIndexPath:indexPath configuration:^(YKCommentCell *cell) {
            YKVideoCommentData *videoCommentData = self.commentListData[(NSUInteger) indexPath.row];
            cell.videoCommentData = videoCommentData;
        }];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
        (NSIndexPath *)indexPath {
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:
                 (NSIndexPath *)indexPath {
    // 第一个是视频简介
    if (indexPath.section == 1) {
        if (!self.detailDescribeCell) {
            self.detailDescribeCell = [[YKVideoDetailDescribeCell alloc] init];
        }
        self.detailDescribeCell.delegate = self;
        self.detailDescribeCell.describeString = self.videoDetailData.activeDetail;
        return self.detailDescribeCell;
    } else if (indexPath.section == 2) {
        if (!self.videoDetailAppointmentCell) {
            self.videoDetailAppointmentCell = [YKVideoDetailAppointmentCell new];
            self.videoDetailAppointmentCell.delegate = self;
        }
        return self.videoDetailAppointmentCell;
    } else if (indexPath.section == 0) {
        if (!self.videoDetailInfoCell) {
            self.videoDetailInfoCell = [YKVideoDetailInfoCell new];
        }
        self.videoDetailInfoCell.videoDetailData = self.videoDetailData;
        return self.videoDetailInfoCell;
    } else {
        // 评论
        YKCommentCell *commentCell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        YKVideoCommentData *videoCommentData = self.commentListData[(NSUInteger) indexPath.row];
        commentCell.videoCommentData = videoCommentData;
        return commentCell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return section == 3 ? 0 : 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 3) {
        return 20;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return [[UIView alloc] init];
    } else {
        UIView *sectionHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, YKScreenFrameW)];
        sectionHeadView.backgroundColor = [UIColor whiteColor];

        UIImageView *bg = [UIImageView new];
        [sectionHeadView addSubview:bg];
        bg.image = [UIImage imageNamed:@"CommentsBg"];
        [bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(-3);
            make.width.mas_equalTo(72);
            make.centerY.mas_equalTo(sectionHeadView);
        }];

        UILabel *lable = [UILabel new];
        [sectionHeadView addSubview:lable];

        lable.text = @"最新评论";
        lable.textColor = [UIColor whiteColor];
        lable.font = [UIFont systemFontOfSize:14];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(3);
            make.width.mas_equalTo(100);
            make.centerY.mas_equalTo(sectionHeadView);
        }];
        return sectionHeadView;
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
        (NSInteger)section {
    if (section == 3) {
        return self.commentListData.count;
    } else {
        return 1;
    }
}

#pragma mark YKVideoBottomCommentViewDelegate

/**
*  点击评论
*/
- (void)commentAction {
    YKEditCommentView *editCommentView = [[YKEditCommentView alloc] initWithVideoId:self.videoId];
    editCommentView.willShowView = self.view;
    editCommentView.delegate = self;
    self.editCommentView = editCommentView;
    
}

- (void)cancleActionClick
{
    [self.editCommentView removeFromSuperview];
}


/**
*  分享
*/
- (void)shareAction {
    NSLog(@"shareAction");
    [ShareBackView showBackViewWithBlock:^(NSInteger i) {
        ShareType type;
        if (i == 0) {
            type = ShareTypeWeixiTimeline;
        } else if (i == 1) {
            type = ShareTypeWeixiSession;
        } else if (i == 2) {
            type = ShareTypeSinaWeibo;
        } else if (i == 3) {
            type = ShareTypeQQ;
        }
        [YKShareNewsTool shareWithTitle:@""
                                summary:@""
                               shareUrl:@""
                               imageUrl:@""
                                   type:type];
    }];
}

#pragma mark YKEditCommentViewDelegate

/**
*  评论成功
*/
- (void)editCommentViewcommentFinished {
    

}

#pragma mark YKVideoDetailAppointmentCellDelegate

- (void)videoDetailAppointmentCellApplyAcion {
    NSLog(@"videoDetailAppointmentCellApplyAcion");
    if (![YKUserTools isLogin]) {
        YKLoginViewController *loginViewController = [[YKLoginViewController alloc] init];
        [self.navigationController pushViewController:loginViewController animated:YES];
        return;
    }
    [YKApiRequestServer userApplyWithVideoId:self.videoId success:^{
                [YKProgressHDTool reminderWithTitle:@"报名成功"];
            }
                                     failure:^(NSString *error) {
                                         [YKProgressHDTool reminderWithTitle:error];
                                     }];
}

- (void)videoDetailAppointmentCellAppointmentAcion {
    NSLog(@"videoDetailAppointmentCellAppointmentAcion");
    if (![YKUserTools isLogin]) {
        YKLoginViewController *loginViewController = [[YKLoginViewController alloc] init];
        [self.navigationController pushViewController:loginViewController animated:YES];
        return;
    }
    [YKApiRequestServer addReservationWithAlbumId:self.videoId success:^{
                [YKProgressHDTool reminderWithTitle:@"预约成功"];
            }
                                          failure:^(NSString *error) {
                                              [YKProgressHDTool reminderWithTitle:error];
                                          }];
}
@end