//
//  main.m
//  oc-第二个
//
//  Created by 黄阿能 on 10/29/15.
//  Copyright © 2015 黄阿能. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
{
    @public
    int _age;
    float _weight;
}
// 吃
- (NSString *) eat:(NSString *) food;
// 走
- (int) run;
@end

@implementation Person

-(NSString *)eat:(NSString *)food
{
    _weight = 20;
    NSString * me = [NSString stringWithFormat:@"我今天吃了%@, 但是瘦了%.2f", food, _weight];
    return me;
}

- (int)run
{
    NSLog(@"我今天走了蛮长的一段路！");
    return 1;
}


@end
int main(int argc, const char * argv[]) {
    Person * p = [Person new];
    NSString * message = [p eat: @"土豆"];
    NSLog(@"eat function 的执行 %@", message);
    int result = [p run];
    if(result == 1){
        NSLog(@"执行了 person类的run function");
    }else{
        NSLog(@"没有执行了 person类的run function");
    }
    return 0;
}
