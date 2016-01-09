//
//  AliOSS.h
//  zhengzai.tv
//
//  Created by ZZ-SC on 15/4/4.
//  Copyright (c) 2015年 zhengzai.tv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OSSClient.h"
#import "OSSTool.h"
#import "OSSData.h"
#import "Singleton.h"

@interface AliOSS : NSObject

AS_SINGLETON

+ (OSSBucket *)picBucket;
+ (void)uploadImage:(UIImage *)image usingCallBack:(void (^)(BOOL isSuccess, NSString *picUrl, NSError *error))uploadCallback withProgressCallback:(void (^)(float pregress))progressCallback;

@end
