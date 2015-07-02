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

@interface SearchViewController ()

@property (weak, nonatomic) IBOutlet UIView *hotSearchView;
@property (weak, nonatomic) IBOutlet UIView *historySearchView;
@property (weak, nonatomic) IBOutlet UITextField *clearView;
@property (weak, nonatomic) IBOutlet UIButton *clearBtn;


@end

@implementation SearchViewController

static BOOL isHistory = NO;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //为导航栏视图添加搜索栏
    HWSearchBar *mySearchBar = [HWSearchBar searchBar];
    mySearchBar.width = 300;
    mySearchBar.height = 30;
    self.navigationItem.titleView = mySearchBar;
    
    //取消左侧导航栏按钮
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]init];
    leftBtn.title = @"";
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    //默认“清除搜索历史”按钮隐藏
    self.clearView.hidden = YES;
    self.clearBtn.hidden = YES;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    self.hotSearchView.backgroundColor = [UIColor colorWithRed:165/255.0 green:254/255.0 blue:181/255.0 alpha:1.000];
    self.historySearchView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:241/255.0 alpha:1.000];
    //隐藏“清除历史”按钮
    self.clearView.hidden = YES;
    self.clearBtn.hidden = YES;
    isHistory = NO;
}

//点击放回上一界面
- (IBAction)backView:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
//点击热门搜索，改变背景色，显示热门搜索菜名
- (IBAction)ClickHot:(id)sender {
     if (isHistory == YES){
        self.hotSearchView.backgroundColor = [UIColor colorWithRed:165/255.0 green:254/255.0 blue:181/255.0 alpha:1.000];
        self.historySearchView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:241/255.0 alpha:1.000];
         //隐藏“清除历史”按钮
         self.clearView.hidden = YES;
         self.clearBtn.hidden = YES;
        isHistory = NO;
    }
}
//点击历史搜索，改变背景色，显示历史搜索菜名
- (IBAction)ClickHistory:(id)sender {
    if (isHistory == NO) {
        self.historySearchView.backgroundColor = [UIColor colorWithRed:165/255.0 green:254/255.0 blue:181/255.0 alpha:1.000];
        self.hotSearchView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:241/255.0 alpha:1.000];
       isHistory = YES;
        //显示“清除历史”按钮
        self.clearView.hidden = NO;
        self.clearBtn.hidden = NO;
    }
    
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
