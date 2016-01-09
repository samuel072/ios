#import <Foundation/Foundation.h>

typedef enum{
    KISexMan,
    KISexWoman
}ISex;

@interface Person : NSObject
{
    @public
    NSString * _userName;
    int _age;
    float _weight;
    ISex _sex;
}

// 声明一个方法
- (void)aboutPerson;

- (NSString *) thisPhone;

- (NSInteger) callPhone:(NSInteger) number :(NSString *) userName;

@end

@implementation Person

- (void)aboutPerson
{
    NSString *userName = @"samuel";
    NSString * userInfo = [NSString stringWithFormat: @"my name is %@", userName];
    NSLog(@"%@", userInfo);
}

- (NSString *)thisPhone
{
    NSString * number = @"13718202649";
    return number;
}

- (NSInteger)callPhone:(NSInteger)number : (NSString *)userName
{
    NSString * str = [NSString stringWithFormat:@"给%@打电话， 电话号码是：%ld", userName, number];
    NSUInteger length = [str length];
    NSLog(@"%@", str);
    return length;
}
@end

int main(int argc, const char * argv[])
{
    Person * person = [Person new];

    person->_userName = @"黄阿能";
    person->_age = 25;
    person->_weight = 108.00;
    person->_sex = KISexMan;
    
//    NSLog(@"my name is = %@", person->_userName);
//    NSLog(@"my age is = %d", person->_age);
//    NSLog(@"my weight is = %f", person->_weight);
//    NSLog(@"my sex is = %d", person->_sex);
//    [person aboutPerson];
//    NSString * phoneNum = [person thisPhone];
//    NSLog(@"我的手机号码是:%@", phoneNum);
    NSInteger length = [person callPhone:13718202649 : @"黄阿能"];
    NSLog(@"%ld", length);
    return 0;
}