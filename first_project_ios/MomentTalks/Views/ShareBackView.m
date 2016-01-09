//
//  ShareBackView.m
//  CmsTopMediaCloud
//
//  Created by bilbo on 15/8/11.
//  Copyright (c) 2015年 CmsTop. All rights reserved.
//

#import "ShareBackView.h"
#import "UIButton+Block.h"

@interface ShareBackView ()
/** 展示分享品台视图 */
@property(nonatomic, strong) UIView *bottomView;
@end

static const CGFloat kIconWidthAndHeight = 60;

/** 距离父视图左边距 */
static const CGFloat kEdgeSuperViewLeft = 10;

/** 展示视图高度 */
static const CGFloat kShowBackViewHeight = 250;

/** 底部按钮高度 */
static const CGFloat kCancelButtonHeight = 55;


static NSInteger kIconTag = 100;


@implementation ShareBackView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)showBackViewWithBlock:(shareBackBlock)blackBlock {
    ShareBackView *shareBackView = [[ShareBackView alloc] init];
    shareBackView.shareBlock = blackBlock;
    return shareBackView;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [[[UIApplication sharedApplication] keyWindow] addSubview:self];
        self.backgroundColor = [UIColor clearColor];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, YKScreenFrameH, YKScreenFrameW, YKScaleNum(200))];
        [self addSubview:_bottomView];
        _bottomView.backgroundColor = RGBCOLORA(235, 235, 235, 1);
        [UIView animateWithDuration:0.25 animations:^{
            _bottomView.frame = CGRectMake(0, YKScreenFrameH - YKScaleNum(kShowBackViewHeight), YKScreenFrameW, YKScaleNum(kShowBackViewHeight));
        }];
        UILabel *titleLabel = [UILabel new];
        [_bottomView addSubview:titleLabel];
        titleLabel.text = @"分享到";
        titleLabel.font = [UIFont systemFontOfSize:YKScaleNum(18)];
        titleLabel.textColor = [CommUtils colorWithHexString:@"#212121"];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(YKScaleNum(20));
            make.centerX.mas_equalTo(_bottomView.mas_centerX);
        }];
        NSArray *titleArray = @[@"微信朋友圈", @"微信好友", @"新浪微博", @"QQ好友"];
        NSArray *platIconArray = @[@"WXPlatFriendIcon", @"WXPlatIcon", @"SinaPlatIcon", @"QQPlatIcon"];
        CGFloat edgeBetweenIcon = (YKScreenFrameW - kEdgeSuperViewLeft * 2 - YKScaleNum(kIconWidthAndHeight) * 4) / 3;
        for (int i = 0; i < titleArray.count; i++) {
            UIImageView *iconImageView = [UIImageView new];
            [_bottomView addSubview:iconImageView];
            iconImageView.tag = kIconTag + i;
            iconImageView.image = [UIImage imageNamed:platIconArray[i]];
            iconImageView.userInteractionEnabled = YES;
            [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(titleLabel.mas_bottom).offset(YKScaleNum(25));
                make.width.and.height.mas_equalTo(YKScaleNum(kIconWidthAndHeight));
                make.left.mas_equalTo((edgeBetweenIcon + YKScaleNum(kIconWidthAndHeight)) * i + kEdgeSuperViewLeft);
            }];

            UITapGestureRecognizer *iconImageTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnIcon:)];
            [iconImageView addGestureRecognizer:iconImageTapGesture];
            UILabel *iconTitleLabel = [UILabel new];
            [_bottomView addSubview:iconTitleLabel];
            iconTitleLabel.text = titleArray[i];
            iconTitleLabel.font = [UIFont systemFontOfSize:YKScaleNum(14)];
            iconTitleLabel.textColor = [CommUtils colorWithHexString:@"#212121"];
            iconTitleLabel.textAlignment = NSTextAlignmentCenter;
            [iconTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(iconImageView.mas_bottom).offset(YKScaleNum(20));
                make.centerX.mas_equalTo(iconImageView.mas_centerX);
            }];
        }
        UIView *line = [UIView new];
        [_bottomView addSubview:line];
        line.backgroundColor = RGBCOLORA(164, 164, 164, 1);
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_bottomView.mas_bottom).offset(YKScaleNum(-YKScaleNum(kCancelButtonHeight)));
            make.height.mas_equalTo(1);
            make.width.mas_equalTo(YKScreenFrameW);
        }];
        UIButton *cancelButton = [UIButton new];
        [_bottomView addSubview:cancelButton];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[CommUtils colorWithHexString:@"#212121"] forState:UIControlStateNormal];
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:YKScaleNum(18)];
        cancelButton.backgroundColor = [UIColor clearColor];
        [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(YKScreenFrameW);
            make.height.mas_equalTo(YKScaleNum(kCancelButtonHeight));
        }];

        [cancelButton handleControlWithBlock:^{
            [self hiddenBottomView];
        }];

    }
    return self;
}


- (void)clickOnIcon:(UITapGestureRecognizer *)tapGesture {
    self.shareBlock(tapGesture.view.tag - kIconTag);
}


- (void)hiddenBottomView {
    [UIView animateWithDuration:0.25 animations:^{
        self.bottomView.frame = CGRectMake(0, YKScreenFrameH, YKScreenFrameW, YKScaleNum(200));
    }                completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self hiddenBottomView];
}

@end
