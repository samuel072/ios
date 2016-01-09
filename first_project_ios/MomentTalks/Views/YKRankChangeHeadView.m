//
// Created by 杨虎 on 15/7/29.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKRankChangeHeadView.h"
#import "YKRankChangeHeadItemView.h"


#define kRankItemViewwidth YKScreenFrameW / 2

const NSUInteger kDayRankItemViewTag = 1111;
const NSUInteger kMonthRankItemViewTag = 1112;
const CGFloat kSlideLineViewMargin = 10; // 滑动条左右边距

@interface YKRankChangeHeadView ()
@property(nonatomic, strong) YKRankChangeHeadItemView *dayRankItemView;
@property(nonatomic, strong) YKRankChangeHeadItemView *monthRankItemView;
@property(nonatomic, strong) UIView *slideLineView;
@end

@implementation YKRankChangeHeadView
- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];

        UITapGestureRecognizer *dayRankItemViewClick = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                               action:@selector(rankItemViewClickAction:)];

        _dayRankItemView = [YKRankChangeHeadItemView new];
        [self addSubview:_dayRankItemView];
        _dayRankItemView.tag = kDayRankItemViewTag;
        _dayRankItemView.userInteractionEnabled = YES;
        [_dayRankItemView addGestureRecognizer:dayRankItemViewClick];
        _dayRankItemView.title = @"今日排行";
        _dayRankItemView.select = YES;
        [_dayRankItemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kRankItemViewwidth);
            make.height.mas_equalTo(self);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
        }];

        UITapGestureRecognizer *monthRankItemViewClick = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                                 action:@selector(rankItemViewClickAction:)];
        _monthRankItemView = [YKRankChangeHeadItemView new];
        [self addSubview:_monthRankItemView];
        _monthRankItemView.tag = kMonthRankItemViewTag;
        _monthRankItemView.userInteractionEnabled = YES;
        [_monthRankItemView addGestureRecognizer:monthRankItemViewClick];
        _monthRankItemView.title = @"本月排行";
        _monthRankItemView.select = NO;
        [_monthRankItemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kRankItemViewwidth);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(self);
            make.left.mas_equalTo(_dayRankItemView.mas_right);
        }];

        _slideLineView = [UIView new];
        [self addSubview:_slideLineView];
        _slideLineView.backgroundColor = YKThemeColor;
        [self slideLineViewWithRankChangeHeadItemView:self.dayRankItemView animate:NO];
    }
    return self;
}

- (void)slideLineViewWithRankChangeHeadItemView:(YKRankChangeHeadItemView *)rankChangeHeadItemView
                                        animate:(BOOL)animate {
    [self.slideLineView setNeedsUpdateConstraints];
    if (animate) {
        [UIView animateWithDuration:0.3 animations:^{
            [_slideLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(3);
                make.bottom.mas_equalTo(0);
                make.width.mas_equalTo(kRankItemViewwidth - kSlideLineViewMargin * 2);
                make.left.mas_equalTo(rankChangeHeadItemView.mas_left).offset(kSlideLineViewMargin);
            }];
            [self.slideLineView layoutIfNeeded];
        }];
    } else {
        [_slideLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(3);
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(kRankItemViewwidth - kSlideLineViewMargin * 2);
            make.left.mas_equalTo(rankChangeHeadItemView.mas_left).offset(kSlideLineViewMargin);
        }];
    }
}

/**
* 点击事件
*/
- (void)rankItemViewClickAction:(UIGestureRecognizer *)gestureRecognizer {
    switch (gestureRecognizer.view.tag) {
        case kDayRankItemViewTag:
            self.monthRankItemView.select = NO;
            self.dayRankItemView.select = YES;
            [self.delegate dayRankItemViewClickAcion];
            [self slideLineViewWithRankChangeHeadItemView:self.dayRankItemView animate:YES];
            break;
        case kMonthRankItemViewTag:
            self.monthRankItemView.select = YES;
            self.dayRankItemView.select = NO;
            [self.delegate monthRankItemViewClickAcion];
            [self slideLineViewWithRankChangeHeadItemView:self.monthRankItemView animate:YES];
            break;
    }
}
@end