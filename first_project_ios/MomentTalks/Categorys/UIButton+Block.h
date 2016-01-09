//
//  UIButton+Block.h
//  CmsTopMediaCloud
//
//  Created by YangHu on 15/4/18.
//  Copyright (c) 2015年 CmsTop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

typedef void (^ActionBlock)();

/**
* 实例化按钮时按钮点击事件在block里面写
*/
@interface UIButton (Block)


- (void)handleControlWithBlock:(ActionBlock)action;

@end
