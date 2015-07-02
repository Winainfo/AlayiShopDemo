//
//  ShoppingCarController.m
//  AlayiShopDemo
//
//  Created by ibokan on 15/7/2.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "ShoppingCarController.h"
#import "ShoppingTableViewCell.h"
#define SIZE [UIScreen mainScreen].bounds.size.width

@interface ShoppingCarController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation ShoppingCarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Table view data source


//设置表格数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
//设置单元格高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}
//设置表格内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"ShoppingTableViewCell";
    static BOOL isReg = NO;
    if (!isReg) {
        UINib *nib = [UINib nibWithNibName:@"ShoppingTableViewCell" bundle:[NSBundle mainBundle]];
        [tableView registerNib:nib forCellReuseIdentifier:cellIdentify];
    }
    ShoppingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    
    cell.nameLab.text = @"香葱(小葱)/50g[简装]";
    cell.numlab.text = @"5.00";
    cell.foodView.image = [UIImage imageNamed:@"baicai"];
    return cell;
}

//设置表头内容

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *head = [[UIView alloc]init];
    if (section==0) {
        head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE, 0)];
        UIImageView *img =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shopping_cart_body_bg_01"]];
        [head addSubview:img];
        
        
    }
    return head;
}
//设置表头距离
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

//设置表尾内容
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc]init];
    UILabel *lab= [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 40, 20)];
    lab.text = @"总额";
    lab.font = [UIFont fontWithName:@"Helvetica" size:14.0];
    
    UILabel *labTwo = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, 50, 20)];
    labTwo.text = @"￥1.00";
    labTwo.font = [UIFont fontWithName:@"Helvetica" size:14.0];
    labTwo.textColor = [UIColor redColor];
    
    UIButton *but = [[UIButton alloc]initWithFrame:CGRectMake(180, 10, 100, 40)];
    //设置按钮背景图片
    [but setBackgroundImage:[UIImage imageNamed:@"shopping_cart_btn_with_icon"] forState:UIControlStateNormal];
    //设置按钮标题字体和字体样式
    [but setTitle:@"购物车" forState:UIControlStateNormal];
    but.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    //设置按钮字体在按钮内的位置
    [but titleRectForContentRect:CGRectMake(40, 20, 20, 20)];
    //设置字体颜色
    but.tintColor = [UIColor whiteColor];
    //设置字体距离边框5像素
    but.contentEdgeInsets = UIEdgeInsetsMake(0,0, 0, 5);
    //设置表尾图片
    if (section==0) {
        v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE, 100)];
        UIImageView *i =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shopping_cart_body_bg_02"]];
        [v addSubview:i];//添加图片
        [v addSubview:lab];//添加lab
        [v addSubview:labTwo];//添加第二个lab
        [v addSubview:but];//添加按钮
    }
    return v;
    
    
    
}
//设置表尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
@end
