//
// Created by 杨虎 on 15/8/8.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKBaseTableViewController.h"

typedef NS_ENUM(NSInteger, PushUserCenterViewControllerType) {
    PushLoginViewControllerForResign,
    PushLoginViewControllerForRoot,
};

@interface YKUserCenterViewController : YKBaseTableViewController
@property(nonatomic, assign) PushUserCenterViewControllerType pushUserCenterViewControllerType;
@end