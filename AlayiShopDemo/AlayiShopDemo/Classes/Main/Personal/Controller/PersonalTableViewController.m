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

-(void)viewWillAppear:(BOOL)animated
{
    [self showTabBar];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏标题颜色和字体大小UITextAttributeFont:[UIFont fontWithName:@"Heiti TC" size:0.0]
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Heiti Sc" size:16.0],NSForegroundColorAttributeName:[UIColor blackColor]}];
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
/**
 *  显示TabBar
 */
- (void)showTabBar

{
    if (self.tabBarController.tabBar.hidden == NO)
    {
        return;
    }
    UIView *contentView;
    if ([[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]])
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    
    else
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height - self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = NO;
    
}

/**
 *  该方法在视图跳转时被触发
 *
 *  @param segue  <#segue description#>
 *  @param sender <#sender description#>
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"orderCell"]) {
        id theSegue=segue.destinationViewController;
        [theSegue setValue:@"0" forKey:@"type"];
    }
    if ([segue.identifier isEqualToString:@"WaterCell"])
    {
        id theSegue=segue.destinationViewController;
        [theSegue setValue:@"3" forKey:@"type"];
    }
    if ([segue.identifier isEqualToString:@"payCell"])
    {
        id theSegue=segue.destinationViewController;
        [theSegue setValue:@"1" forKey:@"type"];
    }
    if ([segue.identifier isEqualToString:@"makingCell"])
    {
        id theSegue=segue.destinationViewController;
        [theSegue setValue:@"2" forKey:@"type"];
    }
    //关于我们
    if ([segue.identifier isEqualToString:@"gywm"]) {
        id theSegue=segue.destinationViewController;
        [theSegue setValue:@"1" forKey:@"type"];
    }
    //加盟合作
    if ([segue.identifier isEqualToString:@"jmhz"]) {
        id theSegue=segue.destinationViewController;
        [theSegue setValue:@"2" forKey:@"type"];
    }
    //配送区域
    if ([segue.identifier isEqualToString:@"psqy"]) {
        id theSegue=segue.destinationViewController;
        [theSegue setValue:@"3" forKey:@"type"];
    }
}
@end
