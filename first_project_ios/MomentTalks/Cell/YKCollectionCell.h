//
// Created by 杨虎 on 15/8/8.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YKReservationCellDelegate;
@protocol YKCollectionCellDelegate;
@class YKCollectionListData;
@class YKReservationListData;

@interface YKCollectionCell : UITableViewCell
/** 标题 */
@property(nonatomic, copy) NSString *title;
/** 编辑模式（显示选择删除按钮）*/
@property(nonatomic, assign) BOOL editor;
/** 选中 */
@property(nonatomic, assign) BOOL select;
@property(nonatomic, strong) YKCollectionListData *collectListData;
@property(nonatomic, strong) YKReservationListData *reservationListData;
@property(nonatomic, weak) id <YKCollectionCellDelegate> delegate;
@property(nonatomic, weak) id <YKReservationCellDelegate> reservationDelegate;


/**
* 点击事件
*/
- (void)delectAcion;
@end

@protocol YKCollectionCellDelegate
- (void)cleckCollectionCellWithSelect:(BOOL)select collectListData:(YKCollectionListData *)collectListData;
@end

@protocol YKReservationCellDelegate
- (void)cleckReservationCellWithSelect:(BOOL)select reservationListData:(YKReservationListData *)reservationListData;
@end