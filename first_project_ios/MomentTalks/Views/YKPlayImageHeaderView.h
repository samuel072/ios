//
//  YKPlayImageHeaderView.h
//  CmsTopMediaCloud
//
//  Created by bilbo on 15/3/18.
//  Copyright (c) 2015年 CmsTop. All rights reserved.
//

#import <UIKit/UIKit.h>

static const NSInteger CTPlayHeaderViewImageViewStartTag = 100;

@protocol YKPlayImageHeaderViewDelegate <NSObject>

/**
* 图片被点击
*/
- (void)didSelectImageAtIndex:(NSInteger)index;

/**
* 返回一共多少张图片
*/
- (int)numberOfHeadImageView;

/**
* 每张图片的URL地址
*/
- (NSString *)iamgeUrlOfHeadImageViewAtIndex:(int)index;

@end

@interface YKPlayImageHeaderView : UIView <UIScrollViewDelegate>
@property(nonatomic, weak) id <YKPlayImageHeaderViewDelegate> delegate;

@end

