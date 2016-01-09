//
// Created by 杨虎 on 15/7/30.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKBaseTabbarViewController.h"
#import "YKSearchViewController.h"
#import "YKUserCenterViewController.h"
#import "YKUserTools.h"
#import "YKLoginViewController.h"

@implementation YKBaseTabbarViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.hiddenBackButton = YES;
    [self.customNavigation creatRightNavButtonWithImageName:@"UserIcon" block:^{
        if ([YKUserTools isLogin]) {
            YKUserCenterViewController *userCenterViewController = [[YKUserCenterViewController alloc] init];
            userCenterViewController.pushUserCenterViewControllerType = PushLoginViewControllerForRoot;
            [self.navigationController pushViewController:userCenterViewController animated:YES];
        } else {
            YKLoginViewController *loginViewController = [[YKLoginViewController alloc] init];
            [self.navigationController pushViewController:loginViewController animated:YES];
        }
    }];
    [self.customNavigation creatSecondRightNavButtonWithImageName:@"SearchIcon" block:^{
        YKSearchViewController *searchViewController = [[YKSearchViewController alloc] init];
        [self.navigationController pushViewController:searchViewController animated:YES];
    }];
}

@end