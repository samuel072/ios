//
//  StandardUserUtils.m
//  ;;
//
//  Created by YangHu on 14-11-15.
//  Copyright (c) 2014年 CmsTop. All rights reserved.
//

#import "UserStandardTool.h"

@implementation UserStandardTool

+ (void)savaEntityForKey:(id)entity key:(NSString *)key {
    [self clearForKey:key];
    NSData *udObject = [NSKeyedArchiver archivedDataWithRootObject:entity];
    [self savaObjectForKey:udObject key:key];
}

+ (void)savaObjectForKey:(id)value key:(NSString *)key {
    [self clearForKey:key];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    //    NSData *udObject = [NSKeyedArchiver archivedDataWithRootObject:entity];
    [userDefault setObject:value forKey:key];
    //UserDefaults不是立即写入，而是根据时间戳定时的把缓存中的数据写入本地磁盘。
    //通过调用synchornize方法强制写入。
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)clearForKey:(NSString *)key {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)getObjForKey:(NSString *)key {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault objectForKey:key];
}

@end
