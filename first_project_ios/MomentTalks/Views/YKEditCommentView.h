//
//  YKEditCommentView.h
//  CmsTopMediaCloud
//
//  Created by bilbo on 15/4/2.
//  Copyright (c) 2015年 CmsTop. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol YKEditCommentViewDelegate <NSObject>
/**
*  评论成功
*/
- (void)editCommentViewcommentFinished;

//评论小框 取消按钮
- (void)cancleActionClick;

@end

@interface YKEditCommentView : UIView
@property(nonatomic, strong) NSString *videoId;
@property(nonatomic, strong) UIView *willShowView;
//将要显示在的视图
@property(nonatomic, weak) id <YKEditCommentViewDelegate> delegate;


- (instancetype)initWithVideoId:(NSString *)videoId;


@end
