/**
    手动内存管理
 */
#import <Foundation/Foundation.h>
#import "Person.h"
int main(int argc, const char * argv[]) {
    
    Person *p = [Person new];
    
    // 创建对象的时候， 内存管理的初始值是
    NSUInteger i = p.retainCount;
    NSLog(@"init value is %lu", i);
    
//    retainCount+1
    [p retain];
    NSLog(@"retain after value is %lu", p.retainCount);
    // 释放内存， 及时销毁内存空间 release 是retainCount-1
    [p release];
    // p.retainCount =1 是因为这个时候 原本的对象已经被销毁了， 但是不会报错而且还有值并且还是等于1 应该是这个对象新被创建了
    // 该对象被销毁了最好的依据就是 调用了父类的 dealloc方法
    NSLog(@"release value is %lu", p.retainCount);

    return 0;
}
