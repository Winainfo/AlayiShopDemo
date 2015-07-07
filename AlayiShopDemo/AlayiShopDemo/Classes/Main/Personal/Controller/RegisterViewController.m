//
//  RegisterViewController.m
//  AlayiShopDemo
//
//  Created by ibokan on 15/7/7.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginBar.h"
#import "UIView+Extension.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    LoginBar *logV1 = [LoginBar loginBar];
    logV1.frame = CGRectMake(20, 50, 200, 50);
    [self.view addSubview:logV1];
    
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
