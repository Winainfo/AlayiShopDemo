//
//  LoginController.m
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/1.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "LoginController.h"
#import "PersonalTableViewController.h"
#import "PersonalController.h"
@interface LoginController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameText;
@property (weak, nonatomic) IBOutlet UITextField *passWordText;
@property (assign,nonatomic)BOOL isRead;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@end

@implementation LoginController
//隐藏和显示底部标签栏
-(void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏标题颜色和字体大小UITextAttributeFont:[UIFont fontWithName:@"Heiti TC" size:0.0]
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Heiti Sc" size:16.0],NSForegroundColorAttributeName:[UIColor blackColor]}];
    //监听文本输入框的改变
    //1.拿到通知中心
    NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
    //2.注册监听
    [center addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.userNameText];
     [center addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.passWordText];
    //标题
    self.title=@"登录";
    //重写返回按钮
    UIButton *back=[UIButton buttonWithType:UIButtonTypeSystem];
    [back setFrame:CGRectMake(5, 10, 30, 30 )];
    [back  setTitle:@"取消" forState:UIControlStateNormal];
    [back setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton=[[UIBarButtonItem alloc]initWithCustomView:back];
    self.navigationItem.leftBarButtonItem=barButton;
    
}
/**
 *  POP方法
 *
 *  @param sender <#sender description#>
 */
-(void)back:(id *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)dealloc
{
    //移除监听
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

/**
 *  文本改变事件
 */
-(void)textChange{
    //1.同时改变文本值，登录才可用
    if (self.userNameText.text.length>0&&self.passWordText.text.length>0) {
        //改变btn背景颜色
        self.loginBtn.backgroundColor=[UIColor colorWithRed:242.0/255.0 green:84.0/255.0 blue:84.0/255.0 alpha:1];
        //改变字体颜色
        [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //关闭交互
        self.loginBtn.userInteractionEnabled=YES;

    }else if (self.userNameText.text.length<1||self.passWordText.text.length<1)
    {
        //改变btn背景颜色
        self.loginBtn.backgroundColor=[UIColor colorWithRed:226.0/255.0 green:226.0/255.0 blue:226.0/255.0 alpha:1];
        //改变字体颜色
        [self.loginBtn setTitleColor:[UIColor colorWithRed:189.0/255.0 green:189.0/255.0 blue:189.0/255.0 alpha:1] forState:UIControlStateNormal];
        //关闭交互
        self.loginBtn.userInteractionEnabled=NO;
    }
}
/**
 *  显示或隐藏密码
 *
 *  @param sender <#sender description#>
 */
- (IBAction)passSender:(UIButton *)sender {
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 100:
        {
            //是否显示密码
            if (_isRead) {
                
                [btn setImage:[UIImage imageNamed:@"register_passwd_off"] forState:UIControlStateNormal];
                _isRead = NO;
                self.passWordText.secureTextEntry=YES;
            }else{
                
                [btn setImage:[UIImage imageNamed:@"register_passwd_on"] forState:UIControlStateNormal];
                self.passWordText.secureTextEntry=NO;
                _isRead = YES;
            }
        }
            break;
            
        default:
            break;
    }
}
/**
 *  登录事件
 *
 *  @param sender <#sender description#>
 */
- (IBAction)loginSender:(UIButton *)sender {
    NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:self.userNameText.text,@"username",self.passWordText.text,@"password", nil];
    [RequestData lgin:params FinishCallbackBlock:^(NSDictionary *data) {
        //存储账号信息
        // AccountModel *account=[AccountTool account];
        AccountModel *account=[AccountModel new];
        account.userId=data[@"user"][@"id"];
        NSLog(@"%@",data[@"user"][@"id"]);
        account.name=data[@"user"][@"name"];
        account.password=data[@"user"][@"password"];
        account.pilescore=data[@"user"][@"pilescore"];
        account.email=data[@"user"][@"email"];
        account.sex=data[@"user"][@"sex"];
        account.telephone=data[@"user"][@"telephone"];
        [AccountTool saveAccount:account];
        NSLog(@"-----%@-----",data[@"user"][@"telephone"]);
       NSString *code=data[@"code"];
        if ([code isEqualToString:@"0"]) {
            //设置故事板为第一启动
            UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
           PersonalController *Personal=[storyboard instantiateViewControllerWithIdentifier:@"个人中心View"];
            PersonalTableViewController *PersonalTable=[PersonalTableViewController new];
            PersonalTable.userName=data[@"user"][@"name"];
            PersonalTable.score=data[@"user"][@"pilescore"];
            [self.navigationController pushViewController:Personal animated:YES];
        }else{
            
        }
    }];
}

@end
