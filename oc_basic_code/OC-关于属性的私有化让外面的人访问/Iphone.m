//
//  Iphone.m
//  oc
//
//  Created by 黄阿能 on 11/1/15.
//  Copyright © 2015 黄阿能. All rights reserved.
//

#import "Iphone.h"

@implementation Iphone
-(void)setCup:(int)cup
{
    _cup = cup;
}
- (int)getCup
{
    return _cup;
}

- (void)openFlash:(int)cup
{
    _cup = 4;
    NSLog(@"%d",_cup);
}
@end
