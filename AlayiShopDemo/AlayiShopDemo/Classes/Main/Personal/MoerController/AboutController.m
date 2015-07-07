//
//  AboutController.m
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/2.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "AboutController.h"
#import "RequestData.h"
@interface AboutController ()

@end

@implementation AboutController

- (void)viewDidLoad {
    [super viewDidLoad];
    //信息
    NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:@"1",@"id", nil];
    [RequestData getInfoById:params FinishCallbackBlock:^(NSDictionary *data) {
       // NSLog(@"%@",data[@"info"][@"fmtContent2"]);
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
