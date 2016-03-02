//
//  UILabel+runtimeAssociated.m
//  RuntimeDemo1
//
//  Created by YM on 16/3/1.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "UILabel+runtimeAssociated.h"
#import <objc/runtime.h>

static const char tjTypeKey ; //tjTypeKey作为一个唯一标示 对于set和get方法。

@implementation UILabel (runtimeAssociated)

- (NSString *)tjType{
    return objc_getAssociatedObject(self, &tjTypeKey);
}

- (void)setTjType:(NSString *)tjType{
    objc_setAssociatedObject(self, &tjTypeKey, tjType, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end
