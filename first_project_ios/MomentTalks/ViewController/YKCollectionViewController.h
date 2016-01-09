//
// Created by 杨虎 on 15/8/8.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKBaseTableViewController.h"


@interface YKCollectionViewController : YKBaseTableViewController
/** 全选模式 */
@property(nonatomic, assign) BOOL selectAll;
/** 开启编辑 */
@property(nonatomic, assign) BOOL editor;

- (void)requestListData;

- (void)deleteAction;
@end