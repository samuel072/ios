//
//  YKTuneListModel.h
//  MomentTalks
//
//  Created by 123 on 15/8/27.
//  Copyright (c) 2015年 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKBaseRequsetListDataModel.h"
#import "YKTuneListData.h"


@interface YKTuneListModel : YKBaseRequsetDataModel
@property (nonatomic, strong) NSArray <YKTuneListData,Optional> *data;


@end


