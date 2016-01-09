//
// Created by 杨虎 on 15/7/30.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKSearchViewController.h"
#import "YKTableSectionHeadView.h"
#import "UIImageView+WebCache.h"
#import "YKSearchCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "YKVideoDetailViewController.h"
#import "YKProjectDetailViewController.h"

const static int kMenuViewColumnNum = 2;        // 列数
const static int MENU_VIEW_START_TAG = 201;     // tag起始值
const CGFloat kMenuViewMargin = 10;       // 菜单与菜单之间的边距

static NSString *identifier = @"YKSearchCell";

#define YKMoreVideoCellMenuViewHeight YKScaleNum(100)         // 菜单高度 CTScaleNum(100)

@interface YKSearchViewController () <UITextFieldDelegate>
@property(nonatomic, strong) UIScrollView *mainScrollView;
/** 猜你喜欢数据 */
@property(nonatomic, strong) NSArray <YKHomeVideoListDataDataModel> *guessYouLike;
/** 搜索结果数据 */
@property(nonatomic, copy) NSArray <YKSearchListDataVideoList> *searchVideoList;
@property(nonatomic, strong) NSArray <YKHotSearchKeyWordDataRow, Optional> *hotSearchList;
@property(nonatomic, strong) UITextField *srarchTextField;
@property(nonatomic, assign) BOOL requestrequestGuessYouLikeSuccess;
@property(nonatomic, assign) BOOL requesthotSearchSuccess;
@end

@implementation YKSearchViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.customNavigation clearView];
    [self createNavigationView];

    self.mainTableView.hidden = YES;
    self.mainTableView.backgroundColor = [UIColor whiteColor];
    [self.mainTableView registerClass:[YKSearchCell class] forCellReuseIdentifier:identifier];

    _mainScrollView = [UIScrollView new];
    [self.view addSubview:_mainScrollView];
    [_mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(64, 0, 0, 0));
    }];

    [self requestGuessYouLikeData];
    [self requestHotSearch];
}

/**
* 请求猜你喜欢
*/
- (void)requestGuessYouLikeData {
    [YKApiRequestServer requestGuessYouLikeListWithSuccess:^(YKHomeVideoListModel *homeVideoListModel) {
        self.guessYouLike = ((YKHomeVideoListDataModel *) homeVideoListModel.data[0]).data;
        self.requestrequestGuessYouLikeSuccess = YES;
        if (self.requesthotSearchSuccess && self.requestrequestGuessYouLikeSuccess) {
            [self fillScrollViewData];
        }
    }                                              failure:^(NSString *error) {

    }];
}

/**
* 请求热门搜索
*/
- (void)requestHotSearch {
    [YKApiRequestServer requestHotSearchKeyWordWithsuccess:^(YKHotSearchKeyWordModel *hotSearchKeyWordModel) {
                self.hotSearchList = hotSearchKeyWordModel.data.rows;
                self.requesthotSearchSuccess = YES;
                if (self.requesthotSearchSuccess && self.requestrequestGuessYouLikeSuccess) {
                    [self fillScrollViewData];
                }
            }
                                                   failure:^(NSString *error) {

                                                   }];
}

/**
* 创建导航栏布局
*/
- (void)createNavigationView {
    UIButton *cancelButton = [self.customNavigation creatRightButtonWithTitle:@"取消" block:^{
        [super backViewControllerAction];
    }];

    // 输入框 圆角白色背景VIEW
    UIView *srarchBackgroundView = [UIView new];
    [self.customNavigation addSubview:srarchBackgroundView];
    srarchBackgroundView.backgroundColor = [UIColor whiteColor];
    srarchBackgroundView.layer.masksToBounds = YES;
    srarchBackgroundView.layer.cornerRadius = 5;
    [srarchBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(cancelButton.mas_left).offset(-10);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(20 + ((44 - 30) / 2));
    }];

    // 输入框前面的放大镜小图标
    UIImageView *srarchIconImageView = [UIImageView new];
    [srarchBackgroundView addSubview:srarchIconImageView];
    srarchIconImageView.image = [UIImage imageNamed:@"BlackSearchIcon"];
    [srarchIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.centerY.mas_equalTo(srarchBackgroundView);
        make.height.with.width.mas_equalTo(20);
    }];

    // 输入框
    self.srarchTextField = [UITextField new];
    [srarchBackgroundView addSubview:self.srarchTextField];
    self.srarchTextField.returnKeyType = UIReturnKeyDone;
    self.srarchTextField.delegate = self;
    self.srarchTextField.font = [UIFont systemFontOfSize:15];
    [self.srarchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(srarchIconImageView.mas_right).offset(5);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(30);
        make.centerY.mas_equalTo(srarchBackgroundView);
    }];
}

- (void)fillScrollViewData {
    // 用于动态计算ScrollView contentSize
    UIView *containerView = [UIView new];
    [self.mainScrollView addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.mainScrollView);
        make.width.equalTo(self.mainScrollView);
    }];

    YKTableSectionHeadView *hotHeadView = [YKTableSectionHeadView new];
    [containerView addSubview:hotHeadView];
    hotHeadView.title = @"热门搜索";
    [hotHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.width.mas_equalTo(containerView);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(20);
    }];

    NSMutableArray *hotSrarchArray = @[].mutableCopy;
    for (YKHotSearchKeyWordDataRow *model in self.hotSearchList) {
        [hotSrarchArray addObject:model.word];
    }
    UIView *hotSrarchView = [self setHotSrarchDataWithArray:hotSrarchArray inView:containerView];
    YKTableSectionHeadView *interestHeadView = [YKTableSectionHeadView new];
    [containerView addSubview:interestHeadView];
    interestHeadView.title = @"猜你喜欢";
    [interestHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(hotSrarchView.mas_bottom).offset(5);
        make.width.mas_equalTo(containerView);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(20);
    }];

    [self createMenuView:containerView topView:interestHeadView];
}

- (UIView *)setHotSrarchDataWithArray:(NSArray *)hotSrarchData inView:(UIView *)view {
    // 每个文本之间横向边距
    CGFloat horizontalMargin = 10;
    // 每个文本之间竖向边距
    CGFloat verticalMargin = 10;
    // 记录当前是第几行，刚开始默认第一行
    int line = 1;
    // 记录当前是第几列，刚开始默认第一列
    int column = 1;
    // 文字大小
    UIFont *labelFontSize = [UIFont systemFontOfSize:14];
    // 文本高度
    CGFloat labelViewHeight = 30;
    // 当前这行使用了多少宽度，用于计算剩余宽度是否够放下一个文本
    CGFloat totalUseWidth = 0;
    // 装载容器
    UIView *containerView = [UIView new];
    [view addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(40);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    for (int i = 0; i < hotSrarchData.count; ++i) {
        // 标题文字
        NSString *title = hotSrarchData[i];
        // 标题文字宽度
        CGFloat titleTextWidth = [title widthForSizeFont:labelFontSize andHeight:labelViewHeight] + 25;
        // 剩余宽度
        CGFloat remainWidth = YKScreenFrameW - totalUseWidth;
        // 是否需要换行
        // 剩余宽度 < 文字宽度 + 左右俩边的边距
        BOOL newline = remainWidth < titleTextWidth + horizontalMargin * 2;
        if (newline) {
            line++;
            column = 1;
            totalUseWidth = 0;
        } else {
            column++;
        }

        UILabel *titleLabel = [UILabel new];
        [containerView addSubview:titleLabel];

        // 添加点击事件
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                initWithTarget:self
                        action:@selector(titleClickAction:)];
        [titleLabel addGestureRecognizer:tapGestureRecognizer];
        titleLabel.userInteractionEnabled = YES;

        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.layer.masksToBounds = YES;
        titleLabel.layer.cornerRadius = labelViewHeight / 2;
        titleLabel.layer.borderColor = [UIColor grayColor].CGColor;
        titleLabel.layer.borderWidth = 0.3;
        titleLabel.text = title;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = labelFontSize;
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(titleTextWidth);
            make.height.mas_equalTo(labelViewHeight);
            make.top.mas_equalTo((line - 1) * labelViewHeight + verticalMargin * line);
            if (column == 1) {
                make.left.mas_equalTo(horizontalMargin);
            } else {
                make.left.mas_equalTo(totalUseWidth + horizontalMargin);
            }
        }];
        totalUseWidth += titleTextWidth + horizontalMargin;
        if (i == hotSrarchData.count - 1) {
            [containerView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(titleLabel.mas_bottom).offset(verticalMargin);
            }];
        }
    }
    return containerView;
}

- (void)createMenuView:(UIView *)container topView:(UIView *)topView {

    CGFloat viewWidth = (YKScreenFrameW - kMenuViewMargin * 3) / 2;
    UIImageView *lastMenuItemView = nil;

    for (int a = 0; a < self.guessYouLike.count; a++) {
        YKHomeVideoListDataDataModel *model = self.guessYouLike[a];
        UIImageView *menuItemView = [UIImageView new];
        [container addSubview:menuItemView];
        menuItemView.layer.masksToBounds = YES;
        menuItemView.layer.cornerRadius = 5;
        [menuItemView sd_setImageWithURL:[model.pic toUrl]];
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
                make.left.mas_equalTo(kMenuViewMargin);
            } else {
                if (row == 0) {
                    make.left.mas_equalTo(kMenuViewMargin);
                } else {
                    make.left.mas_equalTo(lastMenuItemView.mas_right).offset(kMenuViewMargin);
                }
            }

            if (line == 0) {
                make.top.mas_equalTo(topView.mas_bottom).offset(kMenuViewMargin);
            } else {
                if (row == 0) {
                    make.top.mas_equalTo(lastMenuItemView.mas_bottom).offset(kMenuViewMargin);
                } else {
                    make.top.mas_equalTo(lastMenuItemView.mas_top);
                }
            }

            make.height.mas_equalTo(YKMoreVideoCellMenuViewHeight);
            make.width.mas_equalTo(viewWidth);
        }];
        lastMenuItemView = menuItemView;

    }

    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastMenuItemView.mas_bottom).offset(kMenuViewMargin);;
    }];
    lastMenuItemView = nil;
}

- (void)pushVideoDetailViewControllerWithVideoId:(NSString *)videoId {
    YKVideoDetailViewController *videoDetailViewController = [[YKVideoDetailViewController alloc] init];
    videoDetailViewController.videoId = videoId;
    [self.navigationController pushViewController:videoDetailViewController animated:YES];
}

// 顶部搜索按钮，搜索关于直播内容，键盘处理
#pragma mark UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string {
    //returns the "new text" of the field
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
// 如果清除了输入框上得文字，隐藏tableview，显示搜索出来的内容
    if (text.length == 0) {
        self.searchVideoList = nil;
        self.mainTableView.hidden = YES;
        [self.mainTableView reloadData];
        [self.view sendSubviewToBack:self.mainTableView];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)aTextfield {
    [aTextfield resignFirstResponder];//关闭键盘
    if (aTextfield.text) {
        [YKApiRequestServer searchVideoWithKeyWord:aTextfield.text
                                           success:^(NSArray <YKSearchListDataVideoList> *videoList) {
                                               if (videoList.count == 0) {
                                                   [YKProgressHDTool reminderWithTitle:@"查无数据"];
                                               } else {
                                                   self.searchVideoList = videoList;
                                                   self.mainTableView.hidden = NO;
                                                   [self.mainTableView reloadData];
                                                   [self.view bringSubviewToFront:self.mainTableView];
                                               }

                                           }
                                           failure:^(NSString *error) {
                                               [YKProgressHDTool reminderWithTitle:error];
                                           }];
    }
    return YES;
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:identifier cacheByIndexPath:indexPath configuration:^(id cell) {

    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YKSearchListDataVideoList *searchListDataVideoList = self.searchVideoList[indexPath.row];
    // 如果是专辑字段不是空，证明这个数据是专辑，所以跳转到专辑详情
    if (searchListDataVideoList.albumId) {
        YKProjectDetailViewController *projectViewController = [[YKProjectDetailViewController alloc] init];
        projectViewController.albumId = searchListDataVideoList.albumId;
        [self.navigationController pushViewController:projectViewController animated:YES];
    } else {
        [self pushWebViewControllerWithURL:searchListDataVideoList.videoDetailUrl];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YKSearchCell *searchCell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    YKSearchListDataVideoList *searchListDataVideoList = self.searchVideoList[indexPath.row];
    searchCell.title = searchListDataVideoList.name;
    return searchCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchVideoList.count;
}

#pragma mark Action

- (void)titleClickAction:(UITapGestureRecognizer *)tapGestureRecognizer {
    UILabel *titleLabel = (UILabel *) tapGestureRecognizer.view;
    self.srarchTextField.text = titleLabel.text;
    [self textFieldShouldReturn:self.srarchTextField];
}
//搜索输入框下面的 猜你喜欢
- (void)menuClickAction:(UITapGestureRecognizer *)tapGestureRecognizer {
    YKHomeVideoListDataDataModel *model = self.guessYouLike[(NSUInteger) (tapGestureRecognizer.view.tag - MENU_VIEW_START_TAG)];
    [self pushWebViewControllerWithURL:model.videoDetailUrl];
}

@end