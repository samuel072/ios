#import <Foundation/Foundation.h>

// 枚举类型
typedef enum
{
//  K+枚举名称+含义
    KIColorBlack, // 黑色
    KIColorWhite, // 白色
    KIColorAsh
}IColor;

@interface Iphone : NSObject
{
    @public
    NSString * _name; // 手机名称
    int _cpu; // 手机内存大小
    float _size; // 手机频幕大小
    IColor _color; // 手机颜色
}

@end

@implementation Iphone
{
    
}
@end

//int main(int argc, const char * argv[])
//{
//    // 创建一个对象
//    Iphone * phone = [Iphone new];
//    phone->_name = @"Iphone6S";
//    phone->_cpu = 20;
//    phone->_size = 5.5f;
//    phone->_color = KIColorBlack;
//    
//    NSLog(@"这部手机的名称是: %@，CPU的大小是: %d， 屏幕大小是:%f，颜色是:%d", phone->_name, phone->_cpu, phone->_size, phone->_color);
//    return 0;
//    
//}
