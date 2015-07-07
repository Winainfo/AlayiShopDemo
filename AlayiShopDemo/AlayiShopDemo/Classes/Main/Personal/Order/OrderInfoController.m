//
//  OrderInfoController.m
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/7.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "OrderInfoController.h"
#import "OrderInfoCell.h"
#import "UIImageView+WebCache.h"
@interface OrderInfoController ()<UITableViewDataSource,UITableViewDelegate>
@property (retain,nonatomic)NSArray *goodsArray;
@end

@implementation OrderInfoController
@synthesize orderId;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getOrderInfo];
    self.title=@"商品清单";
    //设置导航栏标题颜色和字体大小UITextAttributeFont:[UIFont fontWithName:@"Heiti TC" size:0.0]
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Heiti Sc" size:16.0],NSForegroundColorAttributeName:[UIColor blackColor]}];
    //重写返回按钮
    UIButton *back=[UIButton buttonWithType:UIButtonTypeCustom];
    [back setFrame:CGRectMake(0, 0, 13, 13 )];
    [back setBackgroundImage:[UIImage imageNamed:@"my_left_arrow"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton=[[UIBarButtonItem alloc]initWithCustomView:back];
    self.navigationItem.leftBarButtonItem=barButton;
    //创建xib文件对象
    UINib *nib=[UINib nibWithNibName:@"OrderInfoCell" bundle:[NSBundle mainBundle]];
    //注册到表格视图
    [self.myTableView  registerNib:nib forCellReuseIdentifier:@"OrderInfoCell"];
    self.myTableView.separatorStyle=NO;
    [self setExtraCellLineHidden:self.myTableView];
}

/**
 *  去掉多余的分割线
 *
 *  @param tableView <#tableView description#>
 */
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
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
 *  获取订单信息
 */
-(void)getOrderInfo
{
    NSLog(@"---%@---",orderId);
    NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:orderId,@"orderid", nil];
    [RequestData getOrderListByOrderid:params FinishCallbackBlock:^(NSDictionary *data) {
        self.goodsArray=data[@"orderlistList"];
        //右边按钮
        ARLabel *numLabel=[[ARLabel alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
        numLabel.text=[NSString stringWithFormat:@"共%ld件",self.goodsArray.count];
        numLabel.font=[UIFont fontWithName:@"Heiti Sc" size:16.0];
        numLabel.textColor=[UIColor grayColor];
        UIBarButtonItem *rightBtn=[[UIBarButtonItem alloc]initWithCustomView:numLabel];
        self.navigationItem.rightBarButtonItem=rightBtn;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.myTableView reloadData];
        });
    }];
}
#pragma mark 实现table代理
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
    return self.goodsArray.count;
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
    static NSString *cellStr=@"OrderInfoCell";
    OrderInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell==nil) {
        cell=[[OrderInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    //取消Cell选中时背景
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.titleTextView.text=self.goodsArray[indexPath.row][@"foodname"];
    cell.numLabel.text=[NSString stringWithFormat:@"x %@",self.goodsArray[indexPath.row][@"number"]];
    cell.priceLabel.text=self.goodsArray[indexPath.row][@"formatFoodPrice"];
    //拼接图片网址·
    NSString *urlStr =[NSString stringWithFormat:@"http://www.alayicai.com%@",self.goodsArray[indexPath.row][@"foodpic"]];
    //转换成url
    NSURL *imgUrl = [NSURL URLWithString:urlStr];
    [cell.goodsImageView sd_setImageWithURL:imgUrl];
    return cell;
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
    return 130;
}
@end
