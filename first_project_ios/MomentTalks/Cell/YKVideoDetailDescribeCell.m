//
// Created by 杨虎 on 15/8/1.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKVideoDetailDescribeCell.h"

@interface YKVideoDetailDescribeCell ()
@property(nonatomic, strong) UILabel *describeLabel;
@end

@implementation YKVideoDetailDescribeCell


- (instancetype)init {
    self = [super init];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        UILabel *headLabel = [UILabel new];
        [self.contentView addSubview:headLabel];
        headLabel.textColor = YKThemeColor;
        headLabel.text = @"活动详情";
        [headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.width.mas_equalTo(100);
            make.centerX.mas_equalTo(self.contentView);
            make.height.mas_equalTo(20);
        }];


//活动详情 右边的箭头，可开关闭 活动详情
        UIButton *packButton = [UIButton new];
        [self.contentView addSubview:packButton];
        [packButton setBackgroundImage:[UIImage imageNamed:@"DevelopDown"] forState:UIControlStateNormal];
        [packButton setBackgroundImage:[UIImage imageNamed:@"DevelopUp"] forState:UIControlStateSelected];
        [packButton addTarget:self action:@selector(packDescribeAction:) forControlEvents:UIControlEventTouchUpInside];
        [packButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(headLabel);
            make.width.with.height.mas_equalTo(10);
        }];

        _describeLabel = [UILabel new];
        [self.contentView addSubview:_describeLabel];
        _describeLabel.numberOfLines = 0;
        _describeLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _describeLabel.text = @"7月30日下午，中共中央政治局就中国人民抗日战争的回顾和思考进行第二十五次集体学习。";
        _describeLabel.font = [UIFont systemFontOfSize:15];
        [_describeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(40);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(-10);
        }];
    }

    return self;
}

- (void)packDescribeAction:(UIButton *)packButton {
    packButton.selected = !packButton.selected;
    [self.delegate videoDetailDescribeCellPackDescribe:packButton.selected];
    self.describeLabel.hidden = packButton.selected;
    if (packButton) {
        [self.describeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(30);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(0);
        }];
    } else {
        [self.describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(-10);
        }];
    }
}

- (void)setDescribeString:(NSString *)describeString {
    self.describeLabel.text = describeString;
}

@end