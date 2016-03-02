//
//  GirlModel.h
//  RuntimeDemo1
//
//  Created by YM on 16/3/2.
//  Copyright © 2016年 YM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GirlModel : NSObject

@property (nonatomic,copy) NSString *girl0;
@property (nonatomic,copy) NSString *girl1;
@property (nonatomic,copy) NSString *girl2;
@property (nonatomic,copy) NSString *girl3;
@property (nonatomic,copy) NSString *girl4;
@property (nonatomic,copy) NSString *girl5;
@property (nonatomic,copy) NSString *girl6;
@property (nonatomic,copy) NSString *girl7;
@property (nonatomic,copy) NSString *girl8;
@property (nonatomic,copy) NSString *girl9;

+ (instancetype)modelWithDictionary:(NSDictionary *)data;

- (instancetype)initWithDictionary: (NSDictionary *)data;

- (void)displayCurrentModelProperty;


@end
