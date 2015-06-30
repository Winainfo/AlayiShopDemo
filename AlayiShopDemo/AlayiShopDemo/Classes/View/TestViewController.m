//
//  TestViewController.m
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/6/30.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()
@property (assign,nonatomic)int res;
@property (retain,nonatomic)NSArray *array;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor blueColor];
//    //1.登录
//    NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:@"130",@"username",@"1",@"password", nil];
//    [RequestData lgin:params FinishCallbackBlock:^(NSString * Code) {
//        self.res =[Code intValue];
//    }];
//    //2.注册
//    NSDictionary *params1=[NSDictionary dictionaryWithObjectsAndKeys:@"kolin",@"name",@"03776050",@"password",@"guduxiasky1@163.com",@"email",@"1312",@"telephone",@"1",@"sex",nil];
//    [RequestData registers:params1 FinishCallbackBlock:^(NSString * Code) {
//        NSLog(@"注册：%i",[Code intValue]);
//    }];
    //3.获取所有菜单分类信息
    NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:nil];
    [RequestData getFoodSortList:params FinishCallbackBlock:^(NSDictionary * data) {
        self.array=data[@"sortList"];
        NSLog(@"%@",self.array[0][@"name"]);
    }];
    [self getCode];
}
-(void)getCode
{
    NSLog(@"%@",self.array[0][@"name"]);
}
@end
