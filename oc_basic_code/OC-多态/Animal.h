//
//  Animal.h
//  oc
//
//  Created by 黄阿能 on 15/11/7.
//  Copyright © 2015年 黄阿能. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Animal : NSObject
{
    int _age;
}

- (void) eat;
- (void) freeAnimal:(Animal *) animal;
- (void) run:(NSString *) userName;
@end
