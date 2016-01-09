//
//  main.m
//  0C-继承
//  OC不能支持多继承  但是支持多层继承

//  super 其实是为了增强子类中的方法， 在重写父类方法的时候 再一次强制的调用父类方法
//  Created by 黄阿能 on 15/11/4.
//  Copyright © 2015年 黄阿能. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SanXingPhone.h"
int main(int argc, const char * argv[]) {
    // 调用子类自己本身的方法
//    [[SanXingPhone new] openFlash:true];
    [[SanXingPhone new] openFlash:false];
    return 0;
}
