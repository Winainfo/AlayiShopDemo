//
//  AboutController.m
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/2.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "AboutController.h"
#import "RequestData.h"
#import "AccountTool.h"
@interface AboutController ()

@end

@implementation AboutController

- (void)viewDidLoad {
    [super viewDidLoad];
//    //信息
//    NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:@"1",@"id", nil];
//    [RequestData getInfoById:params FinishCallbackBlock:^(NSDictionary *data) {
//        NSLog(@"%@",data[@"info"][@"fmtContent2"]);
//    }];
    
    AccountModel *account=[AccountTool account];
    //获取用户所有订单0.用户所有订单、1.未付款订单、2.进行中的订单、3.已完成的订单
    NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:@"0",@"type",account.userId,@"userid",@"5",@"pageSize",@"1",@"currPage", nil];
    [RequestData getUserOrderListWithPage:params FinishCallbackBlock:^(NSDictionary *data) {
        NSLog(@"---%@---",data);
        //调用主线程
    }];
}

/**
 *  pop方法
 *
 *  @param sender <#sender description#>
 */
- (IBAction)popSender:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
