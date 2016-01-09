//
//  Phone.h
//  oc
//
//  Created by 黄阿能 on 15/11/4.
//  Copyright © 2015年 黄阿能. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    KIColorWhite,
    KIColorBlack,
    KIColorgreep
}IColor;
@interface Phone : NSObject
{
    NSString *_name;
    int _cup;
    int size;
    IColor _color;
}

- (void) openFlash:(Boolean) isFalg;
@end
