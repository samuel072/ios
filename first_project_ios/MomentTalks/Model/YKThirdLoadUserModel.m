//
//  TheThirdLoadUserInfo.m
//  TigerSoCool
//
//  Created by LookMedia-China on 13-11-29.
//  Copyright (c) 2013年 LookMedia-China. All rights reserved.
//3081235073
//

#import "YKThirdLoadUserModel.h"

@implementation YKThirdLoadUserModel
- (id)init {
    if (self = [super init]) {
    }
    return self;
}

- (id)initWithUid:(NSString *)uid
         nickname:(NSString *)nickname
     profileImage:(NSString *)profileImage
          homeUrl:(NSString *)url
           gender:(NSString *)gender
      andLoaction:(NSString *)loaction {

    if (self = [super init]) {
        _userId = uid;
        _nickname = nickname;
        _profileImage = profileImage;
        _homeUrl = url;
        //性别：0 男； 1 女； 2 未知
        switch ([gender integerValue]) {
            case 0:
                _gender = @"男";
                break;
            case 1:
                _gender = @"女";
                break;
            case 2:
                _gender = @"未知";
                break;
            default:
                break;
        }
        _userLocation = loaction;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        self.userId = [coder decodeObjectForKey:@"userId"];
        self.nickname = [coder decodeObjectForKey:@"nickname"];
        self.profileImage = [coder decodeObjectForKey:@"profileImage"];
        self.homeUrl = [coder decodeObjectForKey:@"homeUrl"];
        self.gender = [coder decodeObjectForKey:@"gender"];
        self.loginType = [coder decodeObjectForKey:@"loginType"];
        self.userLocation = [coder decodeObjectForKey:@"userLocation"];
        self.changyanUserId = [coder decodeObjectForKey:@"changyanUserId"];

    }
    return self;
}

#pragma mark- 序列化

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.userId forKey:@"userId"];
    [coder encodeObject:self.nickname forKey:@"nickname"];
    [coder encodeObject:self.profileImage forKey:@"profileImage"];
    [coder encodeObject:self.homeUrl forKey:@"homeUrl"];
    [coder encodeObject:self.gender forKey:@"gender"];
    [coder encodeObject:self.loginType forKey:@"loginType"];
    [coder encodeObject:self.userLocation forKey:@"userLocation"];
    [coder encodeObject:self.changyanUserId forKey:@"changyanUserId"];

}


@end
