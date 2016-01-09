//
//  YKSetInfomationViewController.m
//  MomentTalks
//
//  Created by bilbo on 15/8/2.
//  Copyright (c) 2015年 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKSetInfomationViewController.h"
#import "YKUserCenterViewController.h"

@interface YKSetInfomationViewController ()
/** 密码输入 */
@property(nonatomic, strong) YKTextFieldView *passWordTextFieldView;

/** 确认密码输入 */
@property(nonatomic, strong) YKTextFieldView *ensurePassWordTextFieldView;

/** 昵称输入 */
@property(nonatomic, strong) YKTextFieldView *nickNameTextFieldView;

/** 完成按钮 */
@property(nonatomic, strong) YKTransparentButton *finishButton;
@end

@implementation YKSetInfomationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    [self drawSubView];
}


- (void)drawSubView {
    self.passWordTextFieldView = [YKTextFieldView new];
    [self.view addSubview:self.passWordTextFieldView];
    self.passWordTextFieldView.placeHolder = @"请设置新密码";
    self.passWordTextFieldView.textfield.secureTextEntry= YES;
    [self.passWordTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(80);
    }];

    self.ensurePassWordTextFieldView = [YKTextFieldView new];
    [self.view addSubview:self.ensurePassWordTextFieldView];
    self.ensurePassWordTextFieldView.textfield.secureTextEntry= YES;
    self.ensurePassWordTextFieldView.placeHolder = @"请确认密码";
    [self.ensurePassWordTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.passWordTextFieldView.mas_left);
        make.right.mas_equalTo(self.passWordTextFieldView.mas_right);
        make.height.mas_equalTo(self.passWordTextFieldView.mas_height);
        make.top.mas_equalTo(self.passWordTextFieldView.mas_bottom).offset(20);
    }];

    self.nickNameTextFieldView = [YKTextFieldView new];
    [self.view addSubview:self.nickNameTextFieldView];
    self.nickNameTextFieldView.placeHolder = @"请设置昵称";
    [self.nickNameTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.ensurePassWordTextFieldView.mas_left);
        make.right.mas_equalTo(self.ensurePassWordTextFieldView.mas_right);
        make.height.mas_equalTo(self.ensurePassWordTextFieldView.mas_height);
        make.top.mas_equalTo(self.ensurePassWordTextFieldView.mas_bottom).offset(20);
    }];

    self.finishButton = [YKTransparentButton new];
    [self.view addSubview:self.finishButton];
    [self.finishButton setTitle:@"完成进入个人中心" forState:UIControlStateNormal];
    [self.finishButton addTarget:self action:@selector(finishResign) forControlEvents:UIControlEventTouchUpInside];
    [self.finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nickNameTextFieldView.mas_left);
        make.right.mas_equalTo(self.nickNameTextFieldView.mas_right);
        make.height.mas_equalTo(self.nickNameTextFieldView.mas_height);
        make.top.mas_equalTo(self.nickNameTextFieldView.mas_bottom).offset(20);
    }];

}


- (void)finishResign {
    if (self.passWordTextFieldView.textfield.text.length < 6 || self.ensurePassWordTextFieldView.textfield.text.length < 6) {
        [YKProgressHDTool reminderWithTitle:@"密码不能少于六位"];
        return;
    }

    if ([CommUtils isNull:self.nickNameTextFieldView.textfield.text]) {
        [YKProgressHDTool reminderWithTitle:@"昵称为空"];
        return;
    }

    if ([CommUtils isIncludeSpecialCharact:self.nickNameTextFieldView.textfield.text]) {
        [YKProgressHDTool reminderWithTitle:@"昵称中有非法字符"];
        return;
    }
    if (![self.passWordTextFieldView.textfield.text isEqualToString:self.ensurePassWordTextFieldView.textfield.text]) {
        [YKProgressHDTool reminderWithTitle:@"输入密码不一致"];
        return;
    }

    [YKApiRequestServer userRegisterWithAccount:self.phoneNumble
                                       password:self.passWordTextFieldView.textfield.text
                                           code:self.code status:@"mobile"
                                        success:^(YKUserModel *userModel) {
                                            YKUserCenterViewController *centerViewController = [[YKUserCenterViewController alloc] init];
                                            centerViewController.pushUserCenterViewControllerType = PushLoginViewControllerForResign;
                                            [self.navigationController pushViewController:centerViewController animated:YES];
                                        }
                                        failure:^(NSString *error) {
                                            [YKProgressHDTool reminderWithTitle:error];
                                        }];
}


@end
