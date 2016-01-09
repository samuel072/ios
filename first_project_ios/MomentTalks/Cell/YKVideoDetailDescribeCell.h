//
// Created by 杨虎 on 15/8/1.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YKVideoDetailDescribeCellDelegate;

@interface YKVideoDetailDescribeCell : UITableViewCell
@property(nonatomic, copy) NSString *describeString;
@property(nonatomic, weak) id <YKVideoDetailDescribeCellDelegate> delegate;
@end

@protocol YKVideoDetailDescribeCellDelegate
- (void)videoDetailDescribeCellPackDescribe:(BOOL)pack;
@end