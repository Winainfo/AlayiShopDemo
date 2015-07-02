//
//  PersonalTableViewController.m
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/1.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "PersonalTableViewController.h"
#import "RequestData.h"
#import "AccountTool.h"
@interface PersonalTableViewController ()
@property (strong, nonatomic) IBOutlet UITableView *myTableview;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;//用户名
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;//积分
@end

@implementation PersonalTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //取消滚动条
    self.myTableview.showsVerticalScrollIndicator=NO;
    //显示用户名
    [self flagLogin];
}
/**
 *  判断是否有登录
 */
-(void)flagLogin
{
    //沙盒路径
    AccountModel *account=[AccountTool account];
    if(account)
    {
        self.userNameLabel.text=account.name;
        self.scoreLabel.text=account.pilescore;
        NSLog(@"----%@------",account.name);
    }else
    {
        self.userNameLabel.text=self.userName;
        self.scoreLabel.text=self.score;
    }
}
@end
