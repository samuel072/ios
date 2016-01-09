//
//  YKResignViewController.m
//  MomentTalks
//
//  Created by bilbo on 15/8/2.
//  Copyright (c) 2015年 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKResignViewController.h"
#import "YKResetPassWordViewController.h"

@interface YKResignViewController ()

/** 手机号输入 */
@property(nonatomic, strong) YKTextFieldView *phoneNumberTextFieldView;

/** 验证码输入 */
@property(nonatomic, strong) YKTextFieldView *codeNumberTextFieldView;

/** 验证码按钮 */
@property(nonatomic, strong) YKTransparentButton *codeButton;

/** 下一步按钮 */
@property(nonatomic, strong) YKTransparentButton *nextStepButton;

/** 计时器 */
@property(nonatomic, strong) NSTimer *timer;

/** 倒计时 */
@property(nonatomic, assign) NSInteger countDownTime;

/** 验证码 */
@property(nonatomic, copy) NSString *code;
@end


static const NSInteger kCountDownTime = 60;

@implementation YKResignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(toRefreshCodeButtonTitle) userInfo:nil repeats:YES];
    [self.timer setFireDate:[NSDate distantFuture]];
    self.title = self.viewControllerType == PushViewControllerForResign ? @"注册" : @"忘记密码";
    self.countDownTime = kCountDownTime;
    [self drawSubViews];
    // Do any additional setup after loading the view.
}

/**
*  布局
*/
- (void)drawSubViews {
    self.codeButton = [YKTransparentButton new];
    [self.view addSubview:self.codeButton];
    self.codeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.codeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    [self.codeButton addTarget:self action:@selector(sendMobileCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(100);
        make.top.mas_equalTo(90);
    }];

    self.phoneNumberTextFieldView = [YKTextFieldView new];
    [self.view addSubview:self.phoneNumberTextFieldView];
    self.phoneNumberTextFieldView.placeHolder = @"请输入手机号码";
    [self.phoneNumberTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(self.codeButton.mas_top);
        make.height.mas_equalTo(40);
        make.right.mas_equalTo(self.codeButton.mas_left).offset(-10);
    }];

    self.codeNumberTextFieldView = [YKTextFieldView new];
    [self.view addSubview:self.codeNumberTextFieldView];
    self.codeNumberTextFieldView.placeHolder = @"请输入验证码";
    [self.codeNumberTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.phoneNumberTextFieldView.mas_left);
        make.height.mas_equalTo(self.phoneNumberTextFieldView.mas_height);
        make.right.mas_equalTo(self.codeButton.mas_right);
        make.top.mas_equalTo(self.phoneNumberTextFieldView.mas_bottom).offset(20);
    }];

    self.nextStepButton = [YKTransparentButton new];
    [self.view addSubview:self.nextStepButton];
    [self.nextStepButton setTitle:@"下一步" forState:UIControlStateNormal];
    [self.nextStepButton addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
    [self.nextStepButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.codeNumberTextFieldView.mas_left);
        make.right.mas_equalTo(self.codeNumberTextFieldView.mas_right);
        make.height.mas_equalTo(self.codeNumberTextFieldView.mas_height);
        make.top.mas_equalTo(self.codeNumberTextFieldView.mas_bottom).offset(20);
    }];


}

#pragma mark -ActionMethod

/**
*  获取验证码
*
*  @param button
*/
- (void)sendMobileCode:(UIButton *)button {
    if ([CommUtils isNull:self.phoneNumberTextFieldView.textfield.text]) {
        [YKProgressHDTool reminderWithTitle:@"手机号不能为空！"];
        return;
    }
    [YKApiRequestServer requestMobileCodeWithPhoneNumble:self.phoneNumberTextFieldView.textfield.text
                                                 success:^(NSString *code) {
                                                     self.code = code;
                                                     self.codeNumberTextFieldView.textfield.text = code;
                                                     NSLog(@"code = %@", code);
                                                     button.userInteractionEnabled = NO;
                                                     [self.timer setFireDate:[NSDate distantPast]];
                                                 }
                                                 failure:^(NSString *error) {
                                                     [YKProgressHDTool reminderWithTitle:error];
                                                 }];
}


/**
*  下一步
*/
- (void)nextStep {
    NSLog(@"下一步");
    if ([CommUtils isNull:self.phoneNumberTextFieldView.textfield.text]) {
        [YKProgressHDTool reminderWithTitle:@"手机号为空！"];
        return;
    }

    if (![self.phoneNumberTextFieldView.textfield.text isValidMobileNumber]) {
        [YKProgressHDTool reminderWithTitle:@"手机号格式不对!"];
        return;
    }

    if ([CommUtils isNull:self.codeNumberTextFieldView.textfield.text]) {
        [YKProgressHDTool reminderWithTitle:@"验证码为空!"];
        return;
    }

    if (![self.code isEqualToString:self.codeNumberTextFieldView.textfield.text]) {
        [YKProgressHDTool reminderWithTitle:@"验证码不正确"];
        return;
    } else {
        if (self.viewControllerType == PushViewControllerForResign) {
            YKSetInfomationViewController *setInfomationViewController = [[YKSetInfomationViewController alloc] init];
            setInfomationViewController.code = self.code;
            setInfomationViewController.phoneNumble = self.phoneNumberTextFieldView.textfield.text;
            [self.navigationController pushViewController:setInfomationViewController animated:YES];
        } else {
            YKResetPassWordViewController *resetPassWordViewController = [[YKResetPassWordViewController alloc] init];
            resetPassWordViewController.code = self.code;
            resetPassWordViewController.phone = self.phoneNumberTextFieldView.textfield.text;
            [self.navigationController pushViewController:resetPassWordViewController animated:YES];
        }
    }


}

#pragma mark -NSTimer

- (void)toRefreshCodeButtonTitle {
    if (self.countDownTime == 0) {
        self.codeButton.userInteractionEnabled = YES;
        [self.timer setFireDate:[NSDate distantFuture]];
        [self.codeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
        self.countDownTime = kCountDownTime;
        return;
    }
    [self.codeButton setTitle:[NSString stringWithFormat:@"%i秒重新获取", self.countDownTime] forState:UIControlStateNormal];
    self.countDownTime--;
}


@end
