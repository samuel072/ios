//
// Created by 杨虎 on 15/8/8.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKUserInfoCell.h"

@interface YKUserInfoCell ()
@property(nonatomic, strong) UILabel *infoLable;
@end

@implementation YKUserInfoCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _infoLable = [UILabel new];
        [self.contentView addSubview:_infoLable];
        _infoLable.font = [UIFont systemFontOfSize:14];
        _infoLable.textColor = [UIColor grayColor];
        [_infoLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.arrowIconImageView.mas_left).offset(-5);
            make.height.mas_equalTo(20);
        }];

        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_infoLable.mas_left).offset(-15);
            make.left.mas_equalTo(15).priority(999);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setInfo:(NSString *)info {
    self.infoLable.text = info;
}
@end