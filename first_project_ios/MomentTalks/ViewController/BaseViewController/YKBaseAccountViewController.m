//
// Created by 杨虎 on 15/7/30.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKBaseAccountViewController.h"

@interface YKBaseAccountViewController ()
/** 背景图片 */
@property(nonatomic, strong) UIImageView *backgroundImageView;
@end

@implementation YKBaseAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _backgroundImageView = [UIImageView new];
    [self.view addSubview:_backgroundImageView];
    _backgroundImageView.image = [UIImage imageNamed:@"BackgroundImage"];
    [_backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    // 背景图遮挡住了导航栏
    [self.view sendSubviewToBack:_backgroundImageView];
    // 设置导航栏为透明
    self.customNavigation.backgroundColor = [UIColor clearColor];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
@end