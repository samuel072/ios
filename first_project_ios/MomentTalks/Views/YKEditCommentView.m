//
//  YKEditCommentView.m
//  CmsTopMediaCloud
//
//  Created by bilbo on 15/4/2.
//  Copyright (c) 2015年 CmsTop. All rights reserved.
//

#import "PlaceholderTextView.h"
#import "YKEditCommentView.h"
#import "YKApiRequestServer.h"

#define kEdgueXAndY YKScaleNum(10) //与屏幕边界距离
#define widthAndHeight 30 //按钮高度宽度
#define kTitleWidth 100//标题宽度
#define textViewHeight (YKScreenFrameW - kEdgueXAndY * 2)*13/46   //输入框高度
#define textViewWidth YKScreenFrameW - kEdgueXAndY * 2

@interface YKEditCommentView ()

/**
* 编辑评论窗口
*/
@property(nonatomic, strong) UIView *bottomView;

/**
* 取消图标
*/
@property(nonatomic, strong) UIButton *cancelButton;

/**
* 确定图标
*/
@property(nonatomic, strong) UIButton *enterButton;

/**
* 评论编辑框
*/
@property(nonatomic, strong) PlaceholderTextView *commentTextView;

/**
* 输入框标题
*/
@property(nonatomic, strong) UILabel *commentTitle;

@end

@implementation YKEditCommentView

#pragma mark - Lifecycle

- (instancetype)initWithVideoId:(NSString *)videoId {
    self = [super init];
    if (self) {
        _videoId = videoId;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyBoardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyBoardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        self.frame = CGRectMake(0, 0, YKScreenFrameW, YKScreenFrameH);
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YKScreenFrameW, 0)];
        _bottomView.backgroundColor = YKColorString(@"#ebebeb");
        [self addSubview:_bottomView];
        [self setBottomView];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Public

- (void)setWillShowView:(UIView *)willShowView {
    _willShowView = willShowView;
    [willShowView addSubview:self];
}

#pragma mark - Private

- (void)setBottomView {
    UIColor *color = YKColorString(@"#262626");
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelButton.frame = CGRectMake(kEdgueXAndY, kEdgueXAndY, widthAndHeight, widthAndHeight);
    [_bottomView addSubview:_cancelButton];

    [_cancelButton addTarget:self action:@selector(cancleAction) forControlEvents:UIControlEventTouchUpInside];
    _enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _enterButton.frame = CGRectMake(
            YKScreenFrameW - kEdgueXAndY - widthAndHeight,
            kEdgueXAndY,
            widthAndHeight,
            widthAndHeight);
    [_bottomView addSubview:_enterButton];

// 取消 和 确定
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelButton setTitleColor:color forState:UIControlStateNormal];
    _cancelButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_enterButton setTitle:@"确定" forState:UIControlStateNormal];
    [_enterButton addTarget:self action:@selector(enterAction) forControlEvents:UIControlEventTouchUpInside];
    _enterButton.titleLabel.font = [UIFont systemFontOfSize:13];

    [_enterButton setTitleColor:color forState:UIControlStateNormal];

    _commentTextView = [[PlaceholderTextView alloc] initWithFrame:CGRectMake(
            kEdgueXAndY,
            _cancelButton.yh + kEdgueXAndY,
            textViewWidth,
            textViewHeight)];
    _commentTextView.placeholder = [NSString stringWithFormat:@"回复"];
    _commentTextView.textColor = color;
    _commentTextView.font = [UIFont systemFontOfSize:17];
    _commentTextView.placeholderFont = [UIFont systemFontOfSize:17];
    _commentTextView.layer.borderWidth = 0.5;

    UIColor *lineColor = YKColorString(@"#dcdcdc")
    _commentTextView.layer.borderColor = lineColor.CGColor;
    [_commentTextView becomeFirstResponder];
    [_bottomView addSubview:_commentTextView];
    _commentTitle = [[UILabel alloc] initWithFrame:CGRectMake(
            0,
            0,
            kTitleWidth,
            widthAndHeight)];
    _commentTitle.center = CGPointMake(_bottomView.center.x, _enterButton.center.y);
    _commentTitle.text = @"发评论";
    _commentTitle.textColor = color;
    _commentTitle.backgroundColor = [UIColor clearColor];
    _commentTitle.font = [UIFont systemFontOfSize:18];
    _commentTitle.textAlignment = NSTextAlignmentCenter;


    [_bottomView addSubview:_commentTitle];
    _bottomView.height = _commentTextView.yh + kEdgueXAndY;
    _bottomView.frame = CGRectMake(
            0,
            YKScreenFrameH - _commentTextView.yh - kEdgueXAndY,
            YKScreenFrameW,
            _commentTextView.yh + kEdgueXAndY);
}


/**
*  取消评论  按钮点击响应
*/
- (void)cancleAction {
//    [self endEditing:YES];
    
    if ([self.delegate respondsToSelector:@selector(cancleActionClick)]) {
        [self.delegate cancleActionClick];
    }
}

/**
*  确定评论
*/
- (void)enterAction {
    
    [YKApiRequestServer addVideoCommentWithResourceId:self.videoId
                                               status:@"1"
                                              content:self.commentTextView.text
                                              success:^{
 //                                                 [self endEditing:YES];
                                                  [self.delegate editCommentViewcommentFinished];
                                                  [YKProgressHDTool reminderWithTitle:@"评论成功"];
                                                  NSLog(@"确定");
                                                  [self cancleAction];
                                              }
                                              failure:^(NSString *error) {
                                                  [YKProgressHDTool reminderWithTitle:error];
                                                  [self cancleAction];
                                              }];
}
// 评论内容不能为空

//    NSString *result = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

//  if ([result isEqualToString:@""] || result == nil) {
//  UIAlertView *view = [[UIAlertView alloc] initWithTitle:nil message:@"输入内容不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//                                                      [view show];



- (void)keyBoardWillHide:(NSNotification *)note {
    NSNumber *duration = note.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    CGRect containerFrame = self.bottomView.frame;
    containerFrame.origin.y = YKScreenFrameH;
    [UIView animateWithDuration:[duration doubleValue] animations:^{
        self.alpha = 0;
        self.bottomView.frame = containerFrame;
    }                completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)keyBoardWillShow:(NSNotification *)note {
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardBounds];
    NSNumber *duration = note.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = note.userInfo[UIKeyboardAnimationCurveUserInfoKey];
    keyboardBounds = [self convertRect:keyboardBounds toView:nil];
    CGRect containerFrame = self.bottomView.frame;
    containerFrame.origin.y = YKScreenFrameH - (keyboardBounds.size.height + containerFrame.size.height);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:(UIViewAnimationCurve) [curve intValue]];
    self.bottomView.frame = containerFrame;
    [UIView commitAnimations];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.commentTextView resignFirstResponder];
}


@end
