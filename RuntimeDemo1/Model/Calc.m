//
//  Calc.m
//  RuntimeDemo1
//
//  Created by YM on 16/3/2.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "Calc.h"

@implementation Calc
- (instancetype)initWithVal:(CGFloat)val{
    if (self = [super init]) {
        value = val;
    }
    return self;
}

- (void)add:(NSNumber *)val{
    NSLog(@"%0.2f",value + [val floatValue]);
}

@end
