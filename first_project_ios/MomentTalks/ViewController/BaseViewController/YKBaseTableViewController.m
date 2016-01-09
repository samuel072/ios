//
// Created by 杨虎 on 15/7/29.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKBaseTableViewController.h"

@interface YKBaseTableViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation YKBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _tableViewDataSourceArray = @[].mutableCopy;

    _mainTableView = [UITableView new];
    [self.view addSubview:_mainTableView];
    _mainTableView.tableFooterView = [[UIView alloc] init];
    _mainTableView.backgroundColor = [UIColor clearColor];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.showsVerticalScrollIndicator = NO;
    [_mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableViewDataSourceArray.count;
}

@end