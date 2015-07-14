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
//    //获取分类
//    NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:nil];
//    [RequestData getFoodSortList:params FinishCallbackBlock:^(NSDictionary * data) {
//        self.array=data[@"sortList"];
//        NSLog(@"%@",data[@"sortList"][0][@"id"]);
//      
//    }];
//    //获取第一页前10条记录
//    NSDictionary *params1=[NSDictionary dictionaryWithObjectsAndKeys:@"10",@"pageSize",@"1",@"currPage",@"",@"sortid",@"",@"name",@"",@"type", nil];
//    [RequestData getFoodListWithPage:params1 FinishCallbackBlock:^(NSDictionary *data) {
//        NSLog(@"%@",data);
//    }];
    //搜索青菜
    NSDictionary *params2=[NSDictionary dictionaryWithObjectsAndKeys:@"10",@"pageSize",@"1",@"currPage",@"",@"sortid",@"草鸡",@"name",@"",@"type", nil];
    [RequestData getFoodListWithPage:params2 FinishCallbackBlock:^(NSDictionary *data) {
        NSLog(@"%@",data);
    }];
    //查找分类下的菜获取第一页前10条记录
    NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:nil];
    [RequestData getFoodSortList:params FinishCallbackBlock:^(NSDictionary * data) {
        NSString *sortId=data[@"sortList"][0][@"id"];
        NSDictionary *params3=[NSDictionary dictionaryWithObjectsAndKeys:@"10",@"pageSize",@"1",@"currPage",sortId,@"sortid",@"",@"name",@"",@"type", nil];
        [RequestData getFoodListWithPage:params3 FinishCallbackBlock:^(NSDictionary *data1) {
            NSLog(@"%@",data1);
        }];
    }];
    //获取菜的详细信息
//    NSDictionary *params1=[NSDictionary dictionaryWithObjectsAndKeys:@"10",@"pageSize",@"1",@"currPage",@"",@"sortid",@"",@"name",@"",@"type", nil];
//    [RequestData getFoodListWithPage:params1 FinishCallbackBlock:^(NSDictionary *data) {
//        NSString *iD=data[@"foodList"][0][@"id"];
//        NSDictionary *params3=[NSDictionary dictionaryWithObjectsAndKeys:iD,@"id", nil];
//        [RequestData getFoodById:params3 FinishCallbackBlock:^(NSDictionary *data1) {
//            NSLog(@"%@",data1);
//        }];
//        }];
    //获取用户购物车的信息
//    NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:@"130",@"username",@"1",@"password",nil];
//    [RequestData lgin:params FinishCallbackBlock:^(NSDictionary *data) {
//        NSString *userId=data[@"user"][@"id"];
//        NSDictionary *params3=[NSDictionary dictionaryWithObjectsAndKeys:userId,@"userid", nil];
//        [RequestData getUserCartList:params3 FinishCallbackBlock:^(NSDictionary *data1) {
//            NSLog(@"%@",data1);
//        }];
//    }];
    //获取用户购物车商品的数量
//    NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:@"130",@"username",@"1",@"password",nil];
//    [RequestData lgin:params FinishCallbackBlock:^(NSDictionary *data) {
//        NSString *userId=data[@"user"][@"id"];
//        NSDictionary *params3=[NSDictionary dictionaryWithObjectsAndKeys:userId,@"userid", nil];
//        [RequestData getUserCartListCount:params3 FinishCallbackBlock:^(NSDictionary *data1) {
//            NSLog(@"%@",data1);
//        }];
//    }];
    //添加商品到购物车
    NSDictionary *params1=[NSDictionary dictionaryWithObjectsAndKeys:@"10",@"pageSize",@"1",@"currPage",@"",@"sortid",@"",@"name",@"",@"type", nil];
        [RequestData getFoodListWithPage:params1 FinishCallbackBlock:^(NSDictionary *data) {
            NSString *foodId=data[@"foodList"][1][@"id"];
            NSDictionary *params2=[NSDictionary dictionaryWithObjectsAndKeys:@"130",@"username",@"1",@"password",nil];
            [RequestData lgin:params2 FinishCallbackBlock:^(NSDictionary *data1) {
                NSString *userId=data1[@"user"][@"id"];
                NSDictionary *params3=[NSDictionary dictionaryWithObjectsAndKeys:userId,@"userid",foodId,@"foodid",@"5",@"number",nil];
               [RequestData doAddCart:params3 FinishCallbackBlock:^(NSDictionary *data2) {
                   NSLog(@"%@",data2);
               }];
            }];
        }];
    NSLog(@"%@");
}
//-(void)getCode
//{
//    NSLog(@"%@",self.array[0][@"name"]);
//}
@end
