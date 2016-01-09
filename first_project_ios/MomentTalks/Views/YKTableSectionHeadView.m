//
// Created by 杨虎 on 15/7/30.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKTableSectionHeadView.h"

@interface YKTableSectionHeadView ()
@property(nonatomic, strong) UIImageView *tagImageView;
@property(nonatomic, strong) UILabel *titleLabel;
@end

@implementation YKTableSectionHeadView
- (instancetype)init {
    self = [super init];
    if (self) {
        _tagImageView = [UIImageView new];
        [self addSubview:_tagImageView];
        _tagImageView.image = [UIImage imageNamed:@"SectionTagIcon"];
        [_tagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(5);
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(self);
        }];

        _titleLabel = [UILabel new];
        [self addSubview:_titleLabel];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(_tagImageView.mas_right).offset(5);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(20);
        }];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

@end