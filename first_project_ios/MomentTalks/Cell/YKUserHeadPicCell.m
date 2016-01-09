//
// Created by 杨虎 on 15/8/8.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKUserHeadPicCell.h"
#import "UIImageView+WebCache.h"

@interface YKUserHeadPicCell ()
@property(nonatomic, strong) UIImageView *headPicImageView;
@end

@implementation YKUserHeadPicCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _headPicImageView = [UIImageView new];
        [self.contentView addSubview:_headPicImageView];
        _headPicImageView.layer.masksToBounds = YES;
        _headPicImageView.layer.cornerRadius = 40/2;
        [_headPicImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.arrowIconImageView.mas_left).offset(-5);
            make.width.with.height.mas_equalTo(40);
        }];

        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_headPicImageView.mas_left).offset(-15);
            make.left.mas_equalTo(15).priority(999);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setHeadPicUrl:(NSString *)headPicUrl {
    [self.headPicImageView sd_setImageWithURL:[headPicUrl toUrl]];
}
@end