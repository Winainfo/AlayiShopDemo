//
//  PersonalController.m
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/2.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "PersonalController.h"
#import "AccountTool.h"
@interface PersonalController ()
@property (strong, nonatomic) IBOutlet UIView *ContainerA;//登录后
@property (weak, nonatomic) IBOutlet UIView *ContainerB;//登录前
@end

@implementation PersonalController
-(void)viewWillAppear:(BOOL)animated
{
    [self flgeAccount];
}
-(void)viewDidAppear:(BOOL)animated
{
    [self flgeAccount];
}
- (void)viewDidLoad {
    [super viewDidLoad];

}
-(void)dealloc
{
}
-(void)flgeAccount
{
    //沙盒路径
    AccountModel *account=[AccountTool account];
    if(account)
    {
        self.ContainerA.hidden=NO;
        self.ContainerB.hidden=YES;
    }
    else
    {
        self.ContainerA.hidden=YES;
        self.ContainerB.hidden=NO;
    }
}
@end
