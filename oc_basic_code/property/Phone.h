//
//  Phone.h
//  oc
//
//  Created by 黄阿能 on 15/11/11.
//  Copyright © 2015年 黄阿能. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Phone : NSObject
    @property NSString * _userName;
    @property int _age;
    @property int _sex;
    @property float _height;

#pragma 根据名称获取手机的全部信息
- (void) getPhoneByName: (NSString *) name;
- (void) getPhoneByHight:(int)height;
@end
