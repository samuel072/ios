//
//  TheThirdLoadUserInfo.h
//  TigerSoCool
//
//  Created by LookMedia-China on 13-11-29.
//  Copyright (c) 2013年 LookMedia-China. All rights reserved.
//

#import <Foundation/Foundation.h>

// 第三方登录用户信息
@interface YKThirdLoadUserModel : NSObject
@property(nonatomic, copy) NSString *nickname; // 昵称
@property(nonatomic, copy) NSString *profileImage; // 头像地址
@property(nonatomic, copy) NSString *userId;
@property(nonatomic, copy) NSString *gender;
//性别
@property(nonatomic, copy) NSString *userLocation;//用户地址


/**登录平台*/
@property(nonatomic, copy) NSString *loginType;
@property(nonatomic, copy) NSString *homeUrl;
//个人主页地址
@property(nonatomic, copy) NSString *changyanUserId;

/**
*  初始化第三方登录信息
*
*  @param uid          用户标示id
*  @param nickname     用户昵称
*  @param profileImage 头像地址
*  @param url          用户主页地址
*  @param gender       性别
*  @param loaction     地理位置
*
*  @return
*/
- (id)initWithUid:(NSString *)uid
         nickname:(NSString *)nickname
     profileImage:(NSString *)profileImage
          homeUrl:(NSString *)url
           gender:(NSString *)gender
      andLoaction:(NSString *)loaction;
@end
