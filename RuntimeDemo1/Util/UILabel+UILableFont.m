//
//  UILabel+UILableFont.m
//  RuntimeDemo1
//
//  Created by YM on 16/3/1.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "UILabel+UILableFont.h"

#import <objc/runtime.h>

@implementation UILabel (UILableFont)

+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = [UILabel class];
        SEL original = @selector(willMoveToSuperview:);
        SEL swizzled = @selector(myWillMoveToSuperview:);
        
        Method originalMethod   = class_getInstanceMethod(cls, original);
        Method swizzledMethod   = class_getInstanceMethod(cls, swizzled);
        
        //添加自定义的方法到类里面
        BOOL didAddMethod = class_addMethod(cls, original, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));

        /**
         swizzled 是存在于 UILabel 的方法列表中
         original 是存在于 UILabel 的父类方法列表中，不存在在UILabel中。 
         所以class_addMethod 是给UILabel添加一个选择器，相当于重写了父类的方法。
         重写的方法名，追加另外一个函数的实现。
         */

        if (didAddMethod) {
            //方法已经添加成功  替换掉原来的方法实现
            class_replaceMethod(cls, swizzled, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }else{
            //没有添加成功说明本类方法列表中已经有了实现    交换两个函数的实现
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)myWillMoveToSuperview:(nullable UIView *)newSuperview{
    
    [self myWillMoveToSuperview:newSuperview];
    if (newSuperview) {
        self.backgroundColor = [UIColor blackColor];
        self.textColor       = [UIColor whiteColor];
        [self setFont:[UIFont systemFontOfSize:21]];
    }
}

@end
