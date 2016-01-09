//
//  YKTextFieldView.m
//  MomentTalks
//
//  Created by bilbo on 15/8/2.
//  Copyright (c) 2015年 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKTextFieldView.h"

static const CGFloat kLeftAndRightEdge = 10;

@implementation YKTextFieldView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.layer.borderWidth = 1.0;
        self.layer.cornerRadius = 5.0;
        self.layer.masksToBounds = YES;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        _textfield = [UITextField new];
        [self addSubview:_textfield];
        _textfield.textColor = [UIColor grayColor];
        [_textfield mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, kLeftAndRightEdge, 0, kLeftAndRightEdge));
        }];
    }
    return self;
}

- (void)setPlaceHolder:(NSString *)placeHolder {
    _placeHolder = placeHolder;
    self.textfield.attributedPlaceholder = [[NSAttributedString alloc]
            initWithString:placeHolder attributes:@{NSForegroundColorAttributeName : [UIColor grayColor],
                    NSFontAttributeName : [UIFont boldSystemFontOfSize:15]}];
}

@end
