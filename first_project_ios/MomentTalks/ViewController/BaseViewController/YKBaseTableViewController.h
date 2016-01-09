//
// Created by 杨虎 on 15/7/29.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKBaseViewController.h"

@interface YKBaseTableViewController : YKBaseViewController
@property(nonatomic, strong) UITableView *mainTableView;
@property(nonatomic, copy) NSMutableArray *tableViewDataSourceArray;
@end