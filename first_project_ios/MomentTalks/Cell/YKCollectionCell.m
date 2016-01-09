//
// Created by 杨虎 on 15/8/8.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKCollectionCell.h"
#import "YKCollectionListData.h"
#import "YKReservationListData.h"

@interface YKCollectionCell ()
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIButton *deleteButton;
@end

@implementation YKCollectionCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        _deleteButton = [UIButton new];
        [self.contentView addSubview:_deleteButton];
        _deleteButton.hidden = YES;
        [_deleteButton addTarget:self action:@selector(delectAcion) forControlEvents:UIControlEventTouchUpInside];
        [_deleteButton setBackgroundImage:[UIImage imageNamed:@"UnSelectedIcon"] forState:UIControlStateNormal];
        [_deleteButton setBackgroundImage:[UIImage imageNamed:@"SelectedIcon"] forState:UIControlStateSelected];
        [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.left.mas_equalTo(15);
            make.width.with.height.mas_equalTo(20);
        }];

        _titleLabel = [UILabel new];
        [self.contentView addSubview:_titleLabel];
        _titleLabel.numberOfLines = 1;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
        }];


    }
    return self;
}

- (void)setSelect:(BOOL)select {
    self.deleteButton.selected = select;
}

- (void)delectAcion {
    self.deleteButton.selected = !self.deleteButton.selected;
    if (self.delegate) {
        [self.delegate cleckCollectionCellWithSelect:self.deleteButton.selected
                                     collectListData:self.collectListData];
    }
    if (self.reservationDelegate) {

        [self.reservationDelegate cleckReservationCellWithSelect:self.deleteButton.selected
                                             reservationListData:self.reservationListData];
    }
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)setEditor:(BOOL)editor {
    if (editor) {
        _deleteButton.hidden = NO;
        [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_deleteButton.mas_right).offset(10);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
        }];
    } else {
        _deleteButton.hidden = YES;
        [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
        }];
    }
}

- (void)setReservationListData:(YKReservationListData *)reservationListData {
    _reservationListData = reservationListData;
    NSLog(@"reservationListData = %@", reservationListData);
    self.titleLabel.text = reservationListData.albumName;
}

- (void)setCollectListData:(YKCollectionListData *)collectListData {
    self.titleLabel.text = collectListData.videoName;
    _collectListData = collectListData;
}
@end