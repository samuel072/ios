//
// Created by 杨虎 on 15/7/31.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKVideoBottomMenuView.h"
#import "YKApiRequestServer.h"
#import "YKUserTools.h"
#import "YKLoginViewController.h"
#import "YKProjectDetailViewController.h"

static const NSInteger kTableHeadViewCollecButtonTag = 998;
static const NSInteger kTableHeadViewLikeButtonTag = 992;
static const NSInteger kTableHeadViewShareButtonTag = 993;
static const NSInteger kTableHeadViewTitleLabelTag = 994;

@interface YKVideoBottomMenuView ()
@property(nonatomic, assign) BOOL like;
@property(nonatomic, assign) BOOL collect;
@end

@implementation YKVideoBottomMenuView
- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(loginOutAction)
                                                     name:YKLoginOutSuccessNotificationKey
                                                   object:nil];

        // 分享按钮
        UIButton *shareButton = [UIButton new];
        [self addSubview:shareButton];
        shareButton.tag = kTableHeadViewShareButtonTag;
        [shareButton addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
        [shareButton setBackgroundImage:[UIImage imageNamed:@"PlayViewShareIcon"] forState:UIControlStateNormal];
        [shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.width.with.height.mas_equalTo(20);
            make.centerY.mas_equalTo(self);
        }];

        // 收藏按钮
        UIButton *collectionButton = [UIButton new];
        [self addSubview:collectionButton];
        collectionButton.selected = NO;
        collectionButton.tag = kTableHeadViewCollecButtonTag;
        collectionButton.selected = NO;
        [collectionButton addTarget:self action:@selector(collectAction:) forControlEvents:UIControlEventTouchUpInside];
        [collectionButton setBackgroundImage:[UIImage imageNamed:@"PlayViewCollectIcon"] forState:UIControlStateNormal];
        [collectionButton setBackgroundImage:[UIImage imageNamed:@"PlayViewCollectPressIcon"] forState:UIControlStateSelected];
        [collectionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(shareButton.mas_left).offset(-15);
            make.width.with.height.mas_equalTo(shareButton);
            make.centerY.mas_equalTo(shareButton);
        }];

        // 喜欢按钮
        UIButton *likeButton = [UIButton new];
        [self addSubview:likeButton];
        likeButton.selected = NO;
        likeButton.tag = kTableHeadViewLikeButtonTag;
        [likeButton addTarget:self action:@selector(likeAction:) forControlEvents:UIControlEventTouchUpInside];
        [likeButton setBackgroundImage:[UIImage imageNamed:@"PlayViewLikeIcon"] forState:UIControlStateNormal];
        [likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(collectionButton.mas_left).offset(-15);
            make.width.with.height.mas_equalTo(shareButton);
            make.centerY.mas_equalTo(shareButton);
        }];

        // 标题
        UILabel *titleLabel = [UILabel new];
        [self addSubview:titleLabel];
        titleLabel.tag = kTableHeadViewTitleLabelTag;
        titleLabel.text = @"我是一个焦虑者，并且一个斗士";
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        titleLabel.numberOfLines = 1;
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(likeButton.mas_left).offset(-20);
            make.left.mas_equalTo(5);
            make.centerY.mas_equalTo(self);
            make.height.mas_equalTo(20);
        }];
    }

    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:YKLoginOutSuccessNotificationKey object:nil];
}

- (void)loginOutAction {
    UIButton *likeButton = (UIButton *) [self viewWithTag:kTableHeadViewLikeButtonTag];
    [likeButton setBackgroundImage:[UIImage imageNamed:@"PlayViewLikeIcon"] forState:UIControlStateNormal];
    UIButton *collectionButton = (UIButton *) [self viewWithTag:kTableHeadViewCollecButtonTag];
    collectionButton.selected = NO;
    likeButton.selected = NO;
}

- (void)checkCollection {
    if ([YKUserTools isLogin]) {
        UIButton *collectionButton = (UIButton *) [self viewWithTag:kTableHeadViewCollecButtonTag];
        [YKApiRequestServer checkCollectionWithVideoId:self.videoId success:^{
                    collectionButton.selected = YES;
                }
                                               failure:^(NSString *error) {
                                                   collectionButton.selected = NO;
                                               }];
    }
}

- (void)setVideoName:(NSString *)videoName{
    UILabel *titleLabel = (UILabel *) [self viewWithTag:kTableHeadViewTitleLabelTag];
    titleLabel.text = videoName;
}
- (void)setVideoId:(NSString *)videoId {
    _videoId = videoId;
    [self checkCollection];
//    UIButton *likeButton = (UIButton *) [self viewWithTag:kTableHeadViewLikeButtonTag];
//    [likeButton setBackgroundImage:[UIImage imageNamed:@"PlayViewLikeIcon"] forState:UIControlStateNormal];
}

- (void)setTableHeadViewData:(NSString *)title {
    UILabel *titleLabel = (UILabel *) [self viewWithTag:kTableHeadViewTitleLabelTag];
    titleLabel.text = title;
    UIButton *likeButton = (UIButton *) [self viewWithTag:kTableHeadViewLikeButtonTag];
    UIButton *collectionButton = (UIButton *) [self viewWithTag:kTableHeadViewCollecButtonTag];
    UIButton *shareButton = (UIButton *) [self viewWithTag:kTableHeadViewShareButtonTag];
}

#pragma mark Action

/**
* 喜欢
*/
- (void)likeAction:(UIButton *)button {
    if (button.selected) {
        return;
    }
    if (![YKUserTools isLogin]) {
        YKLoginViewController *loginViewController = [[YKLoginViewController alloc] init];
        if ([self.showViewController isKindOfClass:[YKProjectDetailViewController class]]) {
            loginViewController.pushLoginViewControllerType = PushLoginViewControllerForProjectDetail;
        }
        [self.showViewController.navigationController pushViewController:loginViewController animated:YES];
        return;
    }
    [YKApiRequestServer videoPraiseWithResourceId:self.videoId
                                           status:@"1"
                                          success:^{
                                              button.selected = !button.selected;
                                              [button setBackgroundImage:[UIImage imageNamed:@"PlayViewLikePressIcon"]
                                                                forState:UIControlStateNormal];
                                          }
                                          failure:^(NSString *error) {
                                              if ([error isEqualToString:@"已经点过赞"]) {
                                                  [button setBackgroundImage:[UIImage imageNamed:@"PlayViewLikePressIcon"]
                                                                    forState:UIControlStateNormal];
                                              } else {
                                                  [YKProgressHDTool reminderWithTitle:error];
                                              }
                                          }];
}

/**
* 分享
*/
- (void)shareAction:(UIButton *)button {
    [self.delegate videoBottomMenuShareAction];
}

/**
* 收藏
*/
- (void)collectAction:(UIButton *)button {
    if (![YKUserTools isLogin]) {
        YKLoginViewController *loginViewController = [[YKLoginViewController alloc] init];
        if ([self.showViewController isKindOfClass:[YKProjectDetailViewController class]]) {
            loginViewController.pushLoginViewControllerType = PushLoginViewControllerForProjectDetail;
        }
        [self.showViewController.navigationController pushViewController:loginViewController animated:YES];
        return;
    }

    if (!button.selected) {
        [YKApiRequestServer addCollectionWithVideoId:self.videoId
                                             success:^{
                                                 button.selected = YES;
                                             }
                                             failure:^(NSString *error) {
                                                 [YKProgressHDTool reminderWithTitle:error];
                                             }];
    } else {
        [YKApiRequestServer removeCollectionWithVideoId:self.videoId
                                                success:^{
                                                    button.selected = NO;
                                                }
                                                failure:^(NSString *error) {
                                                    [YKProgressHDTool reminderWithTitle:error];
                                                }];
    }
}

- (void)setHomeVideoListDataDataModel:(YKHomeVideoListDataDataModel *)homeVideoListDataDataModel {
    [self setTableHeadViewData:homeVideoListDataDataModel.name];
}
@end