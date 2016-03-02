//
//  Calc+minus.m
//  RuntimeDemo1
//
//  Created by YM on 16/3/2.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "Calc+minus.h"
#import <objc/runtime.h>
@implementation Calc (minus)
//c语言的函数  Obj-C的方法（method）就是一个至少需要两个参数（self，_cmd）的C函数
//Since the function must take at least two arguments—self and _cmd, the second and third characters must be “@:” (the first character is the return type).
void minus(id self,SEL _cmd,NSNumber *val){
    NSLog(@"%0.2f",[[self valueForKey:@"value"] floatValue] - [val floatValue]);
}


//第一步      没有方法 添加方法实现
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    if (sel == @selector(minus:)) {
        //v@:f     返回值为void  @: the second and third characters must be “@:”
        class_addMethod([self class], sel, (IMP) minus, "v@:f");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

//第二步   指向新的方法接受者
- (id)forwardingTargetForSelector:(SEL)aSelector{
    if (aSelector == @selector(uppercaseString)) {
        return @"hello world";
    }
    return [super forwardingTargetForSelector:aSelector];
}



@end
