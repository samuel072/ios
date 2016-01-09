//
//  Person.m
//  OC-内存手动管理
//
//  Created by 黄阿能 on 12/8/15.
//  Copyright © 2015 黄阿能. All rights reserved.
//

#import "Person.h"

@implementation Person
-(void)dealloc
{
    [super dealloc];
    NSLog(@"Person类被销毁了");
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"this is age value %d", _age];
}
@end
