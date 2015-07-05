//
//  ScoreController.m
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/5.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "ScoreController.h"
#import "RequestData.h"
#import "AccountTool.h"
@interface ScoreController ()
@property (retain,nonatomic)NSArray *scoreArray;
@end

@implementation ScoreController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"历史积分";
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
    UINib *nib=[UINib nibWithNibName:@"ScoreCell" bundle:[NSBundle mainBundle]];
    //注册到表格视图
    [self.myTableView  registerNib:nib forCellReuseIdentifier:@"ScoreCell"];
    self.myTableView.separatorStyle=NO;
    self.myTableView.backgroundColor=[UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1];
    AccountModel *account=[AccountTool account];
    //获取用户所有订单0.用户所有订单、1.未付款订单、2.进行中的订单、3.已完成的订单
    NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:account.userId,@"userid",@"10",@"pageSize",@"1",@"currPage", nil];
    [RequestData getUserAllScoreWithPage:params FinishCallbackBlock:^(NSDictionary *data) {
        self.scoreArray=data[@"scoreList"];
        //调用主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.myTableView reloadData];
        });
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
    return self.scoreArray.count;
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
    static NSString *cellStr=@"ScoreCell";
    ScoreCell *cell=[tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell==nil) {
        cell=[[ScoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    cell.timeLabel.text=self.scoreArray[indexPath.row][@"formatScoretime"];
    cell.scoreLabel.text=self.scoreArray[indexPath.row][@"score"];
    cell.saysLabel.text=self.scoreArray[indexPath.row][@"remark"];
    //取消Cell选中时背景
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
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
    return 50;
}
@end
