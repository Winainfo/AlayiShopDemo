//
//  SettleController.m
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/16.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "SettleController.h"
#import "RequestData.h"
#import "AccountTool.h"
#import "OrderController.h"
#import "OrderTool.h"
@interface SettleController ()

@property (weak, nonatomic) IBOutlet UIView *container;
@property(retain,nonatomic)NSArray *goodsArray;
@end

@implementation SettleController
//隐藏和显示底部标签栏
-(void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}
-(void)viewWillAppear:(BOOL)animated
{
     self.tabBarController.tabBar.hidden = YES;
    OrderModel *orderModel=[OrderTool order];
    NSLog(@"----%@----",orderModel.paytype);
    if ([orderModel.paytype isEqualToString:@"1"]) {
        order.payLabel.text=@"支付宝";
    }else if([orderModel.paytype isEqualToString:@"2"]) {
        order.payLabel.text=@"货到付款";
    }
    if ([orderModel.taketype isEqualToString:@"1"]) {
        order.sendLabel.text=@"自提";
    }else if([orderModel.taketype isEqualToString:@"2"]) {
        order.sendLabel.text=@"送货上门";
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"填写订单";
    //设置导航栏标题颜色和字体大小UITextAttributeFont:[UIFont fontWithName:@"Heiti TC" size:0.0]
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Heiti Sc" size:16.0],NSForegroundColorAttributeName:[UIColor blackColor]}];
    //重写返回按钮
    UIButton *back=[UIButton buttonWithType:UIButtonTypeCustom];
    [back setFrame:CGRectMake(0, 0, 13, 13 )];
    [back setBackgroundImage:[UIImage imageNamed:@"my_left_arrow"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton=[[UIBarButtonItem alloc]initWithCustomView:back];
    self.navigationItem.leftBarButtonItem=barButton;
    
    _goodsArray=self.container.subviews;
    UITableView *tableView=_goodsArray[0];
    order=tableView.dataSource;
   
    //获取用户购物车的信息
    AccountModel *account=[AccountTool account];
    NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:account.userId,@"userid",nil];
    [RequestData getUserCartList:params FinishCallbackBlock:^(NSDictionary *data) {
        self.priceLabel.text=data[@"sumprice"];
    }];

}
/**
 *  POP方法
 *
 *  @param sender <#sender description#>
 */
-(void)back:(id *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 提交订单
 */
- (IBAction)submitClick:(UIButton *)sender {
    AccountModel *account=[AccountTool account];
    OrderModel *orderModel=[OrderTool order];
    NSString *address=[order.addressLabel.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *phone=[order.phoneLabel.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *name=[order.nameLabel.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = @{@"paytype":orderModel.paytype,@"taketype":orderModel.taketype,@"sendaddress":address,@"telephone":phone,@"receivename":name,@"gettimestr":@"2015-07-29%2011:23:00",@"remark":@"123"};
    //需要上传的参数
    NSDictionary *dicy=@{@"userid":account.userId,@"username":account.name,@"order":dic};
    [RequestData doCartToOrder:dicy FinishCallbackBlock:^(NSDictionary *data) {
        NSLog(@"---成功--%@",data);
//        if ([data[@"code"]isEqualToString:@"0"]) {
//            //设置故事板为第一启动
//            UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//            OrderController *orderView=[storyboard instantiateViewControllerWithIdentifier:@"我的订单View"];
//            orderView.type=@"0";
//            [self.navigationController pushViewController:orderView animated:YES];
//        }
    }];
}

@end
