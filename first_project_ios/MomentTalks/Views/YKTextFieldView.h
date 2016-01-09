//
//  YKTextFieldView.h
//  MomentTalks
//
//  Created by bilbo on 15/8/2.
//  Copyright (c) 2015年 com.yikeyanjiang.tiger. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKTextFieldView : UIView
/** 输入框 */
@property(nonatomic, strong) UITextField *textfield;

/** 输入框默认占位文字 */
@property(nonatomic, copy) NSString *placeHolder;
@end
