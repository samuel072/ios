//
// Created by 杨虎 on 15/7/30.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIButton+Block.h"

#define kLeftButtonTag 2222//左侧按钮tag


@interface YKCustomNavigation : UIView
@property(nonatomic, nonatomic) NSString *title;

- (void)creatLeftBackNavButtonWithWithImageName:(NSString *)iamgeName block:(ActionBlock)block;

/**
*  设置导航栏左侧按钮
*
*  @param btn 按钮
*/
- (void)creatLeftButton:(UIButton *)btn;

/**
*  移除左侧按钮
*/
- (void)removeLeftButton;

- (void)creatRightNavButtonWithImageName:(NSString *)iamgeName block:(ActionBlock)block;

- (void)creatSecondRightNavButtonWithImageName:(NSString *)iamgeName block:(ActionBlock)block;

/**
*  设置导航栏右侧按钮
*
*  @param btn 按钮
*/
- (void)creatRightButton:(UIButton *)btn;

/**
*  设置导航栏右侧按钮
*
*  @param btn 按钮
*/
- (void)creatRightButtonsWithButtonImageNameArray:(NSArray *)buttonImageNameArray;

- (UIButton *)creatRightButtonWithTitle:(NSString *)title block:(ActionBlock)block;

@end