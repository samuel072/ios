//
// Created by 杨虎 on 15/8/11.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKReservationViewController.h"
#import "YKCollectionCell.h"

static const NSString *identifier = @"YKReservationCell";

@interface YKReservationViewController () <YKReservationCellDelegate>
@property(nonatomic, strong) NSMutableArray <YKReservationListData> *reservationArray;
@property(nonatomic, strong) NSMutableArray <YKReservationListData> *selectReservationArray;

@end

@implementation YKReservationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的预约";
    self.selectReservationArray = (NSMutableArray <YKReservationListData> *) @[].mutableCopy;
}

- (void)requestListData {
    [YKApiRequestServer requestReservationListWithSuccess:^(YKReservationListModel *reservationListModel) {
                self.reservationArray = (NSMutableArray <YKReservationListData> *) reservationListModel.data;
                if (_reservationArray.count == 0) {
                    [YKProgressHDTool reminderWithTitle:@"暂无预约"];
                } else {
                    [self.mainTableView reloadData];
                }

            }
                                                  failure:^(NSString *error) {
                                                      [YKProgressHDTool reminderWithTitle:error];
                                                  }];
}

- (void)deleteAction {
    for (YKReservationListData *data in self.selectReservationArray) {
        [YKApiRequestServer removeReservationWithAlbumId:data.albumId success:^{
                    [self.reservationArray removeObject:data];
                    [self.mainTableView reloadData];
                }
                                                 failure:^(NSString *error) {

                                                 }];
    }
}

- (void)cleckReservationCellWithSelect:(BOOL)select reservationListData:(YKReservationListData *)reservationListData {
    if (select) {
        [self.selectReservationArray addObject:reservationListData];
    } else {
        [self.selectReservationArray removeObject:reservationListData];
    }
}

#pragma mark UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YKCollectionCell *collectionCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!collectionCell) {
        collectionCell = [[YKCollectionCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                                 reuseIdentifier:identifier];
    }
    collectionCell.reservationDelegate = self;
    collectionCell.editor = self.editor;
    collectionCell.select = self.selectAll;
    YKReservationListData *data = (YKReservationListData *) self.reservationArray[(NSUInteger) indexPath.row];
    collectionCell.reservationListData = data;
    return collectionCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.reservationArray.count;
}

@end