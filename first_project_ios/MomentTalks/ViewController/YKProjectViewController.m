//
// Created by 杨虎 on 15/7/29.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKProjectViewController.h"
#import "YKProjectCell.h"
#import "YKProjectDetailViewController.h"

static NSString *identifier = @"YKProjectViewController";

@interface YKProjectViewController ()
@property(nonatomic, strong) YKProjectListModel *projectListModel;
@end

@implementation YKProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"专题";
    [self.mainTableView registerClass:[YKProjectCell class] forCellReuseIdentifier:identifier];
    [self requesetProjectListData];
}

/**
* 请求专题数据
*/
- (void)requesetProjectListData {
    [YKApiRequestServer requestProjectListWithSuccess:^(YKProjectListModel *projectListModel) {
        self.projectListModel = projectListModel;
        [self.mainTableView reloadData];
    }                                         failure:^(NSString *error) {
        [YKProgressHDTool reminderWithTitle:error];
    }];
}


#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return YKProjectCellHeigth + 10;
}

// cell之间的间隔
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YKProjectListData *projectListData = self.projectListModel.data[(NSUInteger) indexPath.section];
    YKProjectDetailViewController *projectDetailViewController = [[YKProjectDetailViewController alloc] init];
    projectDetailViewController.albumId = projectListData.albumId;
    [self.navigationController pushViewController:projectDetailViewController animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YKProjectCell *rankCell = [tableView dequeueReusableCellWithIdentifier:identifier
                                                              forIndexPath:indexPath];
    YKProjectListData *projectListData = self.projectListModel.data[(NSUInteger) indexPath.section];
    rankCell.projectListData = projectListData;
    return rankCell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.projectListModel.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

@end