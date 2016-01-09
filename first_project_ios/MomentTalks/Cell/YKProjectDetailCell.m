//
// Created by 杨虎 on 15/7/31.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKProjectDetailCell.h"

@interface YKProjectDetailCell ()
/** 标题 */
@property(nonatomic, strong) UILabel *titleLabel;
/** 发布时间 */
@property(nonatomic, strong) UILabel *timeLabel;
/** 时长 */
@property(nonatomic, strong) UILabel *lengthLable;
@end

@implementation YKProjectDetailCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.selectionStyle = UITableViewCellSelectionStyleNone;

        _titleLabel = [UILabel new];
        [self.contentView addSubview:_titleLabel];
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.text = @"我们欠上辈子人一个温柔的倾听";
        _titleLabel.textColor = [UIColor blackColor];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(22);
        }];

        _lengthLable = [UILabel new];
        [self.contentView addSubview:_lengthLable];
        _lengthLable.font = [UIFont systemFontOfSize:13];
        _lengthLable.text = @"时长：48分40秒";
        _lengthLable.textAlignment = NSTextAlignmentRight;
        _lengthLable.textColor = RGBCOLORA(98, 98, 98, 1);
        [_lengthLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(22);
            make.bottom.mas_equalTo(-6);
        }];

        _timeLabel = [UILabel new];
        [self.contentView addSubview:_timeLabel];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.text = @"一小时前更新";
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.textColor = RGBCOLORA(98, 98, 98, 1);
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(22);
            make.left.mas_equalTo(10);
            make.bottom.mas_equalTo(_lengthLable.mas_bottom);
        }];
    }
    return self;
}


- (void)setAlbumVideoListData:(YKAlbumVideoListData *)albumVideoListData {
    self.titleLabel.text = albumVideoListData.name;
    self.timeLabel.text = [self getTimeString:albumVideoListData.showTime];
    self.lengthLable.text = [albumVideoListData getDurationTime];
}

- (NSString *)getTimeString:(NSString *)time {
    double date1 = [time longLongValue] / 1000;
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:date1];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:MM"];
    NSString *confromTimespStr = [dateFormatter stringFromDate:date2];
    return confromTimespStr;
}

- (void)setSelect:(BOOL)select {
    if (select) {
        self.titleLabel.textColor = YKThemeColor;
    } else {
        self.titleLabel.textColor = [UIColor blackColor];
    }
}
@end