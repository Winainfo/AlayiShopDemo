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
#import "FinallyViewController.h"
#import "RequestData.h"

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
    
//    [self setNavStyle];
    
    self.hisArr = [HistoryClass findall];
    
    //为导航栏视图添加搜索栏
    _mySearchBar = [HWSearchBar searchBar];
    _mySearchBar.width = 300;
    _mySearchBar.height = 30;
    self.navigationItem.titleView = _mySearchBar;
    //设置搜索栏的代理
    _mySearchBar.delegate=self;
    
    //注册自定义搜索历史单元格
    UINib *nib = [UINib nibWithNibName:@"HistoryTableViewCell" bundle:[NSBundle mainBundle]];
    [self.hitoryTable registerNib:nib forCellReuseIdentifier:@"HistoryTableViewCell"];
    
    
    //取消左侧导航栏按钮
//    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]init];
//    leftBtn.title = @"";
//    self.navigationItem.leftBarButtonItem = leftBtn;

    
    
}

//设置导航栏按钮样式
//-(void)setNavStyle
//{
//    //更改导航栏返回按钮图片
//    UIButton *leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    [leftBtn setImage:[UIImage imageNamed:@"my_left_arrow"] forState:UIControlStateNormal];
//    leftBtn.frame=CGRectMake(-5, 5, 30, 30);
//    [leftBtn addTarget:self action:@selector(backView) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithCustomView:leftBtn];
//    self.navigationItem.leftBarButtonItem=left;
//}
////放回回上一页
//-(void)backView
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}

//点击放回上一界面
- (IBAction)backView:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
    HistoryClass *history = self.hisArr[indexPath.row];
    cell.foodName.text = history.Hname;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell ;
}
//行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HistoryClass *history = self.hisArr[indexPath.row];
    NSString *hitoryName = history.Hname;
    //通过历史搜索进行查找商品
    NSDictionary *param=[NSDictionary dictionaryWithObjectsAndKeys:@"10",@"pageSize",@"1",@"currPage",@"",@"sortid",hitoryName,@"name",@"",@"type", nil];
    [RequestData getFoodListWithPage:param FinishCallbackBlock:^(NSDictionary * data) {
        FinallyViewController *finalV = [FinallyViewController new];
        
        
    }];
}

#pragma mark 文本框代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [HistoryClass insertHname:_mySearchBar.text];
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
