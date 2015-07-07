//
//  OrderFormViewController.m
//  AlayiShopDemo
//
//  Created by ibokan on 15/7/6.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "OrderFormViewController.h"

@interface OrderFormViewController ()
//支付方式按钮界面
@property (strong, nonatomic) IBOutlet UIView *PaymentMethodView;

@end

@implementation OrderFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//选择支付方式
- (IBAction)PaymentMethodButton:(id)sender
{
    self.PaymentMethodView.hidden = !self.PaymentMethodView.hidden;
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
