//
//  YKProgressHDTool.m
//  CmsTopMediaCloud
//
//  Created by bilbo on 15/7/31.
//  Copyright (c) 2015年 CmsTop. All rights reserved.
//

#import "SVProgressHUD.h"

@implementation YKProgressHDTool

#pragma mark 加载状态提示

+ (void)showProgressHUD {
    [SVProgressHUD setRingThickness:2];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD show];
}

+ (void)hideProgressHUD {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD dismiss];
}

+ (void)showProgressWithTitle:(NSString *)title {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD showWithStatus:title];
}

+ (void)reminderWithTitle:(NSString *)title {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD showInfoWithStatus:title];
}

@end
