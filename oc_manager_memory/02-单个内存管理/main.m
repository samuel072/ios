//
//  main.m
//  02-单个内存管理
//
//  Created by 黄阿能 on 12/8/15.
//  Copyright © 2015 黄阿能. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
int main(int argc, const char * argv[]) {
    Person * persion = [Person new];
    persion.age = 200;
    NSLog(@"%@", persion);
    
//  这个时候 其实对象Person已经被销毁了。 但是xCode不会时时检测 才会出现有的时候是正常的 有的时候会出现 EXC_BAD_ACCESS： 访问一个不存在的内存空间
    [persion release];
//  这个时间段的对象指针 被称之为野指针
    persion = nil;
    persion.age = 2;
    NSLog(@"%@", persion);
//  避免野指针的方案  使其成为一个nil 对象 [nil release] 就是像在release 使用后 将对象指针指向nil对象 

    return 0;
}
