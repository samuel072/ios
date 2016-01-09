//
//  main.m
//  OC-函数和对象
//
//  Created by 黄阿能 on 10/29/15.
//  Copyright © 2015 黄阿能. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject
{
    @public
    int _wheels;
    int _speed;
}

-(void) run;
@end

@implementation Car
- (void)run
{
    NSLog(@"速度是%d, 轮子是%d", _speed, _wheels);
}

void test1(int s, int w)
{
    s = 100;
    w = 1;
}
void test2 (Car * c)
{
    c->_wheels = 2;
    c->_speed = 200;
}

void test3(Car * c3)
{
    Car * cp = [Car new];
    cp->_wheels = 3;
    cp->_speed = 300;
    
    c3 = cp;
    NSLog(@"CP-->WHEELS %d", c3->_wheels);
    //cp->_speed = 3000;
    //cp->_wheels = 30;
}
@end
int main(int argc, const char * argv[]) {
    Car * c = [Car new];
    c->_wheels = 100;
    c->_speed = 1000;
//    test1(c->_wheels, c->_speed);
//    test2(c);
    test3(c);
    [c run];

    return 0;
}
