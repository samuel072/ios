//
//  Iphone.h
//  oc
//
//  Created by 黄阿能 on 11/1/15.
//  Copyright © 2015 黄阿能. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Iphone : NSObject
{
    int _cup;
}
- (void)setCup:(int) cup;
- (int)getCup;

- (void) openFlash:(int) cup;
@end
