//
// Created by 杨虎 on 15/7/29.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKCustomNavigation.h"
#import "YKApiRequestServer.h"
#import "YKApiRequestServer.h"

@interface YKBaseViewController : UIViewController
@property(nonatomic, strong) YKCustomNavigation *customNavigation;
/** 隐藏返回按钮 */
@property(nonatomic, assign) BOOL hiddenBackButton;

- (void)popViewControllerWithClass:(Class)view;

/**
* 点击返回按钮
*/
- (void)backViewControllerAction;

- (void)pushWebViewControllerWithURL:(NSString *)url;
@end