//
// Created by 杨虎 on 15/8/10.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKWillPlayVideoItemView.h"

@interface YKWillPlayVideoItemView ()
@end

@implementation YKWillPlayVideoItemView {

}
- (instancetype)init {
    self = [super init];
    if (self) {

        _reservationButton = [UIButton new];
        [self addSubview:_reservationButton];
        [_reservationButton setBackgroundImage:[UIImage imageNamed:@"ReservationButton"] forState:UIControlStateNormal];
        [_reservationButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(45);
            make.height.mas_equalTo(15);
            make.right.mas_equalTo(0);
            make.centerY.mas_equalTo(self.titleLabel.mas_centerY).offset(2);
        }];

        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-3);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(_reservationButton.mas_left).offset(-10);
            make.height.mas_equalTo(15);
        }];

        _videoTagImageView = [UIImageView new];
        [self addSubview:_videoTagImageView];
        _videoTagImageView.image = [UIImage imageNamed:@"VideoHotTagIcon"];
        [_videoTagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.with.height.mas_equalTo(30);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
        }];

    }
    return self;
}

@end