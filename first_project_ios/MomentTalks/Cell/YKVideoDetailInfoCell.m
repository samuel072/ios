//
// Created by 杨虎 on 15/8/14.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "YKVideoDetailInfoCell.h"
#import "YKVideoDetailData.h"
#import "YKApiRequestServer.h"

@interface YKVideoDetailInfoCell ()
/** 标题 */
@property(nonatomic, strong) UILabel *titleLabel;
/** 喜欢 */
@property(nonatomic, strong) UILabel *likeLabel;
/** 人气 */
@property(nonatomic, strong) UILabel *watchLable;
/** 地点 */
@property(nonatomic, strong) UILabel *placeLabel;
/** 类型 */
@property(nonatomic, strong) UILabel *typeLabel;
/** 标签 */
@property(nonatomic, strong) UILabel *tagLabel;
/** 时间 */
@property(nonatomic, strong) UILabel *timeLabel;
@property(nonatomic, strong) UIButton *followButton;
@property(nonatomic, assign) BOOL requestSuccess;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UIImageView *headPicImageView;

/** 人气图标 */
@property(nonatomic, strong) UIImageView *watchIconImageView;
/** 喜欢图标 */
@property(nonatomic, strong) UIImageView *likeIconImageView;
@end

@implementation YKVideoDetailInfoCell

- (instancetype)init {
    self = [super init];
    if (self) {
        _requestSuccess = NO;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView *topView = [UIView new];
        [self.contentView addSubview:topView];
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.with.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(70);
        }];

        _headPicImageView = [UIImageView new];
        [topView addSubview:_headPicImageView];
        _headPicImageView.layer.masksToBounds = YES;
        _headPicImageView.layer.cornerRadius = 15;
        _headPicImageView.image = [UIImage imageNamed:@"avataraImageView.jpg"];
        [_headPicImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.with.height.mas_equalTo(30);
            make.top.mas_equalTo(8);
            make.left.mas_equalTo(10);
        }];

        self.nameLabel = [UILabel new];
        [self.contentView addSubview:self.nameLabel];
        self.nameLabel.font = [UIFont systemFontOfSize:13];
        self.nameLabel.textColor = [UIColor grayColor];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_headPicImageView);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(250);
            make.left.mas_equalTo(_headPicImageView.mas_right).offset(5);
        }];

        self.followButton = [UIButton new];
        [self.contentView addSubview:self.followButton];
        self.followButton.selected = YES;
        [self.followButton addTarget:self action:@selector(followAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.followButton setBackgroundImage:[UIImage imageNamed:@"Follow"] forState:UIControlStateSelected];
        [self.followButton setBackgroundImage:[UIImage imageNamed:@"ONFollow"] forState:UIControlStateNormal];
        [self.followButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(30);
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(_headPicImageView);
        }];


        _likeLabel = [UILabel new];
        [self.contentView addSubview:_likeLabel];
        _likeLabel.font = [UIFont systemFontOfSize:11];
        _likeLabel.textColor = [UIColor grayColor];
        [_likeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(20);
            make.top.mas_equalTo(topView.mas_bottom).offset(20);
        }];

        _likeIconImageView = [UIImageView new];
        [self.contentView addSubview:_likeIconImageView];
        _likeIconImageView.image = [UIImage imageNamed:@"LikePressIcon"];
        [_likeIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.with.height.mas_equalTo(14);
            make.right.mas_equalTo(_likeLabel.mas_left).offset(-2);
            make.centerY.mas_equalTo(_likeLabel).offset(1);
        }];

        _watchLable = [UILabel new];
        [self.contentView addSubview:_watchLable];
        _watchLable.font = _likeLabel.font;
        _watchLable.textColor = _likeLabel.textColor;
        _watchLable.text = @"8921";
        [_watchLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_likeIconImageView.mas_left).offset(-5);
            make.height.mas_equalTo(20);
            make.centerY.mas_equalTo(_likeLabel);
        }];

        _watchIconImageView = [UIImageView new];
        [self.contentView addSubview:_watchIconImageView];
        _watchIconImageView.image = [UIImage imageNamed:@"BlackEyeIcon"];
        [_watchIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.with.height.mas_equalTo(14);
            make.right.mas_equalTo(_watchLable.mas_left).offset(-3);
            make.centerY.mas_equalTo(_likeLabel);
        }];

        _titleLabel = [UILabel new];
        [self.contentView addSubview:_titleLabel];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.numberOfLines = 1;
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            // 好像有问题，就直接设置了width,后期优化
//            make.right.mas_equalTo(_watchIconImageView.mas_left).offset(-5);
            make.width.mas_equalTo(YKScaleNum(180));
            make.height.mas_equalTo(20);
            make.centerY.mas_equalTo(_watchIconImageView);
        }];

        UILabel *timeInfoLabel = [UILabel new];
        [self.contentView addSubview:timeInfoLabel];
        timeInfoLabel.text = @"时间:";
        timeInfoLabel.font = [UIFont systemFontOfSize:13];
        timeInfoLabel.textAlignment = NSTextAlignmentLeft;
        [timeInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_titleLabel);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(20);
            make.top.mas_equalTo(_titleLabel.mas_bottom).offset(5);
        }];


        self.timeLabel = [UILabel new];
        [self.contentView addSubview:self.timeLabel];
        self.timeLabel.font = [UIFont systemFontOfSize:13];
        self.timeLabel.textAlignment = NSTextAlignmentLeft;
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(timeInfoLabel.mas_right);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(20);
            make.top.mas_equalTo(timeInfoLabel.mas_top);
        }];

        UILabel *placeInfoLabel = [UILabel new];
        [self.contentView addSubview:placeInfoLabel];
        placeInfoLabel.text = @"地点:";
        placeInfoLabel.font = timeInfoLabel.font;
        placeInfoLabel.textAlignment = NSTextAlignmentLeft;
        [placeInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_titleLabel);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(20);
            make.top.mas_equalTo(timeInfoLabel.mas_bottom).offset(5);
        }];

        self.placeLabel = [UILabel new];
        [self.contentView addSubview:self.placeLabel];
        self.placeLabel.font = placeInfoLabel.font;
        self.placeLabel.textAlignment = NSTextAlignmentLeft;
        [self.placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(placeInfoLabel.mas_right);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(20);
            make.top.mas_equalTo(placeInfoLabel.mas_top);
        }];

        UILabel *typeInfoLabel = [UILabel new];
        [self.contentView addSubview:typeInfoLabel];
        typeInfoLabel.text = @"类型:";
        typeInfoLabel.font = timeInfoLabel.font;
        typeInfoLabel.textAlignment = NSTextAlignmentLeft;
        [typeInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_titleLabel);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(20);
            make.top.mas_equalTo(placeInfoLabel.mas_bottom).offset(5);
        }];

        self.typeLabel = [UILabel new];
        [self.contentView addSubview:self.typeLabel];
        self.typeLabel.font = placeInfoLabel.font;
        self.typeLabel.textAlignment = NSTextAlignmentLeft;
        [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(typeInfoLabel.mas_right);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(20);
            make.top.mas_equalTo(typeInfoLabel.mas_top);
        }];

        UILabel *tagInfoLabel = [UILabel new];
        [self.contentView addSubview:tagInfoLabel];
        tagInfoLabel.text = @"标签:";
        tagInfoLabel.font = timeInfoLabel.font;
        tagInfoLabel.textAlignment = NSTextAlignmentLeft;
        [tagInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_titleLabel);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(20);
            make.top.mas_equalTo(typeInfoLabel.mas_bottom).offset(5);
        }];

        self.tagLabel = [UILabel new];
        [self.contentView addSubview:self.tagLabel];
        self.tagLabel.font = placeInfoLabel.font;
        self.tagLabel.textAlignment = NSTextAlignmentLeft;
        [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(tagInfoLabel.mas_right);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(20);
            make.top.mas_equalTo(tagInfoLabel.mas_top);
        }];

        UIView *infoView = [UIView new];
        [self.contentView addSubview:infoView];
        infoView.layer.masksToBounds = YES;
        infoView.layer.cornerRadius = 10;
        infoView.layer.borderColor = [UIColor grayColor].CGColor;
        infoView.layer.borderWidth = 1;
        [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-5);
            make.left.mas_equalTo(5);
            make.top.mas_equalTo(topView.mas_bottom).offset(10);
            make.bottom.mas_equalTo(self.tagLabel.mas_bottom).offset(10);
        }];
    }

    return self;
}

// 视频关注列表
- (void)requestAttentionList {
    if (self.requestSuccess) {
        return;
    }
    [YKApiRequestServer requestAttentionListWithVideoId:self.videoDetailData.videoId
                                                success:^(NSArray <YKAttentionListData> *data) {
                                                    self.requestSuccess = YES;
                                                    if (data.count == 0) {
                                                        return;
                                                    }
                                                    UIScrollView *scrollView = [UIScrollView new];
                                                    scrollView.backgroundColor = [UIColor whiteColor];
                                                    scrollView.showsHorizontalScrollIndicator = NO;
                                                    [self.contentView addSubview:scrollView];
                                                    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
                                                        make.left.mas_equalTo(_headPicImageView.mas_left);
                                                        make.right.mas_equalTo(-30);
                                                        make.height.mas_equalTo(38);
                                                        make.top.mas_equalTo(_headPicImageView.mas_bottom).offset(4);
                                                    }];

                                                    UIImageView *arrowIconImageView = [UIImageView new];
                                                    [self.contentView addSubview:arrowIconImageView];
                                                    arrowIconImageView.image = [UIImage imageNamed:@"ArrowIcon"];
                                                    [arrowIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                                                        make.centerY.mas_equalTo(scrollView.mas_centerY).offset(-3);
                                                        make.width.with.height.mas_equalTo(20);
                                                        make.right.mas_equalTo(-2);
                                                    }];

                                                    int count = data.count;
                                                    scrollView.contentSize = CGSizeMake((30 + 10) * count, 0);
                                                    UIView *lastView = nil;
                                                    for (int i = 0; i < count; i++) {
                                                        UIImageView *subv = [UIImageView new];
                                                        [scrollView addSubview:subv];
                                                        subv.layer.masksToBounds = YES;
                                                        subv.layer.cornerRadius = 30 / 2;
                                                        subv.backgroundColor = [UIColor redColor];
                                                        YKAttentionListData *attentionListData = data[(NSUInteger) i];
                                                        [subv sd_setImageWithURL:[attentionListData.faceUrl toUrl]];
                                                        [subv mas_makeConstraints:^(MASConstraintMaker *make) {
                                                            make.width.with.height.mas_equalTo(30);
                                                            make.top.mas_equalTo(0);
//                                                            make.centerY.mas_equalTo(container.mas_centerY);
                                                            if (lastView) {
                                                                make.left.mas_equalTo(lastView.mas_right).offset(10);
                                                            } else {
                                                                make.left.mas_equalTo(scrollView.mas_left);
                                                            }
                                                        }];
                                                        lastView = subv;
                                                    }
                                                }
                                                failure:^(NSString *error) {

                                                }];
}

- (void)followAction:(UIButton *)followButton {
    [YKProgressHDTool showProgressHUD];
    if (followButton.isSelected) {
        [YKApiRequestServer userFocusOnWithVideoId:self.videoDetailData.videoId
                                           success:^{
                                               [YKProgressHDTool hideProgressHUD];
                                               followButton.selected = !followButton.selected;
                                           }
                                           failure:^(NSString *error) {
                                               if ([error isEqualToString:@"用户已关注"]) {
                                                   [YKProgressHDTool hideProgressHUD];
                                                   followButton.selected = !followButton.selected;
                                               } else {
                                                   [YKProgressHDTool reminderWithTitle:error];
                                               }
                                           }];
    } else {
        [YKApiRequestServer userUnFocusOnWithVideoId:self.videoDetailData.videoId
                                             success:^{
                                                 [YKProgressHDTool hideProgressHUD];
                                                 followButton.selected = !followButton.selected;
                                             }
                                             failure:^(NSString *error) {
                                                 [YKProgressHDTool reminderWithTitle:error];
                                             }];
    }
}

- (void)setVideoDetailData:(YKVideoDetailData *)videoDetailData {
    _videoDetailData = videoDetailData;
    self.timeLabel.text = [self getTimeStringWithStartTime:videoDetailData.showTime endTime:videoDetailData.endTime];
    self.placeLabel.text = videoDetailData.address;
    self.tagLabel.text = videoDetailData.tag;
    self.typeLabel.text = videoDetailData.vedioType;
    self.likeLabel.text = videoDetailData.likeCount;
    self.watchLable.text = videoDetailData.viewCount;
    self.titleLabel.text = videoDetailData.name;
    self.nameLabel.text = videoDetailData.starringNames;
    if (videoDetailData) {
        [self requestAttentionList];
    }

}

- (NSString *)getTimeStringWithStartTime:(NSString *)startTime endTime:(NSString *)endTime {
    return [NSString stringWithFormat:@"%@ - %@", [self getTimeString:startTime], [self getTimeString:endTime]];
}

- (NSString *)getTimeString:(NSString *)time {
    if (time == nil) {
        return @"";
    }
    double date1 = [time longLongValue] / 1000;
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:date1];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:MM"];
    NSString *confromTimespStr = [dateFormatter stringFromDate:date2];
    return confromTimespStr;
}

@end