//
//  OrderInfoTableController.m
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/4.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "OrderInfoTableController.h"
#import "RequestData.h"
#import "AccountTool.h"
#import "UIImageView+WebCache.h"
@interface OrderInfoTableController ()
@property (retain,nonatomic)NSArray *goodsArray;
@end

@implementation OrderInfoTableController
@synthesize name;
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
    self.title=@"订单明细";
    //设置导航栏标题颜色和字体大小UITextAttributeFont:[UIFont fontWithName:@"Heiti TC" size:0.0]
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Heiti Sc" size:16.0],NSForegroundColorAttributeName:[UIColor blackColor]}];
    //重写返回按钮
    UIButton *back=[UIButton buttonWithType:UIButtonTypeCustom];
    [back setFrame:CGRectMake(0, 0, 13, 13 )];
    [back setBackgroundImage:[UIImage imageNamed:@"my_left_arrow"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton=[[UIBarButtonItem alloc]initWithCustomView:back];
    self.navigationItem.leftBarButtonItem=barButton;
    
    [super viewDidLoad];
    [self getOrderInfo];
    self.goodsInfo.userInteractionEnabled=NO;
    
}
/**
 *  POP方法
 *
 *  @param sender <#sender description#>
 */
-(void)back:(id *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)getOrderInfo
{
    AccountModel *account=[AccountTool account];
    NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:self.orderNum,@"orderid", nil];
   [RequestData getOrderListByOrderid:params FinishCallbackBlock:^(NSDictionary *data) {
       self.goodsArray=data[@"orderlistList"];
       self.orderNumLabel.text=self.goodsArray[0][@"orderid"];
       self.userNameLabel.text=account.name;
       self.phoneNumLabel.text=account.telephone;
       if (self.goodsArray.count<=4) {
           self.ScrollView.userInteractionEnabled=NO;
       }
       if (self.goodsArray.count>1) {
           self.ScrollView.hidden=NO;
           self.infoView.hidden=YES;
           for (int i=0; i<self.goodsArray.count; i++) {
               //拼接图片网址·
               NSString *urlStr =[NSString stringWithFormat:@"http://www.alayicai.com/%@",self.goodsArray[i][@"foodpic"]];
               //转换成url
               NSURL *imgUrl = [NSURL URLWithString:urlStr];
               UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake((i*80)+5, 0, 70, 80)];
               [imageV sd_setImageWithURL:imgUrl];
               [self.ScrollView addSubview:imageV];
           }
           
       }else
       {
           self.ScrollView.hidden=YES;
           self.infoView.hidden=NO;
       self.goodsInfo.text=self.goodsArray[0][@"foodname"];
       self.numLabel.text=[NSString stringWithFormat:@"x %@",self.goodsArray[0][@"number"]];
       self.priceLabel.text=self.goodsArray[0][@"formatFoodPrice"];
       }
       self.goodsPrice.text=self.formatSumprice;
       self.paytypeLabel.text=self.statuText;
       self.taketypeLabel.text=self.taketype;
       //拼接图片网址·
       NSString *urlStr =[NSString stringWithFormat:@"http://www.alayicai.com/%@",self.goodsArray[0][@"foodpic"]];
       //转换成url
       NSURL *imgUrl = [NSURL URLWithString:urlStr];
       [self.faceImageView sd_setImageWithURL:imgUrl];
   }];
}
/**
 *  该方法在视图跳转时被触发
 *
 *  @param segue  <#segue description#>
 *  @param sender <#sender description#>
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"orderId"]) {
        id theSegue=segue.destinationViewController;
        [theSegue setValue:self.orderNum forKey:@"orderId"];
    }
}
@end
