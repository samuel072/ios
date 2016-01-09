//
// Created by 杨虎 on 15/7/30.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKOneVideoCell.h"
#import "YKExploreListInfo.h"
#import "YKExploreListTalker.h"

@interface YKOneVideoCell ()
/** 缩略图 */
@property(nonatomic, strong) UIImageView *thumbImageView;
/** 透明View */
@property(nonatomic, strong) UIView *transparentView;

@property(nonatomic, strong) UILabel *nameLabel;

@property(nonatomic, strong) UILabel *numLabel;

@end

@implementation YKOneVideoCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;


        _thumbImageView = [UIImageView new];
        [self.contentView addSubview:_thumbImageView];
        _thumbImageView.image = [UIImage imageNamed:@"projectThumb.jpg"];
        _thumbImageView.layer.masksToBounds = YES;
        _thumbImageView.layer.cornerRadius = 6;
        [_thumbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10).priority(999);
            make.right.mas_equalTo(-10).priority(999);
            make.top.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
        }];

        _transparentView = [UIView new];
        [_thumbImageView addSubview:_transparentView];
        _transparentView.backgroundColor = RGBCOLORA(0, 0, 0, 0.5f);
        [_transparentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(25);
            make.bottom.mas_equalTo(0);
        }];

        _nameLabel = [UILabel new];
        [_transparentView addSubview:_nameLabel];
        _nameLabel.font = [UIFont systemFontOfSize:13];
        _nameLabel.text = @"雷军";
        _nameLabel.textColor = RGBCOLORA(243, 143, 11, 1);
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(5);
            make.height.mas_equalTo(20);
            make.centerY.mas_equalTo(_transparentView);
        }];

        UILabel *info1 = [UILabel new];
        [_transparentView addSubview:info1];
        info1.font = [UIFont systemFontOfSize:13];
        info1.text = @"已有";
        info1.textColor = [UIColor whiteColor];
        [info1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_nameLabel.mas_right);
            make.height.mas_equalTo(_nameLabel.mas_height);
            make.centerY.mas_equalTo(_transparentView);
        }];


        _numLabel = [UILabel new];
        [_transparentView addSubview:_numLabel];
        _numLabel.font = [UIFont systemFontOfSize:13];
        _numLabel.text = @"1232";
        _numLabel.textColor = RGBCOLORA(243, 143, 11, 1);
        [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(info1.mas_right);
            make.height.mas_equalTo(_nameLabel.mas_height);
            make.centerY.mas_equalTo(_transparentView);
        }];

        UILabel *info2 = [UILabel new];
        [_transparentView addSubview:info2];
        info2.font = [UIFont systemFontOfSize:13];
        info2.text = @"点击TA来讲";
        info2.textColor = [UIColor whiteColor];
        [info2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_numLabel.mas_right);
            make.height.mas_equalTo(_nameLabel.mas_height);
            make.centerY.mas_equalTo(_transparentView);
        }];

    }
    return self;
}

- (void)setExploreListTalker:(YKExploreListTalker *)exploreListTalker {
    self.nameLabel.text = exploreListTalker.name;
    self.numLabel.text = exploreListTalker.points;
}

@end