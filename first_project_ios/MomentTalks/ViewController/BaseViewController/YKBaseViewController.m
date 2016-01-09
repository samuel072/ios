//
// Created by 杨虎 on 15/7/29.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKBaseViewController.h"
#import "YKWebViewController.h"

@interface YKBaseViewController ()
@end

@implementation YKBaseViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = RGBCOLORA(239, 239, 239, 1);
    _customNavigation = [YKCustomNavigation new];
    [self.view addSubview:_customNavigation];
    _customNavigation.backgroundColor = YKThemeColor;
    [_customNavigation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.with.right.mas_equalTo(0);
        make.height.mas_equalTo(64);
        make.top.mas_equalTo(0);
    }];

    [_customNavigation creatLeftBackNavButtonWithWithImageName:@"BackIcon" block:^{
        [self backViewControllerAction];
    }];
}

- (void)popViewControllerWithClass:(Class)view {
    NSArray *viewControllers = self.navigationController.viewControllers;
    for (UIViewController *viewController in viewControllers) {
        if ([viewController isKindOfClass:view]) {
            [self.navigationController popToViewController:viewController animated:YES];
        }
    }
}

- (void)backViewControllerAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setHiddenBackButton:(BOOL)hiddenBackButton {
    if (hiddenBackButton) {
        [self.customNavigation removeLeftButton];
    }
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    self.customNavigation.title = title;
}

- (void)pushWebViewControllerWithURL:(NSString *)url {
    NSLog(@"需要跳转的url = %@", url);
    YKWebViewController *webViewController = [[YKWebViewController alloc] init];
    webViewController.webViewUrl = url;
    [self.navigationController pushViewController:webViewController animated:YES];
}
@end