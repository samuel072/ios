//
// Created by 杨虎 on 15/7/30.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKVideoItemView.h"
#import "UIImageView+WebCache.h"
#import "YKHomeVideoListDataDataModel.h"

@interface YKVideoItemView ()

@end

@implementation YKVideoItemView

- (instancetype)init {
    self = [super init];
    if (self) {

        _titleLabel = [UILabel new];
        [self addSubview:_titleLabel];
        _titleLabel.text = @"雷军：为梦想拼一下，人生才圆满。";
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLabel.textColor = RGBCOLORA(98, 98, 98, 1);
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-3);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(20);
        }];

        _thumbImageView = [UIImageView new];
        [self addSubview:_thumbImageView];
        _thumbImageView.image = [UIImage imageNamed:@"projectThumb.jpg"];
        _thumbImageView.layer.masksToBounds = YES;
        _thumbImageView.layer.cornerRadius = 6;
        [_thumbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(_titleLabel.mas_top).offset(-3);
        }];

        _transparentView = [UIView new];
        [_thumbImageView addSubview:_transparentView];
        _transparentView.backgroundColor = RGBCOLORA(0, 0, 0, 0.5f);
        [_transparentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(20);
            make.bottom.mas_equalTo(0);
        }];

        _timeLabel = [UILabel new];
        [_transparentView addSubview:_timeLabel];
        _timeLabel.text = @"7-19 18:59";
        _timeLabel.font = [UIFont systemFontOfSize:11];
        _timeLabel.textColor = [UIColor whiteColor];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(3);
            make.right.mas_equalTo(-5);
            make.height.mas_equalTo(_thumbImageView.mas_height);
            make.centerY.mas_equalTo(_transparentView);
        }];

//        _albumNameLabel = [UILabel new];
//        [_transparentView addSubview:_albumNameLabel];
//        _albumNameLabel.font = [UIFont systemFontOfSize:11];
//        _albumNameLabel.text = @"传奇女人";
//        _albumNameLabel.textColor = [UIColor whiteColor];
//        _albumNameLabel.textAlignment = NSTextAlignmentRight;
//        _albumNameLabel.numberOfLines = 1;
//        _albumNameLabel.lineBreakMode = NSLineBreakByWordWrapping;
//        [_albumNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(_timeLabel.mas_right).offset(20);
//            make.right.mas_equalTo(-3);
//            make.height.mas_equalTo(_thumbImageView.mas_height);
//            make.centerY.mas_equalTo(_transparentView);
//        }];
    }

    return self;
}

- (NSString *)getTimeString:(long)time {
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    return [dateFormatter stringFromDate:confromTimesp];
}

- (void)setListenToMeData:(YKListenToMeData *)listenToMeData {
    self.titleLabel.text = listenToMeData.title;
    [self.thumbImageView sd_setImageWithURL:[listenToMeData.thumbnail toUrl]];
    self.timeLabel.text = listenToMeData.start_time;
}

- (void)setExploreListInfo:(YKExploreListInfoInfo *)exploreListInfo {
    self.titleLabel.text = exploreListInfo.title;
    [self.thumbImageView sd_setImageWithURL:[exploreListInfo.thumbnail toUrl]];
    self.timeLabel.text = [self getTimeString:(long) [exploreListInfo.startTime.time longLongValue]];
}

- (void)setHomeVideoListDataDataModel:(YKHomeVideoListDataDataModel *)homeVideoListDataDataModel {
    self.titleLabel.text = homeVideoListDataDataModel.name;
    [self.thumbImageView sd_setImageWithURL:[homeVideoListDataDataModel.pic toUrl]];
    self.timeLabel.text = homeVideoListDataDataModel.showtime;
}

@end