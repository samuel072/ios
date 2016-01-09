//
// Created by 杨虎 on 15/7/29.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YKRankChangeHeadViewDelegate;

@interface YKRankChangeHeadView : UIView
@property(nonatomic, weak) id <YKRankChangeHeadViewDelegate> delegate;
@end

@protocol YKRankChangeHeadViewDelegate
- (void)dayRankItemViewClickAcion;

- (void)monthRankItemViewClickAcion;
@end