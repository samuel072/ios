//
//  UIView+Masonry_LJC.h
//  CmsTopMediaCloud
//
//  Created by YangHu on 15/3/6.
//  Copyright (c) 2015年 CmsTop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

@interface UIView (Masonry_LJC)
/**
*  横着摆放view
*
*  @param views view
*/
- (void)distributeSpacingHorizontallyWith:(NSArray *)views;

/**
*  竖着摆放view
*
*  @param views view
*/
- (void)distributeSpacingVerticallyWith:(NSArray *)views;

@end
