//
// Created by 杨虎 on 15/7/30.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKMoreVideoCell.h"
#import "YKVideoItemView.h"
#import "YKTableSectionHeadView.h"


const static int kMenuViewColumnNum = 2;        // 列数
const static int MENU_VIEW_START_TAG = 201;     // tag起始值
const CGFloat YKMoreVideoCellMenuViewMargin = 10;
const CGFloat YKMoreVideoCellSectionHeadHeight = 30;

@interface YKMoreVideoCell ()
@property(nonatomic, strong) YKVideoItemView *fristItemView;
@property(nonatomic, strong) YKVideoItemView *secondItemView;
@property(nonatomic, strong) YKTableSectionHeadView *headView;
@property(nonatomic, strong) MASConstraint *maker;
@property(nonatomic, assign) BOOL didSetupConstraints;
@end

@implementation YKMoreVideoCell
- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)updateConstraints {
    [super updateConstraints];
}

- (void)setVideoDataArray:(NSMutableArray <YKHomeVideoListDataDataModel> *)videoDataArray {
    _videoDataArray = videoDataArray;
    [self createView];
    YKHomeVideoListDataDataModel *homeVideoListDataDataModel = videoDataArray[0];
    self.headView.title = homeVideoListDataDataModel.sectionHeadTitle;
}

- (void)createView {
    _headView = [YKTableSectionHeadView new];
    [self.contentView addSubview:_headView];
    _headView.backgroundColor = [UIColor clearColor];
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0).priority(999);
        make.right.mas_equalTo(0).priority(999);
        make.height.mas_equalTo(YKMoreVideoCellSectionHeadHeight);
        make.top.mas_equalTo(0);
    }];
    [self createMenuView:self.contentView topView:_headView];
}

- (void)setExploreListInfo:(YKExploreListInfo *)exploreListInfo {
    _exploreListInfo = exploreListInfo;
    [self createView];
    self.headView.title = exploreListInfo.name;
}

- (void)setListenToMeData:(NSArray <YKListenToMeData> *)listenToMeData {
    if (listenToMeData == nil) {
        return;
    }
    _listenToMeData = listenToMeData;
    [self createView];
    self.headView.title = @"听我说";
}

/**
* 创建视频集布局
*/
- (void)createMenuView:(UIView *)container topView:(UIView *)topView {
    CGFloat viewWidth = (YKScreenFrameW - YKMoreVideoCellMenuViewMargin * 3) / 2;
    YKVideoItemView *lastMenuItemView = nil;
    int count = 0;
    if (self.exploreListInfo) {
        count = self.exploreListInfo.num;
    } else if (self.videoDataArray) {
        count = (int) self.videoDataArray.count;
    } else if (self.listenToMeData) {
        count = (int) self.listenToMeData.count;
    }
    if (count > 4) {
        UIButton *moreButton = [UIButton new];
        [container addSubview:moreButton];
        moreButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [moreButton setTitleColor:YKThemeColor forState:UIControlStateNormal];
        [moreButton setTitle:@"更多" forState:UIControlStateNormal];
        [moreButton addTarget:self action:@selector(moreClickAction) forControlEvents:UIControlEventTouchUpInside];
        [moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(topView);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(30);
            make.right.mas_equalTo(-10);
        }];
        count = 4;
    }


//数组越界的部分  for（int a = 0；a < count; a++）
//  count --->  self.exploreListInfo.info
//  for（int a = 0；a < self.exploreListInfo.info; a++）

    for (int a = 0; a < count; a++) {
        YKVideoItemView *menuItemView = [YKVideoItemView new];
        [container addSubview:menuItemView];

        // 设置数据
        if (self.exploreListInfo) {
            YKExploreListInfoInfo *exploreListInfo = self.exploreListInfo.info[a];
            menuItemView.exploreListInfo = exploreListInfo;
        } else if (self.videoDataArray) {
            YKHomeVideoListDataDataModel *homeVideoListDataDataModel = self.videoDataArray[a];
            menuItemView.homeVideoListDataDataModel = homeVideoListDataDataModel;
        } else if (self.listenToMeData) {
            YKListenToMeData *listenToMeData = self.listenToMeData[a];
            menuItemView.listenToMeData = listenToMeData;
        }

        // 添加点击事件
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                initWithTarget:self
                        action:@selector(menuClickAction:)];
        [menuItemView addGestureRecognizer:tapGestureRecognizer];
        menuItemView.userInteractionEnabled = YES;

        int line = a / kMenuViewColumnNum; // 当前行
        int row = a % kMenuViewColumnNum;  // 当前列

        menuItemView.tag = MENU_VIEW_START_TAG + a;
        [menuItemView mas_makeConstraints:^(MASConstraintMaker *make) {

            if (!lastMenuItemView) {
                make.left.mas_equalTo(YKMoreVideoCellMenuViewMargin);
            } else {
                if (row == 0) {
                    make.left.mas_equalTo(YKMoreVideoCellMenuViewMargin);
                } else {
                    make.left.mas_equalTo(lastMenuItemView.mas_right).offset(YKMoreVideoCellMenuViewMargin);
                }
            }

            if (line == 0) {
                make.top.mas_equalTo(topView.mas_bottom).offset(YKMoreVideoCellMenuViewMargin);
            } else {
                if (row == 0) {
                    make.top.mas_equalTo(lastMenuItemView.mas_bottom).offset(YKMoreVideoCellMenuViewMargin);
                } else {
                    make.top.mas_equalTo(lastMenuItemView.mas_top);
                }
            }
            if (a == count - 1) {
                make.bottom.mas_equalTo(-10);
            }

            make.height.mas_equalTo(YKMoreVideoCellMenuViewHeight);
            make.width.mas_equalTo(viewWidth);
        }];
        lastMenuItemView = menuItemView;
    }
}

- (void)moreClickAction {
    if (self.exploreCellDelegate) {
        [self.exploreCellDelegate moreClickAtIndexPath:self.indexPath];
    }
}

/**
* 视频点击
*/
- (void)menuClickAction:(UITapGestureRecognizer *)tapGestureRecognizer {
    int index = (int) tapGestureRecognizer.view.tag - MENU_VIEW_START_TAG;
    if (self.liveCellDelegate) {
        [self.liveCellDelegate menuItemClickWithHomeVideoListDataDataModel:self.videoDataArray[(NSUInteger) index]];
    } else if (self.exploreCellDelegate) {
        NSIndexPath *newindexPath = [NSIndexPath indexPathForRow:index inSection:self.indexPath.section];
        [self.exploreCellDelegate menuItemClickAtIndexPath:newindexPath];
    }
}

@end