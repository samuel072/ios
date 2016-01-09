//
// Created by 杨虎 on 15/8/9.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKWebViewController.h"
#import "YKUserTools.h"
#import "YKLoginViewController.h"

@interface YKWebViewController () <UIWebViewDelegate>
@property(nonatomic, strong) UIWebView *mainWebView;
@end

@implementation YKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情";
    self.mainWebView = [UIWebView new];
    [self.view addSubview:self.mainWebView];
    self.mainWebView.backgroundColor = [UIColor redColor];
    self.mainWebView.opaque = YES;
    self.mainWebView.delegate = self;
    self.mainWebView.allowsInlineMediaPlayback = YES;
    self.mainWebView.mediaPlaybackRequiresUserAction = NO;
    self.mainWebView.scrollView.showsHorizontalScrollIndicator = NO;
    self.mainWebView.scrollView.bounces = NO;
    [self.mainWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    [self.mainWebView loadRequest:[NSURLRequest requestWithURL:[self.webViewUrl toUrl]]];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginSuccessAction)
                                                 name:YKLoginSuccessNotificationKey
                                               object:nil];


    [[NSNotificationCenter defaultCenter] removeObserver:self name:YKLoginSuccessNotificationKey object:nil];
}

- (void)getUserId {
    if ([YKUserTools isLogin]) {
        [self loginSuccessAction];
    } else {
        YKLoginViewController *loginViewController = [[YKLoginViewController alloc] init];
        loginViewController.pushLoginViewControllerType = PushLoginViewControllerForWebView;
        [self.navigationController pushViewController:loginViewController animated:YES];
    }
}

- (void)backViewControllerAction {
    if ([self.mainWebView canGoBack]) {
        [self.mainWebView goBack];
    } else {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:YKLoginSuccessNotificationKey object:nil];
        [super backViewControllerAction];
    }
}

/**
* 登录成功后调用JS方法告诉webview
*/
- (void)loginSuccessAction {
    // 传递参数
    [self.mainWebView stringByEvaluatingJavaScriptFromString:
            [NSString stringWithFormat:@"setClientKey('%@');", [YKUserTools getUserId]]];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *urlName = [[request URL] absoluteString];
    NSLog(@"urlName = %@", urlName);
    if ([urlName hasPrefix:@"cmscloudaudio://"]) {
        [self getUserId];
        return NO;
    }
    return YES;
}

- (void)setWebViewUrl:(NSString *)webViewUrl {
    _webViewUrl = webViewUrl;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [YKProgressHDTool hideProgressHUD];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [YKProgressHDTool showProgressHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [YKProgressHDTool hideProgressHUD];
}

@end
