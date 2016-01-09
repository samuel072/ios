//
// Created by 杨虎 on 15/7/30.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKCustomNavigation.h"

#define kItemSize 28 //导航栏按钮固定宽高
#define DynamicRightButtonTag 555//右侧动态宽度按钮
#define stringButtonWidth  CTScaleNum(50)//文字按钮宽度

const NSUInteger CTCustomNavigationRightButtonTag = 111;
const NSUInteger CTCustomNavigationSecondRightButtonTag = 112;
const CGFloat CTCustomNavigationItemEdgueLeft = 5;

@implementation YKCustomNavigation
- (instancetype)init {
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
    }

    return self;
}

- (void)removeLeftButton {
    [self removeViewWithTag:kLeftButtonTag];
}

- (void)creatRightNavButtonWithImageName:(NSString *)iamgeName block:(ActionBlock)block {
    [self creatRightButton:[self creatNavButtonWithImageName:iamgeName block:block]];
}

- (void)creatSecondRightNavButtonWithImageName:(NSString *)iamgeName block:(ActionBlock)block {
    [self creatSecondRightButton:[self creatNavButtonWithImageName:iamgeName block:block]];
}

- (void)creatSecondRightButton:(UIButton *)btn {
    btn.tag = CTCustomNavigationSecondRightButtonTag;
    [self removeViewWithTag:btn.tag];
    [self addSubview:btn];
    UIView *fristButton = [self viewWithTag:CTCustomNavigationRightButtonTag];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(fristButton.mas_left).offset(-10);
        if (iOS7) {
            make.top.mas_equalTo((44 - kItemSize) / 2 + 20);
        } else {
            make.top.mas_equalTo((44 - kItemSize) / 2);
        }
        make.height.and.width.mas_equalTo(kItemSize);
    }];
}

- (void)creatRightButton:(UIButton *)btn {
    btn.tag = CTCustomNavigationRightButtonTag;
    [self removeViewWithTag:btn.tag];
    [self addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-CTCustomNavigationItemEdgueLeft);
        if (iOS7) {
            make.top.mas_equalTo((44 - kItemSize) / 2 + 20);
        } else {
            make.top.mas_equalTo((44 - kItemSize) / 2);
        }
        make.height.and.width.mas_equalTo(kItemSize);
    }];
}


- (void)creatRightButtonsWithButtonImageNameArray:(NSArray *)buttonImageNameArray {

}

- (UIButton *)creatRightButtonWithTitle:(NSString *)title block:(ActionBlock)block {
    UIButton *rightButton = [UIButton new];
    [self creatRightButton:rightButton];
    rightButton.layer.masksToBounds = YES;
    rightButton.layer.cornerRadius = 5;
    rightButton.layer.borderWidth = 1;
    rightButton.layer.borderColor = RGBCOLORA(255, 255, 255, 0.7).CGColor;
    [rightButton setTitle:title forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [rightButton handleControlWithBlock:block];
    [rightButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(25);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(20 + ((44 - 25) / 2));
    }];
    return rightButton;
}


- (UIButton *)creatNavButtonWithImageName:(NSString *)iamgeName block:(ActionBlock)block {
    UIButton *button = [UIButton new];
    [button handleControlWithBlock:block];
    [button setBackgroundImage:[UIImage imageNamed:iamgeName] forState:UIControlStateNormal];
    return button;
}

- (void)creatLeftBackNavButtonWithWithImageName:(NSString *)iamgeName block:(ActionBlock)block {
    [self creatLeftButton:[self creatNavButtonWithImageName:iamgeName block:block]];
}

- (void)creatLeftButton:(UIButton *)btn {
    btn.tag = kLeftButtonTag;
//    btn.backgroundColor = [UIColor redColor];
    [self removeViewWithTag:btn.tag];
    [self addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(CTCustomNavigationItemEdgueLeft);
        if (iOS7) {
            make.top.mas_equalTo((44 - kItemSize) / 2 + 20);
        } else {
            make.top.mas_equalTo((44 - kItemSize) / 2);
        }
        make.height.and.width.mas_equalTo(kItemSize);
    }];
}

- (void)setTitle:(NSString *)title {
    [self removeViewWithTag:3333];

    UILabel *titleLabel = [UILabel new];
    titleLabel.tag = 3333;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = title;
    titleLabel.font = [UIFont boldSystemFontOfSize:YKScaleNum(18)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.numberOfLines = 1;
    [self addSubview:titleLabel];

    [titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(iOS7 ? 20 : 0);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(YKScreenFrameW - 50 * 2);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
}
@end