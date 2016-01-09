//
// Created by 杨虎 on 15/8/9.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKWillPlayVideoCell.h"
#import "YKVideoItemView.h"
#import "YKTableSectionHeadView.h"
#import "YKMoreVideoCell.h"
#import "YKWillPlayVideoItemView.h"

const static int MENU_ITEM_START_TAG = 201;     // tag起始值
const static int MENU_BUTTON_START_TAG = 1201;     // tag起始值


@interface YKWillPlayVideoCell ()
@property(nonatomic, strong) YKTableSectionHeadView *headView;
@end

@implementation YKWillPlayVideoCell
- (instancetype)init {
    self = [super init];
    if (self) {

    }

    return self;
}

- (void)createView {
    _headView = [YKTableSectionHeadView new];
    [self.contentView addSubview:_headView];
    _headView.backgroundColor = [UIColor clearColor];
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0).priority(999);
        make.right.mas_equalTo(0).priority(999);
        make.height.mas_equalTo(YKMoreVideoCellSectionHeadHeight);
        make.top.mas_equalTo(0);
    }];
    [self createMenuView:self.contentView topView:_headView];
}

- (void)setVideoDataArray:(NSMutableArray <YKHomeVideoListDataDataModel> *)videoDataArray {
    _videoDataArray = videoDataArray;
    [self createView];
    YKHomeVideoListDataDataModel *homeVideoListDataDataModel = videoDataArray[0];
    self.headView.title = homeVideoListDataDataModel.sectionHeadTitle;
}

- (void)createMenuView:(UIView *)container topView:(UIView *)topView {
    YKWillPlayVideoItemView *lastMenuItemView = nil;
    for (int a = 0; a < self.videoDataArray.count; a++) {
        YKHomeVideoListDataDataModel *model = self.videoDataArray[a];
        YKWillPlayVideoItemView *menuItemView = [YKWillPlayVideoItemView new];
        [container addSubview:menuItemView];
        [menuItemView.reservationButton addTarget:self action:@selector(reservationAction:) forControlEvents:UIControlEventTouchUpInside];
        menuItemView.reservationButton.tag = MENU_BUTTON_START_TAG + a;

        menuItemView.homeVideoListDataDataModel = model;
        menuItemView.thumbImageView.tag = MENU_ITEM_START_TAG + a;
        menuItemView.videoTagImageView.hidden = ![model.category isEqualToString:@"2"];

        // 添加点击事件
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                initWithTarget:self
                        action:@selector(menuClickAction:)];
        [menuItemView.thumbImageView addGestureRecognizer:tapGestureRecognizer];
        menuItemView.thumbImageView.userInteractionEnabled = YES;

        [menuItemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(WillPlayVideoCellHeight);
            if (lastMenuItemView) {
                make.top.mas_equalTo(lastMenuItemView.mas_bottom).offset(YKMoreVideoCellMenuViewMargin);
            } else {
                make.top.mas_equalTo(topView.mas_bottom).offset(YKMoreVideoCellMenuViewMargin);
            }
            if (a == self.videoDataArray.count - 1) {
                make.bottom.mas_equalTo(-YKMoreVideoCellMenuViewMargin);
            }
        }];
        lastMenuItemView = menuItemView;
    }
}

- (void)reservationAction:(UIButton *)button {
    int index = button.tag - MENU_BUTTON_START_TAG;
    YKHomeVideoListDataDataModel *model = self.videoDataArray[index];
    [self.delegate reservationActionWithModel:model];
}

- (void)menuClickAction:(UITapGestureRecognizer *)tapGestureRecognizer {
    int index = tapGestureRecognizer.view.tag - MENU_ITEM_START_TAG;
    YKHomeVideoListDataDataModel *model = self.videoDataArray[index];
    [self.delegate willPlayVideoCellCheckActionWithModel:model];
}
@end