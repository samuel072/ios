//
// Created by 杨虎 on 15/8/8.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKUserCenterCell.h"

@interface YKUserCenterCell ()

@end

@implementation YKUserCenterCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        _arrowIconImageView = [UIImageView new];
        [self.contentView addSubview:_arrowIconImageView];
        _arrowIconImageView.image = [UIImage imageNamed:@"ArrowIcon"];
        [_arrowIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.width.with.height.mas_equalTo(20);
            make.right.mas_equalTo(-10);
        }];

        
        _typeIconImageView = [UIImageView new];
        [self.contentView addSubview:_typeIconImageView];
        [_typeIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.with.height.mas_equalTo(25);
            make.centerY.mas_equalTo(self.contentView).priority(999);
            make.left.mas_equalTo(10);
        }];
        
        _titleLabel = [UILabel new];
        [self.contentView addSubview:_titleLabel];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_typeIconImageView.mas_right).offset(10);
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(_arrowIconImageView.mas_left).offset(-10);
        }];


    }
    return self;
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}
@end