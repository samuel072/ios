//
// Created by 杨虎 on 15/7/29.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKRankCell.h"
#import "UIImageView+WebCache.h"

@interface YKRankCell ()
/** 缩略图 */
@property(nonatomic, strong) UIImageView *thumbImageView;
/** 标题 */
@property(nonatomic, strong) UILabel *titleLabel;
/** 时间 */
@property(nonatomic, strong) UILabel *timeLabel;
/** 人气 */
@property(nonatomic, strong) UILabel *activeLable;
@end

@implementation YKRankCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        _thumbImageView = [UIImageView new];
        [self.contentView addSubview:_thumbImageView];
        _thumbImageView.image = [UIImage imageNamed:@"rankThumb"];
        _thumbImageView.layer.masksToBounds = YES;
        _thumbImageView.layer.cornerRadius = 5;
        [_thumbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(100);
            make.top.mas_equalTo(10);
            make.height.mas_equalTo(80);
            make.bottom.mas_equalTo(-10);
            make.left.mas_equalTo(10);
        }];

        _titleLabel = [UILabel new];
        [self.contentView addSubview:_titleLabel];
        _titleLabel.text = @"如何做好创业公司CEO";
        _titleLabel.font = [UIFont systemFontOfSize:17];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_thumbImageView.mas_top);
            make.left.mas_equalTo(_thumbImageView.mas_right).offset(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(20);
        }];

        _timeLabel = [UILabel new];
        [self.contentView addSubview:_timeLabel];
        _timeLabel.text = @"2015-7-19";
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.textColor = RGBCOLORA(98, 98, 98, 1);
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_titleLabel.mas_left);
            make.right.mas_equalTo(_titleLabel.mas_right);
            make.height.mas_equalTo(20);
            make.centerY.mas_equalTo(self.contentView);
        }];

        _activeLable = [UILabel new];
        [self.contentView addSubview:_activeLable];
        _activeLable.text = @"人气：10991";
        _activeLable.font = _timeLabel.font;
        _activeLable.textColor = _timeLabel.textColor;
        [_activeLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_titleLabel.mas_left);
            make.right.mas_equalTo(_titleLabel.mas_right);
            make.height.mas_equalTo(20);
            make.bottom.mas_equalTo(_thumbImageView.mas_bottom);
        }];
    }

    return self;
}

- (void)setRankListData:(YKRankListData *)rankListData {
    [self.thumbImageView sd_setImageWithURL:[rankListData.standardPic toUrl]];
    self.titleLabel.text = rankListData.videoName;
    self.timeLabel.text = [self getTimeString:rankListData.time.time];
}


- (NSString *)getTimeString:(NSString *)time {
    double date1 = [time longLongValue] / 1000;
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:date1];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:MM"];
    NSString *confromTimespStr = [dateFormatter stringFromDate:date2];
    return confromTimespStr;
}

@end