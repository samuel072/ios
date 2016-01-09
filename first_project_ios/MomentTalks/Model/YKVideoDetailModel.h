//
//  YKVideoDetailModel.h
//  MomentTalks
//
//  Created by 123 on 15/8/21.
//  Copyright (c) 2015年 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKBaseRequsetListDataModel.h"
#import "YKVideoDetailData.h"

@interface YKVideoDetailModel : YKBaseRequsetListDataModel
@property(nonatomic, strong) YKVideoDetailData *data;
@end
