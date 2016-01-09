#import <Foundation/Foundation.h>
#import "Phone.h"
int main(int argc, const char * argv[]) {
    NSString *name = @"samuel072samuel";
    [[Phone new] getPhoneByName: name];
    [[Phone new] getPhoneByHight: 25];
    return 0;
}
