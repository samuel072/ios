#import "Animal.h"

@implementation Animal

- (void)eat
{
    NSLog(@"动物都是要吃饭的！");
}

- (void)freeAnimal:(Animal *)animal
{
    NSLog(@"喂养的动物是%@", animal);
}

- (void)run:(NSString *)userName
{
    NSLog(@"THIS ANIMAL IS NOT CANJI %@", userName);
}
@end
