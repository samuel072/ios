//
// Created by 杨虎 on 15/7/30.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKVideoPlayView.h"
#import "VMediaPlayer.h"
#import "XCProgressSlider.h"
#import "UIImageView+WebCache.h"

static const CGFloat kBottomMenuViewHeight = 40;

@interface YKVideoPlayView () <VMediaPlayerDelegate, XCProgressSliderDelegate>
/** 视频播放器 */
@property(nonatomic, strong) VMediaPlayer *mMediaPlaye;
/** 视频播放器 */
@property(nonatomic, strong) UIImageView *thumbImageView;
/** 播放，暂停按钮*/
@property(nonatomic, strong) UIButton *playButton;
/** 播放，暂停按钮*/
@property(nonatomic, strong) UIButton *zoomButton;
/** 当前播放时长 */
@property(nonatomic, strong) UILabel *playTimeLabel;
/** 视频时长 */
@property(nonatomic, strong) UILabel *totalyTimeLabel;
/** 底部菜单布局*/
@property(nonatomic, strong) UIView *bottomMenuView;
/** 关闭，开启滚动字幕 */
//@property(nonatomic, strong) UIButton *switchScrollCaptionButton;
/** 进度条 */
@property(nonatomic, strong) XCProgressSlider *videoProgressSlider;
/** 每秒刷新播放时间 */
@property(nonatomic, strong) NSTimer *timer;
/** 是否在拖动 */
@property(nonatomic, assign, getter=isProgressSliderDidStart) BOOL progressSliderDidStart;
@property(nonatomic, assign) CGRect oldFrame;
@property(nonatomic, assign) BOOL showMenu;

@end

@implementation YKVideoPlayView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    _oldFrame = frame;
    _autoPalyVideo = NO;
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(switchShowMenuAction)];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:tapGestureRecognizer];
        _showMenu = YES;
        
        _thumbImageView = [UIImageView new];
        [self addSubview:_thumbImageView];
        [_thumbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(frame.size.width);
            make.height.mas_equalTo(frame.size.height);
        }];
        
        _bottomMenuView = [UIView new];
        [self addSubview:_bottomMenuView];
        _bottomMenuView.backgroundColor = RGBCOLORA(0, 0, 0, 0.7f);
        [_bottomMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(frame.size.width);
            make.height.mas_equalTo(kBottomMenuViewHeight);
            make.top.mas_equalTo(frame.size.height - kBottomMenuViewHeight);
            make.left.mas_equalTo(0);
        }];
        
        _zoomButton = [UIButton new];
        [_bottomMenuView addSubview:_zoomButton];
        [_zoomButton setBackgroundImage:[UIImage imageNamed:@"ZoomVideoIcon"]
                               forState:UIControlStateNormal];
        [_zoomButton addTarget:self
                        action:@selector(zoomVideoAction)
              forControlEvents:UIControlEventTouchUpInside];
        [_zoomButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(_bottomMenuView);
            make.width.with.height.mas_equalTo(20);
        }];
        
        //        _switchScrollCaptionButton = [UIButton new];
        //        [_bottomMenuView addSubview:_switchScrollCaptionButton];
        //        [_switchScrollCaptionButton setBackgroundImage:[UIImage imageNamed:@"OpenScrollCaptionIcon"]
        //                                              forState:UIControlStateNormal];
        //        [_switchScrollCaptionButton addTarget:self
        //                                       action:@selector(switchScrollCaptionAction)
        //                             forControlEvents:UIControlEventTouchUpInside];
        //        [_switchScrollCaptionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.right.mas_equalTo(_zoomButton.mas_left).offset(-15);
        //            make.width.mas_equalTo(40);
        //            make.height.mas_equalTo(15);
        //            make.centerY.mas_equalTo(_zoomButton);
        //
        //        }];
        
        _playButton = [UIButton new];
        [_bottomMenuView addSubview:_playButton];
        [_playButton setBackgroundImage:[UIImage imageNamed:@"PlayVideoIcon"]
                               forState:UIControlStateNormal];
        [_playButton addTarget:self
                        action:@selector(switchPlayAction)
              forControlEvents:UIControlEventTouchUpInside];
        [_playButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.with.height.mas_equalTo(20);
            make.centerY.mas_equalTo(_bottomMenuView);
            make.left.mas_equalTo(10);
        }];
        
        
        _videoProgressSlider = [[XCProgressSlider alloc] initWithFrame:CGRectMake(
                                                                                  40,
                                                                                  0,
                                                                                  YKScreenFrameW - 90,
                                                                                  kBottomMenuViewHeight)];
        [_bottomMenuView addSubview:_videoProgressSlider];
        _videoProgressSlider.value = 0.0f;
        _videoProgressSlider.progress = 0.0f;
        _videoProgressSlider.height = 2;
        _videoProgressSlider.delegate = self;
        
        _totalyTimeLabel = [UILabel new];
        [_bottomMenuView addSubview:_totalyTimeLabel];
        _totalyTimeLabel.text = @"00:00";
        _totalyTimeLabel.font = [UIFont systemFontOfSize:11];
        _totalyTimeLabel.textColor = [UIColor whiteColor];
        [_totalyTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_zoomButton.mas_left).offset(-13);
            make.top.mas_equalTo(_videoProgressSlider.mas_bottom).offset(-18);
            make.height.mas_equalTo(20);
        }];
        
        UILabel *slashLabel = [UILabel new];
        [_bottomMenuView addSubview:slashLabel];
        slashLabel.text = @"/";
        slashLabel.font = [UIFont systemFontOfSize:11];
        slashLabel.textColor = [UIColor whiteColor];
        [slashLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_totalyTimeLabel.mas_left).offset(-5);
            make.centerY.mas_equalTo(_totalyTimeLabel);
            make.height.mas_equalTo(20);
        }];
        
        _playTimeLabel = [UILabel new];
        [_bottomMenuView addSubview:_playTimeLabel];
        _playTimeLabel.text = @"00:00";
        _playTimeLabel.textAlignment = NSTextAlignmentRight;
        _playTimeLabel.font = [UIFont systemFontOfSize:11];
        _playTimeLabel.textColor = [UIColor whiteColor];
        [_playTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(slashLabel.mas_left).offset(-5);
            make.centerY.mas_equalTo(_totalyTimeLabel);
            make.height.mas_equalTo(20);
        }];
    }
    return self;
}

- (void)setVideoInfoWithVideoUrl:(NSString *)videoUrl thumbImageUrl:(NSString *)thumbImageUrl {
    if ([videoUrl hasSuffix:@".m3u8"]) {
        self.videoType = YKLiveVideo;
        self.videoProgressSlider.userInteractionEnabled = NO;
    }
    [self cancelPlayVideo];
    self.thumbImageView.hidden = NO;
    [self.thumbImageView sd_setImageWithURL:[thumbImageUrl toUrl]];
    self.mMediaPlaye = [VMediaPlayer sharedInstance];
    [self.mMediaPlaye setupPlayerWithCarrierView:self withDelegate:self];
    [self.mMediaPlaye setDataSource:[videoUrl toUrl] header:nil];
    [self.mMediaPlaye prepareAsync];
}

- (void)setVideoPlayInfo:(YKAlbumDetailDataVideoInfo *)videoPlayInfo{
    _videoPlayInfo = videoPlayInfo;
    [self setVideoInfoWithVideoUrl:@"http://59.175.153.138/video/s10008-hbws/index.m3u8"
                     thumbImageUrl:videoPlayInfo.thumbnail];
}

//- (void)setHomeVideoListDataDataModel:(YKHomeVideoListDataDataModel *)homeVideoListDataDataModel {
//    [self setVideoInfoWithVideoUrl:homeVideoListDataDataModel.url
//                     thumbImageUrl:homeVideoListDataDataModel.pic];
//}

//- (void)setAlbumVideoListData:(YKAlbumVideoListData *)albumVideoListData {
////    _albumVideoListData = albumVideoListData;
//    [self setVideoInfoWithVideoUrl:albumVideoListData.videoPlayInfo.videoUrl
//                     thumbImageUrl:albumVideoListData.standardPic];
//}
//
//- (void)setAlbumDetailData:(YKAlbumDetailData *)albumDetailData {
////    _albumDetailData = albumDetailData;
//    [self setVideoInfoWithVideoUrl:albumDetailData.latestVideo.videoPlayInfo.videoUrl
//                     thumbImageUrl:albumDetailData.standardPic];
//}

- (void)updatePlayTimer {
    if ([self.mMediaPlaye getDuration] == 0.0) {
        self.videoProgressSlider.value = 0.0;
    } else {
        self.totalyTimeLabel.text = [self calculateTime:[self.mMediaPlaye getDuration]];
        self.playTimeLabel.text = [self calculateTime:[self.mMediaPlaye getCurrentPosition]];
        self.videoProgressSlider.value = (float) [self.mMediaPlaye getCurrentPosition] / (float) [self.mMediaPlaye getDuration];
        self.videoProgressSlider.progress = (float) [self.mMediaPlaye getBufferProgress] / 100.0f;
    }
}

- (NSString *)calculateTime:(long)a {
    a = a / 1000;
    long hour = a / 3600;
    long minute = a % 3600 / 60;
    long second = a % 60;
    if (hour > 0) {
        return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", hour, minute, second];
    }
    return [NSString stringWithFormat:@"%02ld:%02ld", minute, second];;
}

#pragma mark Action

- (void)switchShowMenuAction{
    self.showMenu = !self.showMenu;
    self.bottomMenuView.hidden = !self.showMenu;
}

/**
 * 播放
 */
- (void)playVideoAction {
    self.playButton.selected = YES;
    if (!self.mMediaPlaye.isPlaying) {
        [self.mMediaPlaye start];
    }
    if (!self.thumbImageView.hidden) {
        self.thumbImageView.hidden = YES;
    }
    // 播放
    [_playButton setBackgroundImage:[UIImage imageNamed:@"PaueVideoIcon"]
                           forState:UIControlStateNormal];
    if (self.videoType != YKLiveVideo){
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                      target:self
                                                    selector:@selector(updatePlayTimer)
                                                    userInfo:nil
                                                     repeats:YES];
    }
}

/**
 * 暂停
 */
- (void)pauseVideoAction {
    if (self.timer) {
        [self.timer invalidate];
    }
    if (self.mMediaPlaye.isPlaying) {
        [self.mMediaPlaye pause];
    }
    // 暂停
    [_playButton setBackgroundImage:[UIImage imageNamed:@"PlayVideoIcon"]
                           forState:UIControlStateNormal];
}


/**
 * 字幕开关
 */
- (void)switchScrollCaptionAction {
    
}

/**
 * 播放开关
 */
- (void)switchPlayAction {
    self.playButton.selected = !self.playButton.selected;
    if (!self.playButton.selected) {
        [self pauseVideoAction];
    } else {
        [self playVideoAction];
    }
}

/**
 * 是否全屏
 */
- (void)zoomVideoAction {
    self.zoomButton.selected = !self.zoomButton.selected;
    [self setNeedsUpdateConstraints];
    if (self.zoomButton.selected) {
        // 全屏
        [self.delegate zoomVideoPlay:YES];
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        [UIView animateWithDuration:0.5
                         animations:^{
                             self.transform = CGAffineTransformMakeRotation((CGFloat) (M_PI / 2));//旋转180度
                             self.frame = CGRectMake(0, 0, YKScreenFrameW, YKScreenFrameH);
                             [self.bottomMenuView mas_updateConstraints:^(MASConstraintMaker *make) {
                                 make.top.mas_equalTo(self.frame.size.width - kBottomMenuViewHeight);
                                 make.width.mas_equalTo(self.frame.size.height);
                             }];
                             [self.thumbImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                                 make.width.mas_equalTo(YKScreenFrameH);
                                 make.height.mas_equalTo(YKScreenFrameW);
                             }];
                             self.videoProgressSlider.width = self.frame.size.height - 90;
                             [self.videoProgressSlider changeView];
                             [self layoutIfNeeded];
                         }
                         completion:^(BOOL finished) {
                             
                         }];
    } else {
        [self.delegate zoomVideoPlay:NO];
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        [UIView animateWithDuration:0.5
                         animations:^{
                             self.transform = CGAffineTransformIdentity;// CGAffineTransformMakeRotation((CGFloat) (M_PI * 2));//旋转180度
                             self.transform = CGAffineTransformMakeRotation(0);;
                             self.frame = self.oldFrame;
                             [self.bottomMenuView mas_updateConstraints:^(MASConstraintMaker *make) {
                                 make.top.mas_equalTo(self.frame.size.height - kBottomMenuViewHeight);
                                 make.width.mas_equalTo(self.frame.size.width);
                             }];
                             
                             [self.thumbImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                                 make.width.mas_equalTo(self.frame.size.width);
                                 make.height.mas_equalTo(self.frame.size.height);
                             }];
                             self.videoProgressSlider.width = self.frame.size.width - 90;
                             [self.videoProgressSlider changeView];
                             [self layoutIfNeeded];
                         } completion:^(BOOL finished) {
                             
                         }];
    }
    
    
}

- (void)cancelPlayVideo {
    [self restVideoAction];
    [self.mMediaPlaye unSetupPlayer];
}


- (void)restVideoAction {
    [self pauseVideoAction];
    [self.mMediaPlaye reset];
    self.videoProgressSlider.progress = 0;
    self.videoProgressSlider.value = 0;
    self.playTimeLabel.text = @"00:00";
    self.totalyTimeLabel.text = @"00:00";
}

#pragma  mark  VMediaPlayerDelegate

// 当'播放器准备完成'时, 该协议方法被调用, 我们可以在此调用 [player start]
// 来开始音视频的播放.
- (void)mediaPlayer:(VMediaPlayer *)player didPrepared:(id)arg {
    if (self.autoPalyVideo) {
        [player start];
        self.thumbImageView.hidden = YES;
        [self playVideoAction];
    }
}

// 当'该音视频播放完毕'时, 该协议方法被调用, 我们可以在此作一些播放器善后
// 操作, 如: 重置播放器, 准备播放下一个音视频等
- (void)mediaPlayer:(VMediaPlayer *)player playbackComplete:(id)arg {
    [self restVideoAction];
}

// 如果播放由于某某原因发生了错误, 导致无法正常播放, 该协议方法被调用, 参
// 数 arg 包含了错误原因.
- (void)mediaPlayer:(VMediaPlayer *)player error:(id)arg {
    NSLog(@"播放视频失败了%@", arg);
    [self restVideoAction];
}

#pragma mark - XCProgressSliderDelegate

- (void)progressSliderDidStart:(XCProgressSlider *)progressSlider value:(float)vlaue {
    self.progressSliderDidStart = YES;
}

- (void)progressSliderDidMoveEnd:(XCProgressSlider *)progressSlider value:(float)vlaue {
    self.progressSliderDidStart = NO;
    //    [self.mMediaPlaye seekTo:1000];
}

- (void)progressSliderChange:(XCProgressSlider *)progressSlider value:(float)vlaue {
    
}

@end