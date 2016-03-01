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
        if (didAddMethod) {
            //方法已经添加成功  替换掉原来的方法实现
            class_replaceMethod(cls, swizzled, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }else{
            //没有添加成功    改变两个函数的实现
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)myWillMoveToSuperview:(nullable UIView *)newSuperview{
    
    [self myWillMoveToSuperview:newSuperview];
    if (newSuperview) {
        self.backgroundColor = [UIColor yellowColor];
        [self setFont:[UIFont systemFontOfSize:13]];
    }
}

@end
