//
//  Phone.m
//  oc
//
//  Created by 黄阿能 on 15/11/4.
//  Copyright © 2015年 黄阿能. All rights reserved.
//

#import "Phone.h"

@implementation Phone
- (void)openFlash:(Boolean)isFalg
{
    if (isFalg == true) {
        NSLog(@"open super flash");
    }else{
        NSLog(@"close super flash");
    }
}
@end
