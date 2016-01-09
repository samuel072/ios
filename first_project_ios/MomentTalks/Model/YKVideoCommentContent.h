//
// Created by 杨虎 on 15/8/3.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@protocol YKVideoCommentContent
@end

@interface YKVideoCommentContent : JSONModel
@property(nonatomic, copy) NSString <Optional> *content;
@property(nonatomic, copy) NSString <Optional> *type;
@end