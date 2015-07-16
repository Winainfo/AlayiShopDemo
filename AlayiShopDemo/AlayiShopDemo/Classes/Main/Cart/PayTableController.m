//
//  PayTableController.m
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/16.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "PayTableController.h"
#import "SettleController.h"
#import "OrderTool.h"
@interface PayTableController ()
@property (weak, nonatomic) IBOutlet UIButton *onlinePay;
@property (weak, nonatomic) IBOutlet UIButton *pay;
@property (weak, nonatomic) IBOutlet UIButton *taketypeBtn;
@property (weak, nonatomic) IBOutlet UIButton *zititype;

@property (retain,nonatomic)NSString *paytype;
@property (retain,nonatomic)NSString *taketype;
@end

@implementation PayTableController
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)payClick:(UIButton *)sender {
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 100:
        {
            [self.onlinePay setBackgroundImage:[UIImage imageNamed:@"order_pickup_butn_seleted"] forState:UIControlStateNormal];
            [self.onlinePay setImage:[UIImage imageNamed:@"order_pickup_butn_seleted_icon"] forState:UIControlStateNormal];
             [self.pay setBackgroundImage:[UIImage imageNamed:@"order_pickup_butn_normal"] forState:UIControlStateNormal];
            [self.pay setImage:[UIImage imageNamed:@"order_selfservice_addr_01"] forState:UIControlStateNormal];
            _paytype=@"1";
        }
            break;
        case 101:
        {
            [self.pay setBackgroundImage:[UIImage imageNamed:@"order_pickup_butn_seleted"] forState:UIControlStateNormal];
            [self.pay setImage:[UIImage imageNamed:@"order_pickup_butn_seleted_icon"] forState:UIControlStateNormal];
            [self.onlinePay setBackgroundImage:[UIImage imageNamed:@"order_pickup_butn_normal"] forState:UIControlStateNormal];
            [self.onlinePay setImage:[UIImage imageNamed:@"order_selfservice_addr_01"] forState:UIControlStateNormal];
            _paytype=@"2";
        }
            break;
            
        default:
            break;
    }
}

- (IBAction)taketypeClick:(UIButton *)sender {
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 200:
        {
            [self.taketypeBtn setBackgroundImage:[UIImage imageNamed:@"order_pickup_butn_seleted"] forState:UIControlStateNormal];
            [self.taketypeBtn  setImage:[UIImage imageNamed:@"order_pickup_butn_seleted_icon"] forState:UIControlStateNormal];
            [self.zititype setBackgroundImage:[UIImage imageNamed:@"order_pickup_butn_normal"] forState:UIControlStateNormal];
            [self.zititype setImage:[UIImage imageNamed:@"order_selfservice_addr_01"] forState:UIControlStateNormal];
            _taketype=@"2";
        }
            break;
        case 201:
        {
            [self.zititype setBackgroundImage:[UIImage imageNamed:@"order_pickup_butn_seleted"] forState:UIControlStateNormal];
            [self.zititype setImage:[UIImage imageNamed:@"order_pickup_butn_seleted_icon"] forState:UIControlStateNormal];
            [self.taketypeBtn setBackgroundImage:[UIImage imageNamed:@"order_pickup_butn_normal"] forState:UIControlStateNormal];
            [self.taketypeBtn setImage:[UIImage imageNamed:@"order_selfservice_addr_01"] forState:UIControlStateNormal];
            _taketype=@"1";
        }
            break;
            
        default:
            break;
    }
}

- (IBAction)saveBtn:(UIButton *)sender {
    OrderModel *order=[OrderModel new];
    order.paytype=self.paytype;
    order.taketype=self.taketype;
    [OrderTool saveOrder:order];
    [self.navigationController popViewControllerAnimated:YES];
   
}


@end
