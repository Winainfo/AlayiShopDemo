//
//  CartController.m
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/13.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "CartController.h"
#import "RequestData.h"
#import "AccountTool.h"
#import "UIImageView+WebCache.h"
#import "SettleController.h"
@interface CartController ()
@property(retain,nonatomic)CartCell *cell;
@property(assign,nonatomic)BOOL flag;
@property(assign,nonatomic)BOOL editFlag;
@property(retain,nonatomic)NSArray *goodArray;
@property(retain,nonatomic)NSArray *goodArray1;
@property(retain,nonatomic)NSMutableArray *infoArr;
@property(assign,nonatomic)float allPrice;
/**结算*/
@property (weak, nonatomic) IBOutlet UIView *countView;
/**删除*/
@property (weak, nonatomic) IBOutlet UIView *deleteView;
/**空购物车*/
@property (weak, nonatomic) IBOutlet UIView *nullView;


@end

@implementation CartController
-(void)viewWillAppear:(BOOL)animated
{
    [self.myTableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self viewWillAppear:YES];
    //初始化数据
    self.allPrice = 0.0;
    //创建xib文件对象
    UINib *nib=[UINib nibWithNibName:@"CartCell" bundle:[NSBundle mainBundle]];
    //注册到表格视图
    [self.myTableView  registerNib:nib forCellReuseIdentifier:@"CartCell"];
    //取消单元格线
    self.myTableView.separatorStyle=NO;
    self.infoArr = [[NSMutableArray alloc]init];
    //设置导航栏标题颜色和字体大小UITextAttributeFont:[UIFont fontWithName:@"Heiti TC" size:0.0]
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Heiti Sc" size:16.0],NSForegroundColorAttributeName:[UIColor blackColor]}];
    //获取用户购物车的信息
    AccountModel *account=[AccountTool account];
    NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:account.userId,@"userid",nil];
    [RequestData getUserCartList:params FinishCallbackBlock:^(NSDictionary *data) {
        NSLog(@"%@",data);
        self.goodArray=data[@"cartList"];
        if (self.goodArray.count<1) {
            self.myTableView.hidden=YES;
            self.countView.hidden=YES;
            self.nullView.hidden=NO;
            self.editBtn.hidden=YES;
        }else
        {
            self.myTableView.hidden=NO;
            self.countView.hidden=NO;
            self.nullView.hidden=YES;
            self.editBtn.hidden=NO;
            for (int i=0; i<self.goodArray.count; i++) {
                NSMutableDictionary *infoDict=[[NSMutableDictionary alloc]init];
                int goodsId=[self.goodArray[i][@"id"] intValue];
                [infoDict setValue:[NSNumber numberWithInt:goodsId] forKey:@"goodsId"];
                [infoDict setValue:self.goodArray[i][@"foodname"] forKey:@"goodsTitle"];
                float price=[self.goodArray[i][@"price"] floatValue];
                [infoDict setValue:[NSNumber numberWithFloat:price] forKey:@"goodsPrice"];
                int num=[self.goodArray[i][@"number"] intValue];
                [infoDict setValue:[NSNumber numberWithInt:num] forKey:@"goodsNum"];
                [infoDict setValue:self.goodArray[i][@"foodpic"] forKey:@"imageName"];
                [infoDict setValue:[NSNumber numberWithBool:NO] forKey:@"selectState"];
                //封装数据模型
                GoodsInfoModel *goodsModel = [[GoodsInfoModel alloc]initWithDict:infoDict];
                //将数据模型放入数组中
                [self.infoArr addObject:goodsModel];
            }
        }
        //调用主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.myTableView reloadData];
        });
    }];
    
    self.countView.hidden=NO;
    self.deleteView.hidden=YES;
}

#pragma 实现数据源协议中一些关于编辑操作方法

//调用编辑方法,修改数据
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        AccountModel *account=[AccountTool account];
        GoodsInfoModel *model = self.infoArr[indexPath.row];
        NSString *gid=[NSString stringWithFormat:@"%i",model.goodsId];
        NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:gid,@"ids",account.userId,@"userid",nil];
        [RequestData doDeleteCart:params FinishCallbackBlock:^(NSDictionary *data) {
            NSLog(@"删除成功");
        }];
        [self.infoArr removeObjectAtIndex:indexPath.row];
        [self.myTableView reloadData];
    }
}
//提交表格编辑样式
-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:YES];
    if (self.myTableView.editing==NO) {
        self.myTableView.editing=YES;
    }else{
        self.myTableView.editing=NO;
    }
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
    return self.infoArr.count;
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
    static NSString *cellStr=@"CartCell";
    self.cell=[tableView dequeueReusableCellWithIdentifier:cellStr];
    if (self.cell==nil) {
        self.cell=[[CartCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    self.cell.delegate=self;
    //取消Cell选中时背景
    self.cell.selectionStyle=UITableViewCellSelectionStyleNone;
    //调用方法，给单元格赋值
    [self.cell addTheValue:self.infoArr[indexPath.row]];
    return self.cell;
}
/**
 *  点击事件
 *
 *  @param tableView <#tableView description#>
 *  @param indexPath <#indexPath description#>
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  判断当期是否为选中状态，如果选中状态点击则更改成未选中，如果未选中点击则更改成选中状态
     */
    GoodsInfoModel *model = self.infoArr[indexPath.row];
    
    if (model.selectState)
    {
        model.selectState = NO;
    }
    else
    {
        model.selectState = YES;
    }
    //刷新当前行
    [_myTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self totalPrice];
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
    return 120;
}
/**
 *  选中事件
 *
 *  @param sender <#sender description#>
 */
- (IBAction)selectClick:(UIButton *)sender {
    //判断是否选中，是改成否，否改成是，改变图片状态
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 100:
        {
            if (_flag) {
                [btn setBackgroundImage:[UIImage imageNamed:@"syncart_round_check1"] forState:UIControlStateNormal];
                _flag=NO;
            }else
            {
                [btn setBackgroundImage:[UIImage imageNamed:@"syncart_round_check2"] forState:UIControlStateNormal];
                _flag=YES;
            }
            break;
        }
        case 101:
        {
            if (_flag) {
                [btn setBackgroundImage:[UIImage imageNamed:@"syncart_round_check1"] forState:UIControlStateNormal];
                _flag=NO;
            }else
            {
                [btn setBackgroundImage:[UIImage imageNamed:@"syncart_round_check2"] forState:UIControlStateNormal];
                _flag=YES;
            }
            break;
        }
        default:
            break;
    }
    //改变单元格选中状态
    for (int i=0; i<self.infoArr.count; i++) {
        GoodsInfoModel *model=[self.infoArr objectAtIndex:i];
        model.selectState=_flag;
    }
    //计算价格
    [self totalPrice];
    //刷新表格
    [self.myTableView reloadData];
}
#pragma mark -- 计算价格
-(void)totalPrice
{
    //遍历整个数据源，然后判断如果是选中的商品，就计算价格（单价 * 商品数量）
    for ( int i =0; i<self.infoArr.count; i++)
    {
        GoodsInfoModel *model = [self.infoArr objectAtIndex:i];
        if (model.selectState)
        {
            self.allPrice = self.allPrice + model.goodsNum *model.goodsPrice;
        }
    }
    
    //给总价文本赋值
    self.priceCount.text=[NSString stringWithFormat:@"合计:¥ %.2f",self.allPrice];
    
    //每次算完要重置为0，因为每次的都是全部循环算一遍
    self.allPrice = 0.00;
}
#pragma mark -- 实现加减按钮点击代理事件
/**
 *  实现加减按钮点击代理事件
 *
 *  @param cell 当前单元格
 *  @param flag 按钮标识，11 为减按钮，12为加按钮
 */
-(void)btnClick:(UITableViewCell *)cell andFlag:(int)flag
{
    NSIndexPath *index = [_myTableView indexPathForCell:cell];
    switch (flag) {
        case 11:
        {
            //做减法
            //先获取到当期行数据源内容，改变数据源内容，刷新表格
            GoodsInfoModel *model = self.infoArr[index.row];
            model.selectState = YES;
            if (model.goodsNum > 1)
            {
                model.goodsNum --;
            }
        }
            break;
        case 12:
        {
            //做加法
            GoodsInfoModel *model = self.infoArr[index.row];
            model.selectState = YES;
            model.goodsNum ++;
        }
            break;
        default:
            break;
    }
    AccountModel *account=[AccountTool account];
    GoodsInfoModel *model = self.infoArr[index.row];
    NSString *gid=[NSString stringWithFormat:@"%i",model.goodsId];
    NSString *number=[NSString stringWithFormat:@"%i",model.goodsNum];
    NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:gid,@"id",account.userId,@"userid",number,@"number",nil];
    [RequestData updateCartNumber:params FinishCallbackBlock:^(NSDictionary *data) {
        NSLog(@"加--%@",data);
    }];
    //刷新表格
    [_myTableView reloadData];
    
    //计算总价
    [self totalPrice];
    
}
/**
 *  编辑按钮
 *
 *  @param sender <#sender description#>
 */
- (IBAction)editBtn:(UIButton *)sender {
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 200:
        {
            if (_editFlag) {
                [btn setTitle:@"编辑" forState:UIControlStateNormal];
                self.countView.hidden=NO;
                self.deleteView.hidden=YES;
                _editFlag = NO;
            }else{
                [btn setTitle:@"完成" forState:UIControlStateNormal];
                self.countView.hidden=YES;
                self.deleteView.hidden=NO;
                _editFlag = YES;
            }
        }
            break;
            
        default:
            break;
    }
}

- (IBAction)deleteClick:(UIButton *)sender {
    AccountModel *account=[AccountTool account];
    NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:account.userId,@"userid",nil];
    [RequestData delUserAllCart:params FinishCallbackBlock:^(NSDictionary *data) {
       NSLog(@"删除成功");
    }];
    //删除所有
    [self.infoArr removeAllObjects];
    [self.myTableView reloadData];
}

- (IBAction)clickSender:(id)sender {
    //设置故事板为第一启动
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"wjl" bundle:nil];
    SettleController *settle=[storyboard instantiateViewControllerWithIdentifier:@"订单结算View"];
    [self.navigationController pushViewController:settle animated:YES];
}

@end
