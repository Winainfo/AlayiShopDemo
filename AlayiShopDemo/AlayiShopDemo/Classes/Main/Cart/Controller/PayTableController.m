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
//隐藏和显示底部标签栏
-(void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"选择支付配送方式";
    //设置导航栏标题颜色和字体大小UITextAttributeFont:[UIFont fontWithName:@"Heiti TC" size:0.0]
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Heiti Sc" size:16.0],NSForegroundColorAttributeName:[UIColor blackColor]}];
    //重写返回按钮
    UIButton *back=[UIButton buttonWithType:UIButtonTypeCustom];
    [back setFrame:CGRectMake(0, 0, 13, 13 )];
    [back setBackgroundImage:[UIImage imageNamed:@"my_left_arrow"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton=[[UIBarButtonItem alloc]initWithCustomView:back];
    self.navigationItem.leftBarButtonItem=barButton;
}
/**
 *  POP方法
 *
 *  @param sender <#sender description#>
 */
-(void)back:(id *)sender{
    [self.navigationController popViewControllerAnimated:YES];
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
    //指定跳转
    for(UIViewController *controller in self.navigationController.viewControllers) {
        if([controller isKindOfClass:[SettleController class]]){
            SettleController *settle=(SettleController *)controller;
            [self.navigationController popToViewController:settle animated:YES];
        }
    }
}


@end
