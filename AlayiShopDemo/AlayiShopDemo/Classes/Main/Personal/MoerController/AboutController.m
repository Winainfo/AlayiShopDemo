//
//  AboutController.m
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/2.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "AboutController.h"

@interface AboutController ()

@end

@implementation AboutController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
