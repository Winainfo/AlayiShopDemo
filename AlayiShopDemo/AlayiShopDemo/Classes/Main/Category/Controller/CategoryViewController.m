//
//  CategoryViewController.m
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/6/30.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "CategoryViewController.h"
#import "MultilevelMenu.h"
#import "SearchViewController.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface CategoryViewController ()<CategoryDelete>

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     默认是 选中第一行
     
     :returns: <#return value description#>
     */
    MultilevelMenu *view=[[MultilevelMenu alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) WithSelectIndex:^(NSInteger left, NSInteger right,rightMeun* info) {
    }];
    view.needToScorllerIndex=0;
    view.isRecordLastScroll=YES;
    view.delete = self;
    [self.view addSubview:view];
    //标题
    self.title = @"商品分类";
    //设置导航栏标题颜色和字体大小UITextAttributeFont:[UIFont fontWithName:@"Heiti TC" size:0.0]
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Heiti Sc" size:16.0],NSForegroundColorAttributeName:[UIColor blackColor]}];
    //导航栏右侧按钮
    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"sousuo"] forState:UIControlStateNormal];
    rightBtn.frame=CGRectMake(-5, 5, 30, 30);
    [rightBtn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem=right;
}

//跳转到搜索页
-(void)searchClick
{
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SearchViewController *searchV = [storyboard instantiateViewControllerWithIdentifier:@"searchView"];
    [self.navigationController pushViewController:searchV animated:YES];
}

-(void)pushView:(id)view{
    [self.navigationController pushViewController:view animated:YES];
}

@end
