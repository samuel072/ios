//
// Created by 杨虎 on 15/8/11.
// Copyright (c) 2015 com.yikeyanjiang.tiger. All rights reserved.
//

#import "YKCheckVersionModel.h"
#import "BlockUIAlertView.h"


@implementation YKCheckVersionModel
- (void)checkVersion {
    int server_appversion = [[self.data.version stringByReplacingOccurrencesOfString:@"." withString:@""] intValue];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *app_Version = infoDictionary[@"CFBundleShortVersionString"];
    int local_version = [[app_Version stringByReplacingOccurrencesOfString:@"." withString:@""] intValue];
    if (local_version < server_appversion) {
        BlockUIAlertView *alert = [[BlockUIAlertView alloc] initWithVersionUpdate:@"版本升级提示"
                                                                          message:self.data.message
                                                                cancelButtonTitle:@"暂不升级"
                                                                      clickButton:^(NSInteger index) {
                                                                          if (index == 1) {//升级
                                                                              [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.data.url]];
                                                                          }
                                                                      }
                                                                otherButtonTitles:@"升级"];
        [alert show];
    }
}
@end