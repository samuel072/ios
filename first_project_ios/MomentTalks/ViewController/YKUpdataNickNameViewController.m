//
// Created by 杨虎 on 15/8/11.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKUpdataNickNameViewController.h"
#import "YKUserTools.h"


@interface YKUpdataNickNameViewController ()
@property(nonatomic, strong) YKTextFieldView *nickNameTextFieldView;
@property(nonatomic, strong) YKTransparentButton *finishButton;

@end

@implementation YKUpdataNickNameViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改昵称";
    [self createView];
}

- (void)createView {
    self.nickNameTextFieldView = [YKTextFieldView new];
    [self.view addSubview:self.nickNameTextFieldView];
    self.nickNameTextFieldView.placeHolder = [YKUserTools getUserInfo].userName;
    [self.nickNameTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(YKScaleNum(100));
    }];

    self.finishButton = [YKTransparentButton new];
    [self.view addSubview:self.finishButton];
    [self.finishButton setTitle:@"修改" forState:UIControlStateNormal];
    [self.finishButton addTarget:self action:@selector(updateNickNameAction) forControlEvents:UIControlEventTouchUpInside];
    [self.finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nickNameTextFieldView.mas_left);
        make.right.mas_equalTo(self.nickNameTextFieldView.mas_right);
        make.height.mas_equalTo(self.nickNameTextFieldView.mas_height);
        make.top.mas_equalTo(self.nickNameTextFieldView.mas_bottom).offset(20);
    }];
}

- (void)updateNickNameAction {
    if ([CommUtils isNull:self.nickNameTextFieldView.textfield.text]) {
        [YKProgressHDTool reminderWithTitle:@"昵称为空"];
        return;
    }

    if ([CommUtils isIncludeSpecialCharact:self.nickNameTextFieldView.textfield.text]) {
        [YKProgressHDTool reminderWithTitle:@"昵称中有非法字符"];
        return;
    }
    [YKApiRequestServer changeUserNickNameWithName:self.nickNameTextFieldView.textfield.text
                                           success:^(YKUserModel *userModel) {
                                               [super backViewControllerAction];
                                           }
                                           failure:^(NSString *error) {
                                               [YKProgressHDTool reminderWithTitle:error];
                                           }];
}
@end