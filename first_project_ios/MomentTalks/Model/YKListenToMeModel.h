//
//  YKListenToMeModel.h
//  MomentTalks
//
//  Created by YangHu on 15/9/11.
//  Copyright (c) 2015年 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKBaseRequsetDataModel.h"
#import "YKListenToMeData.h"
@interface YKListenToMeModel : YKBaseRequsetDataModel
@property (nonatomic,strong) NSArray<YKListenToMeData> *data;
@end
