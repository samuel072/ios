//
// Created by 杨虎 on 15/8/7.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKSearchCell.h"

@interface YKSearchCell ()
@property(nonatomic, strong) UILabel *titleLabel;
@end

@implementation YKSearchCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _titleLabel = [UILabel new];
        [self.contentView addSubview:_titleLabel];
        _titleLabel.numberOfLines = 1;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(30);
            make.top.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
        }];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}
@end