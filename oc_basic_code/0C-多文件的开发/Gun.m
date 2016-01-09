//
//  Gun.m
//  oc
//
//  Created by 黄阿能 on 10/31/15.
//  Copyright © 2015 黄阿能. All rights reserved.
//

#import "Gun.h"

@implementation Gun
- (void)setName:(NSString *)name
{
    _name = name;
    NSLog(@"this gun name is %@", _name);
}
@end
