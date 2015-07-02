//
//  LoginController.m
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/1.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "LoginController.h"
#import "PersonalTableViewController.h"
@interface LoginController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameText;
@property (weak, nonatomic) IBOutlet UITextField *passWordText;
@property (assign,nonatomic)BOOL isRead;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    //监听文本输入框的改变
    //1.拿到通知中心
    NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
    //2.注册监听
    [center addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.userNameText];
     [center addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.passWordText];
    
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
//    //获取第一页前10条记录
//    NSDictionary *params1=[NSDictionary dictionaryWithObjectsAndKeys:@"10",@"pageSize",@"1",@"currPage",@"",@"sortid",@"",@"name",@"",@"type", nil];
//    [RequestData getFoodListWithPage:params1 FinishCallbackBlock:^(NSDictionary *data) {
//        NSLog(@"%@",data);
//    }];
/**
 *  登录事件
 *
 *  @param sender <#sender description#>
 */
- (IBAction)loginSender:(UIButton *)sender {
    NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:self.userNameText.text,@"username",self.passWordText.text,@"password", nil];
    [RequestData lgin:params FinishCallbackBlock:^(NSDictionary *data) {
       NSString *code=data[@"code"];
        if ([code isEqualToString:@"0"]) {
            //设置故事板为第一启动
            UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"wjl" bundle:nil];
            PersonalTableViewController *Personal=[storyboard instantiateViewControllerWithIdentifier:@"登录后的View"];
            [self.navigationController pushViewController:Personal animated:YES];
        }
    }];
}

@end
