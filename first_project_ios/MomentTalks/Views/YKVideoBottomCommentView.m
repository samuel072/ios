//
//  YKVideoBottomCommentView.m
//  CmsTopMediaCloud
//
//  Created by bilbo on 15/4/16.
//  Copyright (c) 2015年 CmsTop. All rights reserved.
//

#import "YKVideoBottomCommentView.h"

#define edgueLeft 15
#define edgueTop 6
#define itemWidth 36
#define resizableTop 5
#define resizableLeft 100
#define resizableBottom 5
#define resizableRight 50


@implementation YKVideoBottomCommentView {
    UIButton *shareButton;
    UIImageView *commentImageView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;

        self.backgroundColor = RGBCOLORA(244, 244, 244, 1);
        CALayer *la = [CALayer layer];
        la.frame = CGRectMake(0, 0, self.width, 1);
        la.backgroundColor = RGBCOLORA(224, 224, 224, 1).CGColor;
        [self.layer addSublayer:la];

        shareButton = [UIButton new];
        [self addSubview:shareButton];
        [shareButton setBackgroundImage:[UIImage imageNamed:@"PlayViewShareIcon"] forState:UIControlStateNormal];
        [shareButton addTarget:self action:@selector(clickToShareNews) forControlEvents:UIControlEventTouchUpInside];
        [shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_equalTo(25);
            make.width.mas_equalTo(25);
        }];

        commentImageView = [UIImageView new];
        [self addSubview:commentImageView];
        [commentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(shareButton.mas_left).offset(-15);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_equalTo(itemWidth);
            make.left.mas_equalTo(edgueLeft);
        }];

        commentImageView.image = [[UIImage imageNamed:@"CommentIcon"] resizableImageWithCapInsets:UIEdgeInsetsMake(
                resizableTop,
                resizableLeft,
                resizableBottom,
                resizableRight)                                                      resizingMode:UIImageResizingModeStretch];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(clickToComment)];
        commentImageView.userInteractionEnabled = YES;
        [commentImageView addGestureRecognizer:tap];

    }
    return self;
}

- (void)clickToComment {
    [self.delegate commentAction];
}

- (void)clickToShareNews {
    [self.delegate shareAction];
}

@end
