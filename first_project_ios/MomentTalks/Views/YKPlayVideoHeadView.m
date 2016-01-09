//
// Created by 杨虎 on 15/8/9.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "YKPlayVideoHeadView.h"
#import "YKVideoBottomMenuView.h"
#import "ShareBackView.h"
#import "YKShareNewsTool.h"

static const CGFloat bottomMenuViewHeight = 40;    // 底部菜单高度


@interface YKPlayVideoHeadView () <YKVideoBottomMenuViewDelegate>
@property(nonatomic, strong) UIImageView *backgroundImageView;
@property(nonatomic, strong) YKVideoBottomMenuView *videoBottomMenuView;
@property(nonatomic, strong) UIImageView *playImageView;
@end

@implementation YKPlayVideoHeadView
- (instancetype)init {

    self = [super initWithFrame:CGRectMake(
            0,
            0,
            YKScreenFrameW,
            YKScreenFrameW / 16 * 9 + bottomMenuViewHeight)];
    if (self) {

        // 视频背景图片
        self.backgroundImageView = [UIImageView new];
        [self addSubview:self.backgroundImageView];
        [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.with.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(-bottomMenuViewHeight);
        }];

        // 播放按钮
        self.playImageView = [UIImageView new];
        [self addSubview:self.playImageView];
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                               action:@selector(playAction:)];
        self.playImageView.userInteractionEnabled = YES;
        self.playImageView.image = [UIImage imageNamed:@"ProjectCellPlayIcon"];
        [self.playImageView addGestureRecognizer:tapGestureRecognizer];
        [self.playImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.with.height.mas_equalTo(60);
            make.center.mas_equalTo(self.backgroundImageView);
        }];

        // 底部菜单
        self.videoBottomMenuView = [YKVideoBottomMenuView new];
        [self addSubview:self.videoBottomMenuView];
        self.videoBottomMenuView.delegate = self;
        self.videoBottomMenuView.backgroundColor = [UIColor whiteColor];
        [self.videoBottomMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.backgroundImageView.mas_bottom);
            make.height.mas_equalTo(bottomMenuViewHeight);
            make.width.mas_equalTo(YKScreenFrameW);
        }];
    }

    return self;
}


- (void)setVideoName:(NSString *)videoName{
    self.videoBottomMenuView.videoName = videoName;
}

- (void)setDelegate:(id <YKPlayVideoHeadViewDelegate>)delegate {
    _delegate = delegate;
    UIViewController *viewController = (UIViewController *) self.delegate;
    self.videoBottomMenuView.showViewController = viewController;
}

- (void)playAction:(id)playAction {
    [self.delegate playVideoHeadViewCheckAction];
}

- (void)setImageViewUrl:(NSString *)imageViewUrl {
    [self.backgroundImageView sd_setImageWithURL:[imageViewUrl toUrl]];
}

- (void)setVideoId:(NSString *)videoId {
    _videoId = videoId;
    self.videoBottomMenuView.videoId = videoId;
}

/**
* 喜欢
*/
- (void)videoBottomMenuLikeAction:(UIButton *)button {

}

/**
* 分享
*/
- (void)videoBottomMenuShareAction {
    [self.delegate playVideoHeadViewShareCheckAction];
}

/**
* 收藏
*/
- (void)videoBottomMenuCollectAction:(UIButton *)button {

}

@end