//
//  ViewController.m
//  RuntimeDemo1
//
//  Created by YM on 16/3/1.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

#pragma mark -Calc
/***************Calc ********************************/
@interface Calc : NSObject
{
    CGFloat value;
}

- (void)add:(NSNumber *)val;
- (instancetype)initWithVal:(CGFloat)val;
@end

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
/*************** END  ********************************/

#pragma mark -ViewController

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configData];
    [self configUI];
}

/**配置数据*/
- (void)configData{
    Calc *cl = [[Calc alloc] initWithVal:10];
    [cl performSelector:@selector(add:) withObject:@1000];
    [cl performSelector:@selector(minus:) withObject:@101];
    NSString *str = [cl performSelector:@selector(uppercaseString)];
    NSLog(@"str = %@",str);
 }

/**配置UI*/
- (void)configUI{
    
    UILabel *l = [UILabel new];
    l.frame = CGRectMake(90, 90, 40, 20);
    l.backgroundColor = [UIColor redColor];
    [self.view addSubview:l];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
