//
//  SearchViewController.m
//  AlayiShopDemo
//
//  Created by ibokan on 15/7/1.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "SearchViewController.h"
#import "UIView+Extension.h"
#import "HWSearchBar.h"
#import "HistoryTableViewCell.h"
#import "HistoryClass.h"
#import "RequestData.h"
#import "CategoryController.h"

@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UIView *historySearchView;
@property (weak, nonatomic) IBOutlet UITextField *clearView;
@property (weak, nonatomic) IBOutlet UIButton *clearBtn;
@property (weak, nonatomic) IBOutlet UITableView *hitoryTable;
@property (retain,nonatomic) HWSearchBar *mySearchBar;
@property (retain,nonatomic) NSArray *hisArr;//存储搜索历史的数组


@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavStyle];
    
    //查询所有搜索历史
    self.hisArr = [HistoryClass findall];
    
    self.hitoryTable.backgroundColor = [UIColor colorWithWhite:0.956 alpha:1.000];
    
    //为导航栏视图添加搜索栏
    _mySearchBar = [HWSearchBar searchBar];
    _mySearchBar.width = 260;
    _mySearchBar.height = 30;
    self.navigationItem.titleView = _mySearchBar;
    //设置搜索栏的代理
    _mySearchBar.delegate=self;
    
    //注册自定义搜索历史单元格
    UINib *nib = [UINib nibWithNibName:@"HistoryTableViewCell" bundle:[NSBundle mainBundle]];
    [self.hitoryTable registerNib:nib forCellReuseIdentifier:@"HistoryTableViewCell"];

    
}

//设置导航栏按钮样式
-(void)setNavStyle
{
    //更改导航栏返回按钮图片
    UIButton *leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"my_left_arrow"] forState:UIControlStateNormal];
    leftBtn.frame=CGRectMake(-5, 5, 30, 30);
    [leftBtn addTarget:self action:@selector(backView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem=left;
}
//放回回上一页
-(void)backView
{
    [self.navigationController popViewControllerAnimated:YES];
}

//清除所有搜索历史
- (IBAction)cleanAllHistory:(id)sender {
    
    [HistoryClass deleteAllHistory];
    //查询所有搜索历史
    self.hisArr = [HistoryClass findall];
    //刷新表格
    [self.hitoryTable reloadData];
}

#pragma mark 表格代理
//单元格个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.hisArr.count;
}
//单元格内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HistoryTableViewCell"];
    if (!cell) {
        cell = [[HistoryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HistoryTableViewCell"];
    }
    HistoryClass *history = self.hisArr[(self.hisArr.count-1-indexPath.row)];
    cell.foodName.text = history.Hname;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithWhite:0.956 alpha:1.000];
    return cell ;
}
//行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}
//点击历史记录，跳转到分类结果页
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HistoryClass *history = self.hisArr[(self.hisArr.count-1-indexPath.row)];
    NSString *hitoryName =[history.Hname stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //通过历史搜索进行查找商品
    NSDictionary *param=[NSDictionary dictionaryWithObjectsAndKeys:@"10",@"pageSize",@"1",@"currPage",@"",@"sortid",hitoryName,@"name",@"",@"type", nil];
    [RequestData getFoodListWithPage:param FinishCallbackBlock:^(NSDictionary * data) {
        
        NSArray *foodListArr = data[@"foodList"];
        NSLog(@"搜索结果 == %@",foodListArr);
        
        //设置故事板为第一启动
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"wjl" bundle:nil];
        CategoryController *cateV=[storyboard instantiateViewControllerWithIdentifier:@"分类View"];
        [self.navigationController pushViewController:cateV animated:YES];
        //为搜索结果赋值
        cateV.goodsArray = foodListArr;
        
        
    }];
}

#pragma 实现数据源协议中一些关于编辑操作方法

//调用编辑方法,修改数据
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        //删除方法
        HistoryClass *his=self.hisArr[(self.hisArr.count-1-indexPath.row)];
        int hid=his.Hid;
//        NSLog(@"tv.vid=%d;Vid=%d",tv.Vid,Vid);
        [HistoryClass deleteHISTORY:hid];
        self.hisArr = [HistoryClass findall];
        NSLog(@"%lu",self.hisArr.count);
        [self.hitoryTable reloadData];
    }
}
//提交表格编辑样式
-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:YES];
    if (self.hitoryTable.editing==NO) {
        self.hitoryTable.editing=YES;
    }else{
        self.hitoryTable.editing=NO;
    }
}


#pragma mark 文本框代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //将搜索历史存到本地数据库
    [HistoryClass insertHname:_mySearchBar.text];
    
    //查询所有搜索历史
    self.hisArr = [HistoryClass findall];
    //刷新表格
    [self.hitoryTable reloadData];
    
    //点击RETURN键即开始搜索，跳转到搜索结果页
    NSString *hitoryName =[textField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //通过历史搜索进行查找商品
    NSDictionary *param=[NSDictionary dictionaryWithObjectsAndKeys:@"10",@"pageSize",@"1",@"currPage",@"",@"sortid",hitoryName,@"name",@"",@"type", nil];
    [RequestData getFoodListWithPage:param FinishCallbackBlock:^(NSDictionary * data) {
        
        NSArray *foodListArr = data[@"foodList"];
        NSLog(@"搜索结果 == %@",foodListArr);
        
        //设置故事板为第一启动
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"wjl" bundle:nil];
        CategoryController *cateV=[storyboard instantiateViewControllerWithIdentifier:@"分类View"];
        [self.navigationController pushViewController:cateV animated:YES];
        //为搜索结果赋值
        cateV.goodsArray = foodListArr;
        
    }];
    //搜索完成清空输入框的文字
    textField.text = nil;
    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
