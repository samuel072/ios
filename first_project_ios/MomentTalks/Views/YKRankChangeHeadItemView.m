//
// Created by 杨虎 on 15/7/29.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKRankChangeHeadItemView.h"


@interface YKRankChangeHeadItemView ()
@property(nonatomic, strong) UILabel *titleLabel;
@end

@implementation YKRankChangeHeadItemView
- (instancetype)init {
    if (self = [super init]) {
        _titleLabel = [UILabel new];
        [self addSubview:_titleLabel];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)setSelect:(BOOL)select {
    if (select) {
        self.titleLabel.textColor = YKThemeColor;
        _titleLabel.font = [UIFont systemFontOfSize:19];
    } else {
        self.titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
}
@end