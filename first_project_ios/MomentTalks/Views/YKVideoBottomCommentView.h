//
//  YKVideoBottomCommentView.h
//  CmsTopMediaCloud
//
//  Created by bilbo on 15/4/16.
//  Copyright (c) 2015年 CmsTop. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YKVideoBottomCommentViewDelegate <NSObject>
/**
*  点击评论
*/
- (void)commentAction;

/**
*  分享
*/
- (void)shareAction;


@end

@interface YKVideoBottomCommentView : UIView

@property(nonatomic, weak) id <YKVideoBottomCommentViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame;

@end
