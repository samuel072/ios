//
//  main.m
//  OC-关于属性的私有化让外面的人访问
//
//  Created by 黄阿能 on 11/1/15.
//  Copyright © 2015 黄阿能. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Iphone.h"
int main(int argc, const char * argv[]) {
    Iphone * ip = [Iphone new];
    [ip setCup:5];
    int cup = [ip getCup];
    NSLog(@"this cup is = %d", cup);
    [[Iphone new] openFlash:2];
    return 0;
}
