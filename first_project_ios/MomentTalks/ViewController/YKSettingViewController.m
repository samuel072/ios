//
// Created by 杨虎 on 15/8/8.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <SDWebImage/SDImageCache.h>
#import "YKSettingViewController.h"
#import "YKUserInfoCell.h"
#import "YKUserTools.h"

static const NSString *identifier = @"YKLiveViewControllerYKTwoVideoCell";

@interface YKSettingViewController ()
@end

@implementation YKSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 2) {
//        return 80;
//    }
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {

        case 0:
            [YKApiRequestServer checkVersion];
            break;
        case 1:
            [[SDImageCache sharedImageCache] clearDisk];
            [[SDImageCache sharedImageCache] clearMemory];
            [YKProgressHDTool reminderWithTitle:@"清理完成!"];
            [self.mainTableView reloadData];
            break;
        case 2:
            [YKApiRequestServer userLogOutWithSuccess:^{
                        [[NSNotificationCenter defaultCenter] postNotificationName:YKLoginOutSuccessNotificationKey object:nil];
                        [YKUserTools clearUserInfo];
                        [YKSharedAppDelegate.tabBarController setTabBarHidden:NO animated:YES];
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    }
                                              failure:^(NSString *error) {
                                                  [YKProgressHDTool reminderWithTitle:@"退出失败"];
                                              }];
            break;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YKUserInfoCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!tableViewCell) {
        tableViewCell = [[YKUserInfoCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                              reuseIdentifier:identifier];
    }
    switch (indexPath.section) {
        case 0: {
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            // app版本
            NSString *app_Version = infoDictionary[@"CFBundleShortVersionString"];
            tableViewCell.title = [NSString stringWithFormat:@"当前版本号：%@", app_Version];
            tableViewCell.arrowIconImageView.hidden = YES;
        }
            break;
        case 1: {
            tableViewCell.title = @"清除缓存";
            CGFloat cacheSize = (CGFloat) ([[SDImageCache sharedImageCache] getSize] / 1024.0 / 1024.0);
            tableViewCell.info = [NSString stringWithFormat:@"%.1fMB", cacheSize];
        }
            break;
            /*
        case 2: {
            tableViewCell.arrowIconImageView.hidden = YES;
            [tableViewCell.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(10);
                make.left.mas_equalTo(15);
                make.height.mas_equalTo(20);
            }];

            NSArray *platIconArray = @[@"QQPlatIcon", @"WXPlatIcon", @"SinaPlatIcon"];
            UIImageView *lastView = nil;
            for (NSString *iconName in platIconArray) {
                UIImageView *platIconImageView = [UIImageView new];
                [tableViewCell.contentView addSubview:platIconImageView];
                platIconImageView.image = [UIImage imageNamed:iconName];
                [platIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo(CGSizeMake(35, 35));
                    if (lastView) {
                        make.left.mas_equalTo(lastView.mas_right).offset(15);
                    } else {
                        make.left.mas_equalTo(15);
                    }
                    make.top.mas_equalTo(tableViewCell.titleLabel.mas_bottom).offset(7);
                }];
                lastView = platIconImageView;
            }
            tableViewCell.title = @"登录设置";
        }
            break;
            */
        case 2:
            tableViewCell.arrowIconImageView.hidden = YES;
            tableViewCell.title = @"退出";
            tableViewCell.titleLabel.textColor = YKThemeColor;
            [tableViewCell.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.center.mas_equalTo(tableViewCell.contentView);
            }];
            break;
    }

    return tableViewCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [YKUserTools isLogin] ? 3 : 2;
}

// cell之间的间隔
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}
@end