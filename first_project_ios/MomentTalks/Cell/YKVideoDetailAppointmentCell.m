//
// Created by 杨虎 on 15/8/14.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKVideoDetailAppointmentCell.h"

@interface YKVideoDetailAppointmentCell ()
/** 预约 */
@property(nonatomic, strong) UIButton *appointmentButoon;
/** 报名 */
@property(nonatomic, strong) UIButton *applyButoon;
@end

@implementation YKVideoDetailAppointmentCell
- (instancetype)init {
    self = [super init];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _applyButoon = [UIButton new];
        [self.contentView addSubview:_applyButoon];
        [_applyButoon addTarget:self action:@selector(applyAcion) forControlEvents:UIControlEventTouchUpInside];
        [_applyButoon setBackgroundImage:[UIImage imageNamed:@"SceneButton"] forState:UIControlStateNormal];
        [_applyButoon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(30);
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(self.contentView);
        }];

        _appointmentButoon = [UIButton new];
        [self.contentView addSubview:_appointmentButoon];
        [_appointmentButoon addTarget:self action:@selector(appointmentAcion) forControlEvents:UIControlEventTouchUpInside];
        [_appointmentButoon setBackgroundImage:[UIImage imageNamed:@"DirectSeeding"] forState:UIControlStateNormal];
        [_appointmentButoon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(30);
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)applyAcion {
    [self.delegate videoDetailAppointmentCellApplyAcion];
}

- (void)appointmentAcion {
    [self.delegate videoDetailAppointmentCellAppointmentAcion];
}

@end