//
// Created by 杨虎 on 15/8/14.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YKVideoDetailAppointmentCellDelegate;

@interface YKVideoDetailAppointmentCell : UITableViewCell
@property(nonatomic, weak) id <YKVideoDetailAppointmentCellDelegate> delegate;
@end

@protocol YKVideoDetailAppointmentCellDelegate
- (void)videoDetailAppointmentCellApplyAcion;

- (void)videoDetailAppointmentCellAppointmentAcion;
@end