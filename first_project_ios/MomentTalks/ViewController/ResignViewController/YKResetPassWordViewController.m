//
//  YKResetPassWordViewController.m
//  MomentTalks
//
//  Created by bilbo on 15/8/2.
//  Copyright (c) 2015年 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKResetPassWordViewController.h"
#import "YKLoginViewController.h"

@interface YKResetPassWordViewController ()
/** 密码输入 */
@property(nonatomic, strong) YKTextFieldView *passWordTextFieldView;
/** 确认密码输入 */
@property(nonatomic, strong) YKTextFieldView *ensurePassWordTextFieldView;
/** 完成按钮 */
@property(nonatomic, strong) YKTransparentButton *finishButton;
@end

@implementation YKResetPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"重设密码";
    [self drawSubViews];
    // Do any additional setup after loading the view.
}

- (void)drawSubViews {
    self.passWordTextFieldView = [YKTextFieldView new];
    [self.view addSubview:self.passWordTextFieldView];
    self.passWordTextFieldView.placeHolder = @"请设置密码";
    self.passWordTextFieldView.textfield.secureTextEntry= YES;
    [self.passWordTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(80);
    }];

    self.ensurePassWordTextFieldView = [YKTextFieldView new];
    [self.view addSubview:self.ensurePassWordTextFieldView];
    self.ensurePassWordTextFieldView.placeHolder = @"请确认密码";
    self.ensurePassWordTextFieldView.textfield.secureTextEntry= YES;
    [self.ensurePassWordTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.passWordTextFieldView.mas_left);
        make.right.mas_equalTo(self.passWordTextFieldView.mas_right);
        make.height.mas_equalTo(self.passWordTextFieldView.mas_height);
        make.top.mas_equalTo(self.passWordTextFieldView.mas_bottom).offset(20);
    }];

    self.finishButton = [YKTransparentButton new];
    [self.view addSubview:self.finishButton];
    [self.finishButton setTitle:@"修改" forState:UIControlStateNormal];
    [self.finishButton addTarget:self action:@selector(finishResetPassWord) forControlEvents:UIControlEventTouchUpInside];
    [self.finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.ensurePassWordTextFieldView.mas_left);
        make.right.mas_equalTo(self.ensurePassWordTextFieldView.mas_right);
        make.height.mas_equalTo(self.ensurePassWordTextFieldView.mas_height);
        make.top.mas_equalTo(self.ensurePassWordTextFieldView.mas_bottom).offset(20);
    }];
}


- (void)finishResetPassWord {
    if (self.passWordTextFieldView.textfield.text.length == 0 ||
            self.ensurePassWordTextFieldView.textfield.text.length == 0) {
        [YKProgressHDTool reminderWithTitle:@"请输入密码"];
        return;
    }

    if (self.passWordTextFieldView.textfield.text.length < 6 ||
            self.ensurePassWordTextFieldView.textfield.text.length < 6) {
        [YKProgressHDTool reminderWithTitle:@"密码不少于6位"];
        return;
    }

    if (![self.passWordTextFieldView.textfield.text isEqualToString:self.ensurePassWordTextFieldView.textfield.text]) {
        [YKProgressHDTool reminderWithTitle:@"俩次输入不统一"];
        return;
    }
    [YKApiRequestServer updatePasswordWithPhone:self.phone
                                           code:self.code
                                       password:self.ensurePassWordTextFieldView.textfield.text
                                        success:^{
                                            [YKProgressHDTool reminderWithTitle:@"修改成功"];
                                            [self popViewControllerWithClass:[YKLoginViewController class]];
                                        }
                                        failure:^(NSString *error) {
                                            [YKProgressHDTool reminderWithTitle:error];
                                        }];
}

@end
