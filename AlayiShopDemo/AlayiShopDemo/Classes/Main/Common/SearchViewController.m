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

@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *hotSearchView;
@property (weak, nonatomic) IBOutlet UIView *historySearchView;
@property (weak, nonatomic) IBOutlet UITextField *clearView;
@property (weak, nonatomic) IBOutlet UIButton *clearBtn;
@property (weak, nonatomic) IBOutlet UITableView *hitoryTable;


@end

@implementation SearchViewController

static BOOL isHistory = NO;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavStyle];
    
    //为导航栏视图添加搜索栏
    HWSearchBar *mySearchBar = [HWSearchBar searchBar];
    mySearchBar.width = 300;
    mySearchBar.height = 30;
    self.navigationItem.titleView = mySearchBar;
    //设置搜索栏的代理
    mySearchBar.delegate=self;
    
    //取消左侧导航栏按钮
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]init];
    leftBtn.title = @"";
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    //默认“清除搜索历史”按钮隐藏
    self.clearView.hidden = YES;
    self.clearBtn.hidden = YES;
    self.hitoryTable.hidden = YES;
    
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

-(void)viewWillAppear:(BOOL)animated
{
    self.hotSearchView.backgroundColor = [UIColor lightGrayColor];
    self.historySearchView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:241/255.0 alpha:1.000];
    //隐藏“清除历史”按钮
    self.clearView.hidden = YES;
    self.clearBtn.hidden = YES;
    self.hitoryTable.hidden = YES;
    isHistory = NO;
}

//点击放回上一界面
- (IBAction)backView:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
//点击热门搜索，改变背景色，显示热门搜索菜名
- (IBAction)ClickHot:(id)sender {
     if (isHistory == YES){
        self.hotSearchView.backgroundColor = [UIColor lightGrayColor];
        self.historySearchView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:241/255.0 alpha:1.000];
         //隐藏“清除历史”按钮
         self.clearView.hidden = YES;
         self.clearBtn.hidden = YES;
         self.hitoryTable.hidden = YES;
        isHistory = NO;
    }
}
//点击历史搜索，改变背景色，显示历史搜索菜名
- (IBAction)ClickHistory:(id)sender {
    if (isHistory == NO) {
        self.historySearchView.backgroundColor = [UIColor lightGrayColor];
        self.hotSearchView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:241/255.0 alpha:1.000];
       isHistory = YES;
        //显示“清除历史”按钮
        self.clearView.hidden = NO;
        self.clearBtn.hidden = NO;
        self.hitoryTable.hidden = NO;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
    }
    cell.textLabel.text = @"搜索历史";
    return cell ;
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
