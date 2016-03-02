//
//  Calc.h
//  RuntimeDemo1
//
//  Created by YM on 16/3/2.
//  Copyright © 2016年 YM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Calc : NSObject
{
    CGFloat value;
}

- (void)add:(NSNumber *)val;
- (instancetype)initWithVal:(CGFloat)val;
@end
