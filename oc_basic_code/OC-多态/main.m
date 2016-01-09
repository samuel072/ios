//
//  main.m
//  OC-多态
//   某一种一类事物的多种形态
//   没有继承就没有多态

#import <Foundation/Foundation.h>
#import "Dog.h"
#import "Cat.h"
int main(int argc, const char * argv[]) {
   
    Animal *cat = [Cat new];
    [cat eat];
    Animal *dog = [Dog new];
    [dog eat];
//    [cat freeAnimal: cat];
    [cat run:@"hahe da~"];
    return 0;
}
