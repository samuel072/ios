//
//  UIView+Extensions.h
//  17Snooker
//
//  Created by TangTao on 14-4-22.
//  Copyright (c) 2014年 LookMedia-China. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extensions)

@property float x;

@property float y;

@property float width;

@property float height;

@property float yh;

@property float xw;

@property(nonatomic, assign) CGSize size;

- (void)clearView;

- (void)removeViewWithTag:(NSInteger)viewTag;

@end
