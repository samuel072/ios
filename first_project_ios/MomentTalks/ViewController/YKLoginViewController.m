//
// Created by 杨虎 on 15/7/30.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKLoginViewController.h"
#import "YKUserCenterViewController.h"

static const NSUInteger kPlatStartTag = 988;

@interface YKLoginViewController ()
@property(nonatomic, strong) UITextField *passwordTextField;
@property(nonatomic, strong) UIImageView *passwordIconImageView;
@property(nonatomic, strong) UITextField *accountTextField;
@property(nonatomic, strong) UIImageView *accountIconImageView;
@property(nonatomic, strong) UIButton *registeredButton;
@property(nonatomic, strong) UIButton *findButton;
@property(nonatomic, strong) YKTransparentButton *loginButton;
@end

@implementation YKLoginViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginWithTheWXCode:)//接收消息方法
                                                 name:ThirdLoginSuccess//消息识别名称
                                               object:nil];
    self.title = @"登录";
    _accountIconImageView = [UIImageView new];
    [self.view addSubview:_accountIconImageView];
    _accountIconImageView.image = [UIImage imageNamed:@"AccountIcon"];
    [_accountIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(80);
        make.left.mas_equalTo(20);
    }];

    _accountTextField = [UITextField new];
    [self.view addSubview:_accountTextField];
    _accountTextField.attributedPlaceholder = [[NSAttributedString alloc]
            initWithString:@"输入手机号/邮箱" attributes:@{NSForegroundColorAttributeName : [UIColor grayColor],
                    NSFontAttributeName : [UIFont boldSystemFontOfSize:15]}];
    _accountTextField.textColor = [UIColor grayColor];
    [_accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_accountIconImageView);
        make.left.mas_equalTo(_accountIconImageView.mas_right).offset(10);
        make.right.mas_equalTo(-20);
    }];

    UIView *lineView = [UIView new];
    [self.view addSubview:lineView];
    lineView.backgroundColor = [UIColor whiteColor];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_accountIconImageView.mas_bottom).offset(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(1);
    }];

    _passwordIconImageView = [UIImageView new];
    [self.view addSubview:_passwordIconImageView];
    _passwordIconImageView.image = [UIImage imageNamed:@"PasswordIcon"];
    [_passwordIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(lineView.mas_bottom).offset(30);
        make.left.mas_equalTo(20);
    }];

    _passwordTextField = [UITextField new];
    [self.view addSubview:_passwordTextField];
    _passwordTextField.attributedPlaceholder = [[NSAttributedString alloc]
            initWithString:@"输入6-16位字母数字密码"
                attributes:@{NSForegroundColorAttributeName : [UIColor grayColor],
                        NSFontAttributeName : [UIFont boldSystemFontOfSize:15]}];
    _passwordTextField.textColor = [UIColor grayColor];
//输入密码的时候，密码变成小黑点
    _passwordTextField.secureTextEntry = YES;
    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_passwordIconImageView);
        make.left.mas_equalTo(_passwordIconImageView.mas_right).offset(10);
        make.right.mas_equalTo(-20);
    }];

    UIView *lineView1 = [UIView new];
    [self.view addSubview:lineView1];
    lineView1.backgroundColor = [UIColor whiteColor];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_passwordTextField.mas_bottom).offset(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(1);
    }];

    _registeredButton = [UIButton new];
    [self.view addSubview:_registeredButton];
    [_registeredButton handleControlWithBlock:^{
        [self registeredAction];
    }];
    _registeredButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_registeredButton setTitle:@"注册" forState:UIControlStateNormal];
    [_registeredButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_registeredButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView1.mas_bottom).offset(15);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(20);
        make.left.mas_equalTo(20);
    }];

    _findButton = [UIButton new];
    [self.view addSubview:_findButton];
    [_findButton handleControlWithBlock:^{
        [self findPasswordAction];
    }];
    _findButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_findButton setTitle:@"找回密码" forState:UIControlStateNormal];
    [_findButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_findButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.centerY.mas_equalTo(_registeredButton);
    }];

    _loginButton = [YKTransparentButton new];
    [self.view addSubview:_loginButton];
    [_loginButton handleControlWithBlock:^{
        [self loginAction];
    }];
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(_findButton.mas_bottom).offset(50);
    }];

//    [self createLoginPlat];
}

/*
 * 创建底部第三方登录平台布局
 */
- (void)createLoginPlat {
    NSArray *platNameArray = @[@"QQ登录", @"微信登录", @"新浪登录"];
    NSArray *platIconArray = @[@"QQPlatIcon", @"WXPlatIcon", @"SinaPlatIcon"];
    UIView *platMenuView = [UIView new];
    [self.view addSubview:platMenuView];
    [platMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(150);
    }];

    UIView *lastPlatItemView = nil;
    for (int i = 0; i < platIconArray.count; ++i) {
        UIView *platItemView = [UIView new];
        [platMenuView addSubview:platItemView];
        platItemView.tag = kPlatStartTag + i;

        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                               action:@selector(platLoginAction:)];
        platItemView.userInteractionEnabled = YES;
        [platItemView addGestureRecognizer:tapGestureRecognizer];
        [platItemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(platMenuView);
            make.width.mas_equalTo(YKScreenFrameW / platIconArray.count);
            make.top.mas_equalTo(0);
            if (lastPlatItemView) {
                make.left.mas_equalTo(lastPlatItemView.mas_right);
            } else {
                make.left.mas_equalTo(0);
            }
        }];

        UIImageView *platIconImageView = [UIImageView new];
        [platItemView addSubview:platIconImageView];
        platIconImageView.image = [UIImage imageNamed:platIconArray[i]];
        [platIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.with.height.mas_equalTo(45);
            make.top.mas_equalTo(20);
            make.centerX.mas_equalTo(platItemView);
        }];

        UILabel *platNameLabel = [UILabel new];
        [platItemView addSubview:platNameLabel];
        platNameLabel.text = platNameArray[i];
        platNameLabel.textAlignment = NSTextAlignmentCenter;
        platNameLabel.textColor = [UIColor whiteColor];
        platNameLabel.font = [UIFont systemFontOfSize:15];
        [platNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(platItemView);
            make.width.mas_equalTo(100);
            make.top.mas_equalTo(platIconImageView.mas_bottom).offset(15);
        }];

        lastPlatItemView = platItemView;
    }

    UILabel *infoLabel = [UILabel new];
    [self.view addSubview:infoLabel];
    infoLabel.text = @"第三方平台登录";
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.textColor = [UIColor whiteColor];
    infoLabel.font = [UIFont systemFontOfSize:15];
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(30);
        make.bottom.mas_equalTo(platMenuView.mas_top);
    }];

}


#pragma mark Action

- (void)loginAction {
    NSLog(@"登录");
    if (self.accountTextField.text.length == 0) {
        [YKProgressHDTool reminderWithTitle:@"输入账号"];
        return;
    }

    if (self.passwordTextField.text.length == 0) {
        [YKProgressHDTool reminderWithTitle:@"输入密码"];
        return;
    }

    [YKApiRequestServer userLoginWithAccount:self.accountTextField.text
                                    password:self.passwordTextField.text
                                     success:^(YKUserModel *userModel) {
                                         [[NSNotificationCenter defaultCenter] postNotificationName:YKLoginSuccessNotificationKey object:nil];
                                         switch (self.pushLoginViewControllerType) {
                                             case PushLoginViewControllerForTabar: {
                                                 YKUserCenterViewController *userCenterViewController = [[YKUserCenterViewController alloc] init];
                                                 [self.navigationController pushViewController:userCenterViewController animated:YES];
                                             }
                                                 break;
                                             case PushLoginViewControllerForWebView:
                                             case PushLoginViewControllerForProjectDetail: {
                                                 [super backViewControllerAction];
                                             }
                                                 break;
                                         }
                                     }
                                     failure:^(NSString *error) {
                                         [YKProgressHDTool reminderWithTitle:error];
                                     }];
}

/**
* 找回密码
*/
- (void)findPasswordAction {
    NSLog(@"找回密码");
    YKResignViewController *resignViewController = [[YKResignViewController alloc] init];
    resignViewController.viewControllerType = PushViewControllerForForgetPassword;
    [self.navigationController pushViewController:resignViewController animated:YES];
}

/**
* 注册
*/
- (void)registeredAction {
    NSLog(@"注册");
    YKResignViewController *resignViewController = [[YKResignViewController alloc] init];
    resignViewController.viewControllerType = PushViewControllerForResign;
    [self.navigationController pushViewController:resignViewController animated:YES];
}

/**
* 第三方登录
*/
- (void)platLoginAction:(UITapGestureRecognizer *)tapGestureRecognizer {
    switch (tapGestureRecognizer.view.tag - kPlatStartTag) {
        case 0:
            NSLog(@"QQ登录");
            [YKShareNewsTool theThirdLoad:ShareTypeQQ :^(YKThirdLoadUserModel *entity) {
                NSLog(@"%@", entity);
            }];
            break;
        case 1: {
            if (![WXApi isWXAppInstalled]) {
                [YKProgressHDTool reminderWithTitle:@"未安装微信!"];
                return;
            }
            SendAuthReq *req = [[SendAuthReq alloc] init];
            req.scope = @"snsapi_userinfo";
            req.state = @"123";
            //第三方向微信终端发送一个SendAuthReq消息结构
            [WXApi sendReq:req];
        }
            NSLog(@"微信登录");
            break;
        case 2:
            NSLog(@"新浪登录");
            [YKShareNewsTool theThirdLoad:ShareTypeSinaWeibo :^(YKThirdLoadUserModel *entity) {
                NSLog(@"%@", entity);
            }];
            break;
    }
}

- (void)loginWithTheWXCode:(NSNotification *)notification {
    NSDictionary *userInfo = notification.object;
    YKThirdLoadUserModel *entity = [[YKThirdLoadUserModel alloc] initWithUid:userInfo[@"unionid"] nickname:userInfo[@"nickname"] profileImage:userInfo[@"headimgurl"] homeUrl:nil gender:nil andLoaction:nil];
    NSLog(@"%@", entity);
}
@end