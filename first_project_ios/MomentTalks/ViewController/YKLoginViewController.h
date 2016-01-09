//
// Created by 杨虎 on 15/7/30.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKBaseAccountViewController.h"
#import "YKResignViewController.h"

typedef NS_ENUM(NSInteger, PushLoginViewControllerType) {
    PushLoginViewControllerForTabar,
    PushLoginViewControllerForWebView,
    PushLoginViewControllerForProjectDetail,
};

@interface YKLoginViewController : YKBaseAccountViewController
@property(nonatomic, assign) PushLoginViewControllerType pushLoginViewControllerType;
@end