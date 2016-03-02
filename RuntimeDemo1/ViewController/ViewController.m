//
//  ViewController.m
//  RuntimeDemo1
//
//  Created by YM on 16/3/1.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "ViewController.h"
#import "RuntimeVC.h"
#import "UILabel+runtimeAssociated.h"
#import "ThirdVC.h"
#import "Calc.h"
#import "Calc+minus.h"
#import <objc/runtime.h>

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
    l.tjType = @"sdsd";
    [self.view addSubview:l];
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.frame = CGRectMake(90, 190, 140, 20);
    btn.backgroundColor = [UIColor whiteColor];
    [btn setTitle:@"ThirdVC" forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(jumpToThird:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    
    UIButton *btn1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn1.frame = CGRectMake(90, 290, 140, 20);
    btn1.backgroundColor = [UIColor whiteColor];
    [btn1 setTitle:@"RuntimeVC" forState:(UIControlStateNormal)];
    [btn1 addTarget:self action:@selector(jumpToRuntimeVC:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn1];
}

- (void)jumpToThird:(id)sender{
    ThirdVC *vc = [ThirdVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)jumpToRuntimeVC:(id)sender{
    RuntimeVC *vc = [RuntimeVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
