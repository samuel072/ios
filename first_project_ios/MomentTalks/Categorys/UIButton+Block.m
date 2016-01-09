//
//  UIButton+Block.m
//  CmsTopMediaCloud
//
//  Created by YangHu on 15/4/18.
//  Copyright (c) 2015年 CmsTop. All rights reserved.
//


#import "UIButton+Block.h"

@implementation UIButton (Block)

static char overviewKey;

- (void)handleControlWithBlock:(ActionBlock)block {
    objc_setAssociatedObject(self, &overviewKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(callActionBlock:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)callActionBlock:(id)sender {
    ActionBlock block = (ActionBlock) objc_getAssociatedObject(self, &overviewKey);
    if (block) {
        block();
    }
}


@end
