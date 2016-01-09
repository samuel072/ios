//
// Created by 杨虎 on 15/8/8.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKCollectionViewController.h"
#import "YKCollectionCell.h"

const CGFloat kBottomMenuViewHeight = 50;
static const NSString *identifier = @"YKCollectionCell";

@interface YKCollectionViewController () <YKCollectionCellDelegate>
/** 全选，删除布局 */
@property(nonatomic, strong) UIView *bottomMenuView;
/** 当前选中的收藏 */
@property(nonatomic, strong) NSMutableArray <YKCollectionListData> *selectCollectionArray;
/** 收藏列表 */
@property(nonatomic, strong) NSMutableArray <YKCollectionListData> *collectionArray;
/** 右上角编辑按钮 */
@property(nonatomic, strong) UIButton *editorButton;
@end

@implementation YKCollectionViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    self.selectCollectionArray = (NSMutableArray <YKCollectionListData> *) @[].mutableCopy;
    [self addEditorButton];
    [self requestListData];
}

- (void)requestListData {
    [YKApiRequestServer requestCollectionListWithSuccess:^(YKCollectionListModel *collectionListModel) {
                NSLog(@"collectionListModel = %@", collectionListModel);
                self.collectionArray = [collectionListModel.data mutableCopy];
                if (self.collectionArray.count == 0) {
                    [YKProgressHDTool reminderWithTitle:@"暂无收藏"];
                } else {
                    [self.mainTableView reloadData];
                }
            }

                                                 failure:^(NSString *error) {
                                                     [YKProgressHDTool reminderWithTitle:error];
                                                 }];
}

/**
* 添加右上角编辑按钮
*/
- (void)addEditorButton {
    self.editorButton = [self.customNavigation creatRightButtonWithTitle:@"编辑" block:^{
        self.editor = !self.editor;
        if (self.editor) {
            [self addBottomMenuView];
            [self.editorButton setTitle:@"完成" forState:UIControlStateNormal];
        } else {
            self.selectAll = NO;
            [self.editorButton setTitle:@"编辑" forState:UIControlStateNormal];
            [self removeBottomMenuView];
        }
        [self.mainTableView reloadData];
    }];
}

/**
* 添加底部菜单布局
*/
- (void)addBottomMenuView {
    [self.mainTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64);
        make.right.with.left.mas_equalTo(0);
        make.bottom.mas_equalTo(kBottomMenuViewHeight);
    }];
    self.bottomMenuView = [UIView new];
    [self.view addSubview:self.bottomMenuView];
    self.bottomMenuView.backgroundColor = [UIColor whiteColor];
    [self.bottomMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.with.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(kBottomMenuViewHeight);
    }];
    CGFloat buttonMargin = 10;

    UIButton *selectButton = [self createMenuButtonWithTitle:@"全选" color:[UIColor blackColor]];
    [self.bottomMenuView addSubview:selectButton];
    [selectButton handleControlWithBlock:^{
        self.selectAll = !self.selectAll;
        if (self.selectAll) {
            [self.selectCollectionArray removeAllObjects];
            [self.selectCollectionArray addObjectsFromArray:self.collectionArray];
            [selectButton setTitle:@"取消全选" forState:UIControlStateNormal];
        } else {
            [self.selectCollectionArray removeAllObjects];
            [selectButton setTitle:@"全选" forState:UIControlStateNormal];
        }
        [self.mainTableView reloadData];
    }];
    [selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bottomMenuView);
        make.width.mas_equalTo((YKScreenFrameW - buttonMargin * 3) / 2);
        make.height.mas_equalTo(35);
        make.left.mas_equalTo(buttonMargin);
    }];
    UIButton *deleteButton = [self createMenuButtonWithTitle:@"删除" color:[UIColor redColor]];
    [self.bottomMenuView addSubview:deleteButton];
    [deleteButton addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    [deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(selectButton);
        make.width.mas_equalTo(selectButton);
        make.height.mas_equalTo(selectButton);
        make.left.mas_equalTo(selectButton.mas_right).offset(buttonMargin);
    }];
}

- (void)deleteAction {
    for (YKCollectionListData *data in self.selectCollectionArray) {
        [YKApiRequestServer removeCollectionWithVideoId:data.videoId success:^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:YKDeleteCollectionNotificationKey object:data.videoId];
                    [self.collectionArray removeObject:data];
                    [self.mainTableView reloadData];
                }
                                                failure:^(NSString *error) {
                                                    [YKProgressHDTool reminderWithTitle:error];
                                                }];
    }
}

- (UIButton *)createMenuButtonWithTitle:(NSString *)title color:(UIColor *)color {
    UIButton *button = [UIButton new];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 5;
    button.layer.borderWidth = 1;
    button.layer.borderColor = color.CGColor;
    return button;
}

/**
* 移除底部菜单布局
*/
- (void)removeBottomMenuView {
    [self.mainTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64);
        make.right.with.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    [self.bottomMenuView removeFromSuperview];
    _bottomMenuView = nil;
}

#pragma mark YKCollectionCellDelegate

- (void)cleckCollectionCellWithSelect:(BOOL)select collectListData:(YKCollectionListData *)collectListData {
    if (select) {
        [self.selectCollectionArray addObject:collectListData];
    } else {
        [self.selectCollectionArray removeObject:collectListData];
    }
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YKCollectionCell *collectionCell = (YKCollectionCell *) [tableView cellForRowAtIndexPath:indexPath];
    [collectionCell delectAcion];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YKCollectionCell *collectionCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!collectionCell) {
        collectionCell = [[YKCollectionCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                                 reuseIdentifier:identifier];
    }
    collectionCell.delegate = self;
    collectionCell.editor = self.editor;
    collectionCell.select = self.selectAll;
    YKCollectionListData *data = (YKCollectionListData *) self.collectionArray[indexPath.row];
    collectionCell.collectListData = data;
    return collectionCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.collectionArray.count;
}

@end