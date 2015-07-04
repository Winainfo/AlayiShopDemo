//
//  OrderController.m
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/3.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "OrderController.h"
#import "RequestData.h"
#import "AccountTool.h"
@interface OrderController ()<UITableViewDataSource,UITableViewDelegate>
@property(retain,nonatomic)NSArray *goods;
@property(assign,nonatomic)int height;
@end

@implementation OrderController
@synthesize type;
//-(void)viewWillAppear:(BOOL)animated{
////    AccountModel *account=[AccountTool account];
////    //获取用户所有订单0.用户所有订单、1.未付款订单、2.进行中的订单、3.已完成的订单
////    NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:type,@"type",account.userId,@"userid",@"5",@"pageSize",@"1",@"currPage", nil];
////    [RequestData getUserOrderListWithPage:params FinishCallbackBlock:^(NSDictionary *data) {
////        NSLog(@"%@",data);
////    }];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([type isEqualToString:@"0"]||[type isEqualToString:@"1"]||[type isEqualToString:@"2"]) {
        self.height=270;
        //创建xib文件对象
        UINib *nib=[UINib nibWithNibName:@"orderCell" bundle:[NSBundle mainBundle]];
        //注册到表格视图
        [self.myTableView  registerNib:nib forCellReuseIdentifier:@"orderCell"];
    }else if([type isEqualToString:@"3"])
    {
        self.height=184;
        //创建xib文件对象
        UINib *nib=[UINib nibWithNibName:@"WaterCell" bundle:[NSBundle mainBundle]];
        //注册到表格视图
        [self.myTableView  registerNib:nib forCellReuseIdentifier:@"WaterCell"];
    }
    self.myTableView.separatorStyle=NO;
    self.myTableView.backgroundColor=[UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1];
    
    AccountModel *account=[AccountTool account];
    //获取用户所有订单0.用户所有订单、1.未付款订单、2.进行中的订单、3.已完成的订单
    NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:type,@"type",account.userId,@"userid",@"10",@"pageSize",@"1",@"currPage", nil];
    [RequestData getUserOrderListWithPage:params FinishCallbackBlock:^(NSDictionary *data) {
        self.goods=data[@"orderList"];
        
        //调用主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.myTableView reloadData];
        });
    }];

}
#pragma mark UITable代理方法
/**
 *  设置单元格数量
 *
 *  @param tableView <#tableView description#>
 *  @param section   <#section description#>
 *
 *  @return <#return value description#>
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.goods.count;
}
/**
 *  设置单元格内容
 *
 *  @param tableView <#tableView description#>
 *  @param indexPath <#indexPath description#>
 *
 *  @return <#return value description#>
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([type isEqualToString:@"0"]||[type isEqualToString:@"1"]||[type isEqualToString:@"2"]) {
        static NSString *cellStr=@"orderCell";
        orderCell *cell=[tableView dequeueReusableCellWithIdentifier:cellStr];
        if (cell==nil) {
            cell=[[orderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        }
        //取消Cell选中时背景
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.orderidLabel.text=self.goods[indexPath.row][@"orderid"];
        cell.stateLabel.text=self.goods[indexPath.row][@"statuText"];
        cell.contentTextView.text=self.goods[indexPath.row][@"title"];
        cell.timeLabel.text=self.goods[indexPath.row][@"ordertime"];
        cell.priceLabel.text=self.goods[indexPath.row][@"formatSumprice"];
        if ([self.goods[indexPath.row][@"statuText"]isEqualToString:@"已完成" ]) {
            self.height=184;
            //创建xib文件对象
            UINib *nib=[UINib nibWithNibName:@"WaterCell" bundle:[NSBundle mainBundle]];
            //注册到表格视图
            [self.myTableView  registerNib:nib forCellReuseIdentifier:@"WaterCell"];
            static NSString *cellStr=@"WaterCell";
            WaterCell *cell=[tableView dequeueReusableCellWithIdentifier:cellStr];
            if (cell==nil) {
                cell=[[WaterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
            }
            //取消Cell选中时背景
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            return cell;
        }else if ([self.goods[indexPath.row][@"statuText"]isEqualToString:@"已支付" ])
        {
            self.height=270;
            //创建xib文件对象
            UINib *nib=[UINib nibWithNibName:@"orderCell" bundle:[NSBundle mainBundle]];
            //注册到表格视图
            [self.myTableView  registerNib:nib forCellReuseIdentifier:@"orderCell"];
         [cell.stateButton setTitle:@"确认收货" forState:UIControlStateNormal];
            [cell.stateButton addTarget:self action:@selector(ok:) forControlEvents:UIControlEventTouchUpInside];
        }else if ([self.goods[indexPath.row][@"statuText"]isEqualToString:@"未付款"])
        {
            self.height=270;
            //创建xib文件对象
            UINib *nib=[UINib nibWithNibName:@"orderCell" bundle:[NSBundle mainBundle]];
            //注册到表格视图
            [self.myTableView  registerNib:nib forCellReuseIdentifier:@"orderCell"];
            
            [cell.stateButton setTitle:@"去付款" forState:UIControlStateNormal];
            [cell.stateButton addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
        }
         return cell;
    }else if ([type isEqualToString:@"3"]){
        static NSString *cellStr=@"WaterCell";
        WaterCell *cell=[tableView dequeueReusableCellWithIdentifier:cellStr];
        if (cell==nil) {
            cell=[[WaterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        }
        //取消Cell选中时背景
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;

    }
    return nil;
}
-(void)ok:(UIButton *)sender{
    NSLog(@"确认收货");
}
-(void)go:(UIButton *)sender{
    NSLog(@"去付款");
}
/**
 *  设置单元格高度
 *
 *  @param tableView <#tableView description#>
 *  @param indexPath <#indexPath description#>
 *
 *  @return <#return value description#>
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if ([type isEqualToString:@"0"]) {
//        return 270;
//        
//    }else if([type isEqualToString:@"1"]||[self.goods[indexPath.row][@"statuText"]isEqualToString:@"已完成" ])
//    {
//       return 184;
//    }
    return self.height;
}
@end
