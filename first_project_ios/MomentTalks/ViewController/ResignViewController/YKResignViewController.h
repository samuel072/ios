//
//  YKResignViewController.h
//  MomentTalks
//
//  Created by bilbo on 15/8/2.
//  Copyright (c) 2015年 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKBaseAccountViewController.h"
#import "YKSetInfomationViewController.h"

typedef NS_ENUM(NSInteger, PushViewControllerType) {
    PushViewControllerForForgetPassword, // 从忘记密码界面push
    PushViewControllerForResign, // 从注册界面push
};

@interface YKResignViewController : YKBaseAccountViewController
@property(nonatomic, assign) PushViewControllerType viewControllerType;

@end
