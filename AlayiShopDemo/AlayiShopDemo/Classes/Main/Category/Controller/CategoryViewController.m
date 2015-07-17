//
//  CategoryViewController.m
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/6/30.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "CategoryViewController.h"
#import "MultilevelMenu.h"
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
}

-(void)pushView:(id)view{
    [self.navigationController pushViewController:view animated:YES];
}

@end
