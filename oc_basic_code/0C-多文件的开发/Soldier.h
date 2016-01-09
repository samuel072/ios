//
//  Soldier.h
//  oc
//
//  Created by 黄阿能 on 10/31/15.
//  Copyright © 2015 黄阿能. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma 士兵的声明类
@interface Soldier : NSObject
{
    @public
    NSString * _userName;
    int _level;
    int _life;
}

- (void) introduction: (NSString *) name;
@end
