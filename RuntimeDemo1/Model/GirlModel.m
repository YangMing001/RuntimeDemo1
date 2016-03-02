//
//  GirlModel.m
//  RuntimeDemo1
//
//  Created by YM on 16/3/2.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "GirlModel.h"

#import <objc/runtime.h>

@implementation GirlModel

+ (instancetype)modelWithDictionary:(NSDictionary *)data{
    return [[GirlModel alloc] initWithDictionary:data];
}

- (instancetype)initWithDictionary: (NSDictionary *)data{
    if (self = [super init]) {
        [self assginToPropertyWithDictionary:data];
    }
    return self;
}


- (NSArray *)allPropertyNames{
    unsigned int count ;
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    NSMutableArray *propertyArray = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        objc_property_t property    = propertyList[i];
        NSString *propertyName      = [NSString stringWithFormat:@"%s",property_getName(property)];
        [propertyArray addObject:propertyName];
    }
    free(propertyList);
    return propertyArray;
}

/**创建 setter 方法 返回setter方法*/
- (SEL)createSetterWithPropertyName:(NSString *)propertyName{
    //首字母大写
    NSString *tempPropertyName  = propertyName.capitalizedString;
    tempPropertyName            = [NSString stringWithFormat:@"set%@:",tempPropertyName];
    return  NSSelectorFromString(tempPropertyName);
}

/**创建 Getter 方法 返回Getter方法*/
- (SEL)createGetterWithPropertyName:(NSString *)propertyName{
    return NSSelectorFromString(propertyName);
}

- (void)assginToPropertyWithDictionary:(NSDictionary *)data{
    NSDictionary *tempData = data;
    if (tempData == nil) {
        return;
    }
    
    NSArray *keyArray = [tempData allKeys];
    [keyArray enumerateObjectsUsingBlock:^(NSString * _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
        SEL setSel = [self createSetterWithPropertyName:key];
        if ([self respondsToSelector:setSel]) {
            NSString *value = tempData[key];
            [self performSelectorOnMainThread:setSel withObject:value waitUntilDone:[NSThread isMainThread]];
        }
    }];
}

- (void)displayCurrentModelProperty{
    NSArray *array = [self allPropertyNames];
    NSMutableString *resultString = [[NSMutableString alloc] init];
    
    __weak typeof(self) weakSelf = self;
    [array enumerateObjectsUsingBlock:^(NSString * _Nonnull propertyName, NSUInteger idx, BOOL * _Nonnull stop) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        SEL getSel = [strongSelf createGetterWithPropertyName:propertyName];
        if ([self respondsToSelector:getSel]) {
            NSMethodSignature *signature = [strongSelf methodSignatureForSelector:getSel];
            
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
            
            [invocation setTarget:strongSelf];
            [invocation setSelector:getSel];
            
            NSObject *__unsafe_unretained returnValue = nil;
            [invocation invoke];
            [invocation getReturnValue:&returnValue];
            [resultString appendFormat:@"%@\n",returnValue];
        }
    }];
    NSLog(@"%@",resultString);
}

- (NSString *)description{
    /**利用runtime打印所有的属性名称和值*/
    unsigned int count = 0 ;
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    NSString *descriptionString = [NSString string];
    for (int i = 0; i < count; i ++) {
        objc_property_t property = propertyList[i];
        NSString *propertyName = [NSString stringWithUTF8String: property_getName(property)];
        
        NSString *propertyValue = [self valueForKey:propertyName];
        
        NSString *keyValueDic = [NSString stringWithFormat:@" %@--%@, ",propertyName,propertyValue];
        
        descriptionString = [descriptionString stringByAppendingString:keyValueDic];
    }
    free(propertyList);
    return descriptionString;
}


@end
