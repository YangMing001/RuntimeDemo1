//
//  RuntimeVC.m
//  RuntimeDemo1
//
//  Created by YM on 16/3/1.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "RuntimeVC.h"
#import <objc/runtime.h>

@interface RuntimeVC ()<UIWebViewDelegate>
{
    NSString *_currentIndex;
}
@end

@implementation RuntimeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configData];
    [self configUI];
}

/**配置数据*/
- (void)configData{
    unsigned int count ;
    
    //获取属性列表
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        const char *properName = property_getName(propertyList[i]);
        NSLog(@"properName->%s",properName);
    }
    
    //获取方法列表
    Method *methodList = class_copyMethodList([self class], &count);
    for (int i = 0; i < count; i++) {
        Method method = methodList[i];
        NSLog(@"method->%@",NSStringFromSelector(method_getName(method)));
    }
    
    //获取成员变量列表
    Ivar *ivarList = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivarList[i];
        NSLog(@"ivar-> %s",ivar_getName(ivar));
    }
    
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([self class], &count);
    for (int i = 0; i < count; i ++) {
        Protocol *protocol = (protocolList[i]);
        NSLog(@"%s",protocol_getName(protocol));
    }
}

/**配置UI*/
- (void)configUI{
    [self.view setBackgroundColor:[UIColor yellowColor]];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
