//
//  SanXingPhone.m
//  oc
//
//  Created by 黄阿能 on 15/11/4.
//  Copyright © 2015年 黄阿能. All rights reserved.
//

#import "SanXingPhone.h"

@implementation SanXingPhone
-(void)openFlash:(Boolean)isFalg
{
    NSLog(@"聚焦");
//    if(isFalg){
//        NSLog(@"子类的的开启闪光灯");
//    }else{
//        NSLog(@"子类的的关闭闪光灯");
//    }
    
    [super openFlash:isFalg];

}
@end
