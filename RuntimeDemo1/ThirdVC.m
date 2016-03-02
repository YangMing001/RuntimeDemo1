//
//  ThirdVC.m
//  RuntimeDemo1
//
//  Created by YM on 16/3/2.
//  Copyright © 2016年 YM. All rights reserved.
//

#import "ThirdVC.h"

#import "GirlModel.h"

@interface ThirdVC ()

@end

@implementation ThirdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configData];
    [self configUI];
}

/**配置数据*/
- (void)configData{
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    for (NSInteger i = 0; i < 10; i++) {
        NSString *key = [NSString stringWithFormat:@"girl%@",@(i)];
        NSString *value = [NSString stringWithFormat:@"我是第%@个女孩",@(i)];
        [dataDic setValue:value forKey:key];
    }
    NSLog(@"%@",dataDic);
    
    GirlModel *girl = [GirlModel modelWithDictionary:dataDic];
    NSLog(@"girl %@",girl);
    
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
