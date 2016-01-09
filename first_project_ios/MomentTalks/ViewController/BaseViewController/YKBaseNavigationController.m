//
// Created by 杨虎 on 15/7/31.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKBaseNavigationController.h"
#import "YKBaseTabbarViewController.h"

@implementation YKBaseNavigationController {

}

#pragma mark - View rotation


- (BOOL)shouldAutorotate {
    return YES;
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated {
    [self popViewController];
    return [super popToRootViewControllerAnimated:animated];
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self popViewController];
    return [super popToViewController:viewController animated:animated];

}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    [self popViewController];
    return [super popViewControllerAnimated:animated];
}

- (void)popViewController {
    NSArray *viewControllers = self.viewControllers;
    if (viewControllers.count > 1) {
        UIViewController *popViewController = viewControllers[viewControllers.count - 2];
        if ([popViewController isKindOfClass:[YKBaseTabbarViewController class]]) {
            [YKSharedAppDelegate.tabBarController setTabBarHidden:NO animated:NO];
        }
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (![viewController isKindOfClass:[YKBaseTabbarViewController class]]) {
        [YKSharedAppDelegate.tabBarController setTabBarHidden:YES animated:YES];
    }
    [super pushViewController:viewController animated:animated];
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationPortrait == interfaceOrientation;
}

@end