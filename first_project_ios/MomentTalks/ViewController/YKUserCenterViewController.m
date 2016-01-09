//
// Created by 杨虎 on 15/8/8.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "YKUserCenterViewController.h"
#import "YKUserCenterCell.h"
#import "YKUserInfoViewController.h"
#import "YKCollectionViewController.h"
#import "YKSettingViewController.h"
#import "YKReservationViewController.h"

static const NSString *identifier = @"YKLiveViewControllerYKTwoVideoCell";

@interface YKUserCenterViewController ()
@property(nonatomic, strong) NSArray *titleArray;
@property(nonatomic, strong) NSArray *iconArray;
@property(nonatomic, strong) UIImageView *faceImageView;
@property(nonatomic, strong) UILabel *nikeNameLabel;
@end

@implementation YKUserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    self.titleArray = @[@"我预约的", @"我收藏的"];
    self.iconArray = @[@"UserCenterReservation", @"UserCenterCollectr"];

    self.mainTableView.tableHeaderView = [self createTableHeadView];
    [self setUserInfo];
    [self requestUserInfo];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setUserInfo];
}

- (void)backViewControllerAction {
    // 如果是从注册跳转进来的，点击返回直接到主界面
    if (self.pushUserCenterViewControllerType == PushLoginViewControllerForResign) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        [YKSharedAppDelegate.tabBarController setTabBarHidden:NO animated:NO];
    } else {
        [super backViewControllerAction];
    }
}

- (void)requestUserInfo {
    [YKApiRequestServer requestUserInfoWithSuccess:^(YKUserModel *userModel) {
                [self setUserInfo];
            }
                                           failure:^(NSString *error) {

                                           }];
}

- (UIView *)createTableHeadView {
    UIImageView *backgroundImageVIew = [[UIImageView alloc] initWithFrame:CGRectMake(
            0,
            0,
            YKScreenFrameW,
            YKScaleNum(180))];
    backgroundImageVIew.image = [UIImage imageNamed:@"UserCenterBackground"];
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                        action:@selector(loginAction)];
    backgroundImageVIew.userInteractionEnabled = YES;
    [backgroundImageVIew addGestureRecognizer:gestureRecognizer];

    UIImageView *whiteArrowIconImageView = [UIImageView new];
    [backgroundImageVIew addSubview:whiteArrowIconImageView];
    whiteArrowIconImageView.image = [UIImage imageNamed:@"WhiteArrowIcon"];
    [whiteArrowIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-15);
        make.right.mas_equalTo(-10);
        make.width.with.height.mas_equalTo(20);
    }];

    self.faceImageView = [UIImageView new];
    [backgroundImageVIew addSubview:self.faceImageView];
    self.faceImageView.layer.masksToBounds = YES;
    self.faceImageView.layer.cornerRadius = YKScaleNum(70) / 2;
    [self.faceImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.with.height.mas_equalTo(YKScaleNum(70));
        make.center.mas_equalTo(backgroundImageVIew);
    }];

    self.nikeNameLabel = [UILabel new];
    [backgroundImageVIew addSubview:self.nikeNameLabel];
    self.nikeNameLabel.font = [UIFont systemFontOfSize:16];
    self.nikeNameLabel.textColor = [UIColor whiteColor];
    self.nikeNameLabel.textAlignment = NSTextAlignmentCenter;
    [self.nikeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(200);
        make.top.mas_equalTo(self.faceImageView.mas_bottom).offset(10);
        make.centerX.mas_equalTo(backgroundImageVIew);
        make.height.mas_equalTo(20);
    }];

    return backgroundImageVIew;
}

- (void)setUserInfo {
    [self.faceImageView sd_setImageWithURL:[[YKUserTools getUserInfo].faceUrl toUrl]];
    self.nikeNameLabel.text = [YKUserTools getUserInfo].userName;
}

#pragma mark Action

- (void)loginAction {
//    YKLoginViewController *loginViewController = [[YKLoginViewController alloc] init];
//    [self.navigationController pushViewController:loginViewController animated:YES];
    YKUserInfoViewController *userInfoViewController = [[YKUserInfoViewController alloc] init];
    [self.navigationController pushViewController:userInfoViewController animated:YES];
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            // 预约
            YKReservationViewController *reservationViewController = [[YKReservationViewController alloc] init];
            [self.navigationController pushViewController:reservationViewController animated:YES];
        } else if (indexPath.row == 1) {
            // 收藏
            YKCollectionViewController *collectionViewController = [[YKCollectionViewController alloc] init];
            [self.navigationController pushViewController:collectionViewController animated:YES];
        }
    } else {
        // 设置
        YKSettingViewController *settingViewController = [[YKSettingViewController alloc] init];
        [self.navigationController pushViewController:settingViewController animated:YES];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YKUserCenterCell *projectDetailCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!projectDetailCell) {
        projectDetailCell = [[YKUserCenterCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                                    reuseIdentifier:identifier];
    }
    if (indexPath.section == 0) {
        projectDetailCell.title = self.titleArray[(NSUInteger) indexPath.row];
        projectDetailCell.typeIconImageView.image = [UIImage imageNamed:self.iconArray[(NSUInteger) indexPath.row]];
    } else {
        projectDetailCell.title = @"设置";
        projectDetailCell.typeIconImageView.image = [UIImage imageNamed:@"UserCenterSetting"];
    }
    return projectDetailCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.titleArray.count;
    } else {
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

// cell之间的间隔
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}
@end