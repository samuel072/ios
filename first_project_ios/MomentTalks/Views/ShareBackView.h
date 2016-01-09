//
//  ShareBackView.h
//  CmsTopMediaCloud
//
//  Created by bilbo on 15/8/11.
//  Copyright (c) 2015年 CmsTop. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^shareBackBlock)(NSInteger);

@interface ShareBackView : UIView
@property(nonatomic, copy) shareBackBlock shareBlock;

+ (instancetype)showBackViewWithBlock:(shareBackBlock)backBlock;

@end
