//
// Created by 杨虎 on 15/8/1.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "YKCommentCell.h"
#import "YKVideoCommentData.h"

@interface YKCommentCell ()
/** 头像 */
@property(nonatomic, strong) UIImageView *avataraImageView;
/** 昵称 */
@property(nonatomic, strong) UILabel *nameLabel;
/** 发布时间 */
@property(nonatomic, strong) UILabel *timeLabel;
/** 内容 */
@property(nonatomic, strong) UILabel *contentLabel;

@end

@implementation YKCommentCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        CGFloat avataraImageViewSize = 40;
        _avataraImageView = [UIImageView new];
        [self.contentView addSubview:_avataraImageView];
        _avataraImageView.layer.masksToBounds = YES;
        _avataraImageView.image = [UIImage imageNamed:@"AvataraImageView"];
        _avataraImageView.layer.cornerRadius = avataraImageViewSize / 2;
        [_avataraImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10).priority(999);
            make.top.mas_equalTo(10);
            make.height.with.width.mas_equalTo(avataraImageViewSize);
        }];

        _nameLabel = [UILabel new];
        [self.contentView addSubview:_nameLabel];
        _nameLabel.textColor = YKThemeColor;
        _nameLabel.font = [UIFont systemFontOfSize:16];
        _nameLabel.text = @"火星网友";
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_avataraImageView.mas_right).offset(10).priority(999);
            make.top.mas_equalTo(_avataraImageView);
            make.right.mas_equalTo(-10).priority(999);
            make.height.mas_equalTo(20);
        }];

        _timeLabel = [UILabel new];
        [self.contentView addSubview:_timeLabel];
        _timeLabel.textColor = [UIColor grayColor];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_nameLabel);
            make.top.mas_equalTo(_nameLabel.mas_bottom).offset(3).priority(999);
            make.right.mas_equalTo(-10).priority(999);
            make.height.mas_equalTo(20);
        }];

        _contentLabel = [UILabel new];
        [self.contentView addSubview:_contentLabel];
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.font = [UIFont systemFontOfSize:18];
        _contentLabel.numberOfLines = 0;
        
//    uitextfield.text == nil || [uitextfield.text isEqualToString:@""]
//  评论框是否为空
        _contentLabel.text == nil || [_contentLabel.text isEqualToString:@""];
        
        _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_nameLabel.mas_left);
            make.top.mas_equalTo(_timeLabel.mas_bottom).offset(10);
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(-15);
        }];


    }
    return self;
}

- (void)setVideoCommentData:(YKVideoCommentData *)videoCommentData {
    self.contentLabel.text = ((YKVideoCommentContent *) videoCommentData.content[0]).content;
    self.nameLabel.text = videoCommentData.userEntity.userName;
    self.timeLabel.text = [NSString stringWithFormat:@"一刻演讲手机网友%@",[self updateTimeLabel:videoCommentData.buildTime]];
    [self.avataraImageView sd_setImageWithURL:[videoCommentData.userEntity.faceUrl toUrl]];
}

- (NSString *)updateTimeLabel:(NSString *)_lastUpdateTime {
    if (!_lastUpdateTime) {
        return nil;
    }

    // 1.获得年月日
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit;

    // 2.格式化日期
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];

    double date1 = [_lastUpdateTime longLongValue] / 1000;
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:date1];
    NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:date2];
    NSDateComponents *cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];



    if ([cmp1 year] == [cmp2 year] && [cmp1 month] == [cmp2 month] && [cmp1 day] == [cmp2 day] && [cmp1 hour] == [cmp2 hour] && [cmp1 minute] == [cmp2 minute]) {
        formatter.dateFormat = [NSString stringWithFormat:@"%d秒前", cmp2.second - cmp1.second];
    }
    else if ([cmp1 year] == [cmp2 year] && [cmp1 month] == [cmp2 month] && [cmp1 day] == [cmp2 day] && [cmp1 hour] == [cmp2 hour]) {
        formatter.dateFormat = [NSString stringWithFormat:@"%d分钟前", cmp2.minute - cmp1.minute];
    }
    else if ([cmp1 year] == [cmp2 year] && [cmp1 month] == [cmp2 month] && [cmp1 day] == [cmp2 day]) {
        formatter.dateFormat = [NSString stringWithFormat:@"%d小时前", cmp2.hour - cmp1.hour];
    }
    else if ([cmp1 year] == [cmp2 year] && [cmp1 month] == [cmp2 month] && [cmp1 day] == [cmp2 day] - 1) {
        formatter.dateFormat = [NSString stringWithFormat:@"昨天%d:%d", [cmp1 hour], [cmp1 minute]];
    }
    else if ([cmp1 year] == [cmp2 year] && [cmp1 month] == [cmp2 month] && [cmp1 day] == [cmp2 day] - 2) {

        formatter.dateFormat = [NSString stringWithFormat:@"前天%d:%d", [cmp1 hour], [cmp1 minute]];
    }
    else if ([cmp1 year] == [cmp2 year] && [cmp1 month] == [cmp2 month] && [cmp1 day] >= [cmp2 day] - 6) {
        switch ([cmp1 day] - ([cmp2 day] - 6)) {
            case 0:
                formatter.dateFormat = @"6天前";
                break;
            case 1:
                formatter.dateFormat = @"5天前";
                break;
            case 2:
                formatter.dateFormat = @"4天前";
                break;
            case 3:
                formatter.dateFormat = @"3天前";
                break;
            default:
                break;
        }
//        formatter.dateFormat = @"3天前";
    }
    else if ([cmp1 month] < [cmp2 month]) {
        formatter.dateFormat = _lastUpdateTime;
    }


    NSString *time = [formatter stringFromDate:date2];

    // 3.显示日期
    NSString *str = [NSString stringWithFormat:@"%@", time];
    return str;
}
@end