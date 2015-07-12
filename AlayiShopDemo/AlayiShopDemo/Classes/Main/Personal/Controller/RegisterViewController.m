//
//  RegisterViewController.m
//  AlayiShopDemo
//
//  Created by ibokan on 15/7/7.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "RegisterViewController.h"
#import "BZGFormField.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width

@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet BZGFormField *userName;
@property (weak, nonatomic) IBOutlet BZGFormField *phoneNum;
@property (weak, nonatomic) IBOutlet BZGFormField *mailboxTxt;
@property (weak, nonatomic) IBOutlet BZGFormField *passwordTxt;
@property (weak, nonatomic) IBOutlet BZGFormField *confirm;
@property (weak, nonatomic) IBOutlet UIImageView *manClick;
@property (weak, nonatomic) IBOutlet UIImageView *womenClick;


@property (assign,nonatomic) int sexId;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏按钮
    [self setNavStyle];
    
    //设置自定义textFied
    [self judgementTextField];
    
    //设置性别单选按钮
    [self setSex];
}

//注册
-(void)registerClick:(id *)sender
{
    if(!(self.sexId && self.userName.textField.text && self.phoneNum.textField.text && self.mailboxTxt.textField.text && self.passwordTxt.textField.text && self.confirm.textField.text))
    {
        UIAlertView *registerAlertV = [[UIAlertView alloc]initWithTitle:@"警告" message:@"请填写完整信息" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [registerAlertV show];
    }else
    {
        NSLog(@"发起注册请求");
    }
}

#pragma mark 设置性别单选按钮
-(void)setSex
{
    self.manClick.userInteractionEnabled = YES;
    self.womenClick.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapMan = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectMan)];
    UITapGestureRecognizer *tapWomen = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectWomen)];
    
    [self.manClick addGestureRecognizer:tapMan];
    [self.womenClick addGestureRecognizer:tapWomen];
}
-(void)selectMan
{
    self.manClick.image = [UIImage imageNamed:@"RadioButton-Selected"];
    self.womenClick.image = [UIImage imageNamed:@"RadioButton-Unselected"];
    self.sexId = 1;
}
-(void)selectWomen
{
    self.manClick.image = [UIImage imageNamed:@"RadioButton-Unselected"];
    self.womenClick.image = [UIImage imageNamed:@"RadioButton-Selected"];
    self.sexId = 2;
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
    
    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"注册" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    rightBtn.frame=CGRectMake(-5, 5, 60, 30);
    [rightBtn addTarget:self action:@selector(registerClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem =right;
}
//放回回上一页
-(void)backView
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark 判断文本框是否有内容
-(void)judgementTextField{
    __weak RegisterViewController *weakSelf=self;
    /*用户名*/
    self.userName.textField.placeholder=@"请输入用户名";
    self.userName.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.userName setTextValidationBlock:^BOOL(NSString *text) {
        if (text.length<1) {
            weakSelf.userName.alertView.title=@"用户名不能为空！";
            return NO;
        }else{
            return YES;
        }
    }];
    /*手机号*/
    self.phoneNum.textField.placeholder=@"请输入手机号";
    self.phoneNum.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.phoneNum setTextValidationBlock:^BOOL(NSString *text) {
        NSString *phoneRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
        NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
        if (text.length<1) {
            weakSelf.phoneNum.alertView.title=@"手机号不能为空！";
            return NO;
        }else if (![phoneTest evaluateWithObject:text]&&text.length>0){
           weakSelf.phoneNum.alertView.title=@"手机号格式错误！";
            return NO;
        }
        else{
            return YES;
        }
    }];
    /*邮箱*/
    self.mailboxTxt.textField.placeholder=@"请输入邮箱";
    self.mailboxTxt.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.mailboxTxt setTextValidationBlock:^BOOL(NSString *text) {
        NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
        if (![emailTest evaluateWithObject:text]&&text.length>0) {
            weakSelf.mailboxTxt.alertView.title=@"请填写正确的邮箱！";
            return NO;
        }else{
            return YES;
        }
    }];
    /*用户密码*/
    self.passwordTxt.textField.placeholder=@"请输入密码";
    self.passwordTxt.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordTxt.textField.keyboardType=UIKeyboardTypePhonePad;
    [self.passwordTxt setTextValidationBlock:^BOOL(NSString *text) {
        if (text.length<1) {
            weakSelf.passwordTxt.alertView.title=@"密码不能为空！";
            return NO;
        }else{
            return YES;
        }
    }];
    /*确认密码*/
    self.confirm.textField.placeholder=@"确认密码";
    self.confirm.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.confirm.textField.keyboardType=UIKeyboardTypePhonePad;
    [self.confirm setTextValidationBlock:^BOOL(NSString *text) {
        if (![text isEqualToString: self.passwordTxt.textField.text] ) {
            weakSelf.confirm.alertView.title=@"前后密码不一致!";
            return NO;
        }else{
            return YES;
        }
    }];
    
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
