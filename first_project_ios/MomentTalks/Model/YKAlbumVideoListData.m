//
// Created by 杨虎 on 15/8/6.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKAlbumVideoListData.h"


@implementation YKAlbumVideoListData {

}
- (NSString *)getDurationTime {
    return [self calculateTime:self.duration];
}

- (NSString *)calculateTime:(NSString *)duration {
    int a = [duration intValue];
    long hour = a / 3600;
    long minute = a % 3600 / 60;
    long second = a % 60;
    if (hour > 0) {
        return [NSString stringWithFormat:@"%02ld小时%02ld分钟%02ld秒", hour, minute, second];
    }
    return [NSString stringWithFormat:@"%02ld分钟%02ld秒", minute, second];;
}
@end