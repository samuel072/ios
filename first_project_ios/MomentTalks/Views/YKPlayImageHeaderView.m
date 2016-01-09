//
//  YKPlayImageHeaderView.m
//  CmsTopMediaCloud
//
//  Created by bilbo on 15/3/18.
//  Copyright (c) 2015年 CmsTop. All rights reserved.
//

#import "YKPlayImageHeaderView.h"
#import "TAPageControl.h"
#import "UIImageView+WebCache.h"
#import "UIView+Masonry_LJC.h"


@interface YKPlayImageHeaderView ()

@property(nonatomic, strong) UIScrollView *mainScrollView;  //滑动背景
@property(nonatomic, strong) TAPageControl *pageContro;  //索引pageControl
@property(nonatomic, assign) NSInteger pageNum;   //页码
@property(nonatomic, strong) NSTimer *aotuNextPagetime;
@end

@implementation YKPlayImageHeaderView

- (instancetype)init {
    self = [super initWithFrame:CGRectMake(0, 0, YKScreenFrameW, (YKScreenFrameW * 9) / 16)];
    if (self) {

    }
    return self;
}

- (void)setDelegate:(id <YKPlayImageHeaderViewDelegate>)delegate {
    _delegate = delegate;
    [self clearView];
    [self createSlidePlayImageView];
    self.aotuNextPagetime = [NSTimer scheduledTimerWithTimeInterval:8.0
                                                             target:self
                                                           selector:@selector(nextPageAction)
                                                           userInfo:nil
                                                            repeats:YES];
}

- (void)nextPageAction {
    self.pageNum++;
    if (self.pageNum == [self.delegate numberOfHeadImageView]) {
        self.pageNum = 0;
    }
    [self.mainScrollView setContentOffset:CGPointMake(YKScreenFrameW * self.pageNum, 0) animated:YES];
    self.pageContro.currentPage = self.pageNum;
}

/**
* 初始化滑动布局
*/
- (void)createSlidePlayImageView {

    self.mainScrollView = [UIScrollView new];
    [self addSubview:self.mainScrollView];
    self.mainScrollView.backgroundColor = [UIColor purpleColor];
    self.mainScrollView.contentSize = CGSizeMake(self.width * [self.delegate numberOfHeadImageView], 0);
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    self.mainScrollView.pagingEnabled = YES;
    self.mainScrollView.bounces = NO;
    self.mainScrollView.delegate = self;
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];

    NSMutableArray *newsImageArray = [NSMutableArray array];
    for (NSInteger i = 0; i < [self.delegate numberOfHeadImageView]; i++) {
        UIImageView *playHeaderImageView = [UIImageView new];
        [self.mainScrollView addSubview:playHeaderImageView];
        playHeaderImageView.tag = CTPlayHeaderViewImageViewStartTag + i;
        playHeaderImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                initWithTarget:self
                        action:@selector(clickOnImageView:)];
        [playHeaderImageView addGestureRecognizer:tapGestureRecognizer];
        playHeaderImageView.clipsToBounds = YES;
        playHeaderImageView.contentMode = UIViewContentModeScaleAspectFill;
        [playHeaderImageView sd_setImageWithURL:[NSURL URLWithString:[self.delegate iamgeUrlOfHeadImageViewAtIndex:i]]
                               placeholderImage:[UIImage imageNamed:@"SlidingNewsThumb"]];
        [playHeaderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(self.width, self.height));
        }];
        [newsImageArray addObject:playHeaderImageView];
    }
    [self.mainScrollView distributeSpacingHorizontallyWith:newsImageArray];

    self.pageContro = [TAPageControl new];
    [self addSubview:self.pageContro];
    [self.pageContro mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.centerX.mas_equalTo(self);
        make.height.mas_equalTo(20);
    }];
    self.pageContro.dotImage = [UIImage imageNamed:@"DropIcon"];
    self.pageContro.currentDotImage = [UIImage imageNamed:@"DropPressIcon"];
    self.pageContro.numberOfPages = [self.delegate numberOfHeadImageView];
    self.pageContro.backgroundColor = self.backgroundColor;
    self.pageNum = 0;
}


#pragma mark -IBAction

- (void)clickOnImageView:(UITapGestureRecognizer *)tap {
    NSInteger index = tap.view.tag - CTPlayHeaderViewImageViewStartTag;
    [self.delegate didSelectImageAtIndex:index];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.pageNum = (NSInteger) (scrollView.contentOffset.x / self.width);
    self.pageContro.currentPage = self.pageNum;
    //取消手势屏蔽
}


@end
