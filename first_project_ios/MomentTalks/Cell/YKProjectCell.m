//
// Created by 杨虎 on 15/7/29.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "YKProjectCell.h"


@interface YKProjectCell ()
/** 缩略图 */
@property(nonatomic, strong) UIImageView *thumbImageView;
/** 标题 */
@property(nonatomic, strong) UILabel *titleLabel;
/** 喜欢 */
@property(nonatomic, strong) UILabel *likeLabel;
/** 人气 */
@property(nonatomic, strong) UILabel *watchLable;
/** 人气图标 */
@property(nonatomic, strong) UIImageView *watchIconImageView;
/** 喜欢图标 */
@property(nonatomic, strong) UIImageView *likeIconImageView;
/** 播放图标 */
@property(nonatomic, strong) UIImageView *playImageView;
/** 黑色透明View */
@property(nonatomic, strong) UIView *transparentView;
/** 视频标记 */
@property(nonatomic, strong) UIImageView *videoTagImageView;
@end

@implementation YKProjectCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];

        _thumbImageView = [UIImageView new];
        [self.contentView addSubview:_thumbImageView];
        _thumbImageView.image = [UIImage imageNamed:@"projectThumb.jpg"];
        _thumbImageView.layer.masksToBounds = YES;
        _thumbImageView.layer.cornerRadius = 6;
        [_thumbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(10);
            make.bottom.mas_equalTo(0);
        }];

        _transparentView = [UIView new];
        [_thumbImageView addSubview:_transparentView];
        _transparentView.backgroundColor = RGBCOLORA(0, 0, 0, 0.5f);
        [_transparentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(30);
            make.bottom.mas_equalTo(0);
        }];

        _likeLabel = [UILabel new];
        [_transparentView addSubview:_likeLabel];
        _likeLabel.font = [UIFont systemFontOfSize:11];
        _likeLabel.text = @"11212";
        _likeLabel.textColor = [UIColor whiteColor];
        [_likeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-5);
            make.height.mas_equalTo(20);
            make.centerY.mas_equalTo(_transparentView);
        }];

        _likeIconImageView = [UIImageView new];
        [_transparentView addSubview:_likeIconImageView];
        _likeIconImageView.image = [UIImage imageNamed:@"LikePressIcon"];
        [_likeIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.with.height.mas_equalTo(14);
            make.right.mas_equalTo(_likeLabel.mas_left).offset(-2);
            make.centerY.mas_equalTo(_likeLabel).offset(1);
        }];

        _watchLable = [UILabel new];
        [_transparentView addSubview:_watchLable];
        _watchLable.font = _likeLabel.font;
        _watchLable.textColor = _likeLabel.textColor;
        _watchLable.text = @"8921";
        [_watchLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_likeIconImageView.mas_left).offset(-5);
            make.height.mas_equalTo(20);
            make.centerY.mas_equalTo(_likeLabel);
        }];

        _watchIconImageView = [UIImageView new];
        [_transparentView addSubview:_watchIconImageView];
        _watchIconImageView.image = [UIImage imageNamed:@"EyeIcon"];
        [_watchIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.with.height.mas_equalTo(14);
            make.right.mas_equalTo(_watchLable.mas_left).offset(-3);
            make.centerY.mas_equalTo(_likeLabel);
        }];

        _titleLabel = [UILabel new];
        [_transparentView addSubview:_titleLabel];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.numberOfLines = 1;
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(5);
            // 好像有问题，就直接设置了width,后期优化
//            make.right.mas_equalTo(_watchIconImageView.mas_left).offset(-5);
            make.width.mas_equalTo(YKScaleNum(180));
            make.height.mas_equalTo(20);
            make.centerY.mas_equalTo(_watchIconImageView);
        }];

        _playImageView = [UIImageView new];
        [_thumbImageView addSubview:_playImageView];
        _playImageView.image = [UIImage imageNamed:@"ProjectCellPlayIcon"];
        [_playImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.with.height.mas_equalTo(40);
            make.center.mas_equalTo(_thumbImageView);
        }];

        _videoTagImageView = [UIImageView new];
        [_thumbImageView addSubview:_videoTagImageView];
        _videoTagImageView.image = [UIImage imageNamed:@"VideoHotTagIcon"];
        [_videoTagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.with.height.mas_equalTo(30);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
        }];
    }

    return self;
}

- (void)setVideoListDataModel:(YKHomeVideoListDataDataModel *)videoListDataModel {
    [self.thumbImageView sd_setImageWithURL:[videoListDataModel.pic toUrl]];
    self.titleLabel.text = videoListDataModel.name;
    self.likeLabel.text = videoListDataModel.likeCount;
    self.watchLable.text = videoListDataModel.viewCount;
    self.videoTagImageView.hidden = ![videoListDataModel.category isEqualToString:@"2"];
}

- (void)setProjectListData:(YKProjectListData *)projectListData {
    self.videoTagImageView.hidden = YES;
    self.watchIconImageView.hidden = YES;
    self.watchLable.hidden = YES;
    self.likeIconImageView.hidden = YES;
    self.likeLabel.hidden = YES;
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
        make.height.mas_equalTo(20);
        make.centerY.mas_equalTo(_watchIconImageView);
    }];
    [self.thumbImageView sd_setImageWithURL:[projectListData.standardPic toUrl]];
    self.titleLabel.text = projectListData.name;
}

@end