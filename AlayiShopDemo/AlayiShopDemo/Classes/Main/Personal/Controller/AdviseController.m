//
//  AdviseController.m
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/3.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "AdviseController.h"
#import "BZGFormField.h"
#import "ARLabel.h"
#import "RequestData.h"
#import "AccountTool.h"
#import "PersonalController.h"
@interface AdviseController ()<UITextViewDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet BZGFormField *subjectView;
@property (weak, nonatomic) IBOutlet BZGFormField *nameView;
@property (weak, nonatomic) IBOutlet BZGFormField *formView;
@property (weak, nonatomic) IBOutlet BZGFormField *phoneView;
@property (weak, nonatomic) IBOutlet BZGFormField *qqView;
@property (weak, nonatomic) IBOutlet BZGFormField *emailView;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentText;
@property (weak, nonatomic) IBOutlet ARLabel *countLabel;
@end

@implementation AdviseController
-(void)viewWillAppear:(BOOL)animated
{
    [self hideTabBar];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"用户反馈";
    //设置导航栏标题颜色和字体大小UITextAttributeFont:[UIFont fontWithName:@"Heiti TC" size:0.0]
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Heiti Sc" size:16.0],NSForegroundColorAttributeName:[UIColor blackColor]}];
    //重写返回按钮
    UIButton *back=[UIButton buttonWithType:UIButtonTypeCustom];
    [back setFrame:CGRectMake(0, 0, 13, 13 )];
    [back setBackgroundImage:[UIImage imageNamed:@"my_left_arrow"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton=[[UIBarButtonItem alloc]initWithCustomView:back];
    self.navigationItem.leftBarButtonItem=barButton;
    //重写右边按钮
    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    [rightBtn setTitle:@"提交" forState:UIControlStateNormal];
    //设置按钮上的自体的大小
    rightBtn.titleLabel.font=[UIFont systemFontOfSize:14.0];
    //设置字体颜色
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBtn setFrame:CGRectMake(0, 0, 30, 30)];
    //按钮事件
    [rightBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar=[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem=rightBar;
    
    //监听文本输入框的改变
    //1.拿到通知中心
    NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
    //2.注册监听
    [center addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:self.contentText];
    self.placeholderLabel.enabled=NO;
    self.contentText.delegate=self;
    [self judgementTextField];
}
/**
 *  POP方法
 *
 *  @param sender <#sender description#>
 */
-(void)back:(id *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
/**
 *  提交事件
 *
 *  @return <#return value description#>
 */
-(void)submit:(id *)sender{
    if (self.subjectView.textField.text.length==0&&self.nameView.textField.text.length==0&&self.formView.textField.text.length==0&&self.phoneView.textField.text.length==0&&self.contentText.text.length==0) {
       UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请完善您的信息" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }else
    {
        AccountModel *account=[AccountTool account];
        //添加反馈
        NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:account.userId,@"userid",self.subjectView.textField.text,@"title",self.nameView.textField.text,@"name",self.formView.textField.text,@"address",self.phoneView.textField.text,@"telephone",self.qqView.textField.text,@"message",self.emailView.textField.text,@"email",self.contentText.text,@"content", nil];
        [RequestData doAddUserFeedback:params FinishCallbackBlock:^(NSDictionary *data) {
            NSLog(@"%@",data);
            NSString *code=data[@"code"];
            if ([code isEqualToString:@"0"]) {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"提交成功!感谢您的珍贵意见" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                alert.tag=10;
                [alert show];
            }else
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"提交失败!请稍候再试,感谢您的珍贵意见" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                alert.tag=11;
                [alert show];
            }
        }];
    }
}
#pragma marks -- UIAlertViewDelegate --
//根据被点击按钮的索引处理点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==10&&buttonIndex==0) {
        //设置故事板为第一启动
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        PersonalController *Personal=[storyboard instantiateViewControllerWithIdentifier:@"个人中心View"];
        [self.navigationController pushViewController:Personal animated:YES];

    }
    
}
#pragma mark 实现UITextView的代理
-(void)textViewDidChange:(UITextView *)textView
{
    self.contentText.text=textView.text;
    if (textView.text.length==0) {
        self.placeholderLabel.hidden=NO;
    }else{
        self.placeholderLabel.hidden=YES;
    }
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.location>=100) {
        return NO;
    }else
    {
        return YES;
    }
}
/**
 *  文本改变事件
 */
-(void)textChange{
    self.countLabel.text=[NSString stringWithFormat:@"%ld/100",(unsigned long)self.contentText.text.length];
}

- (void)hideTabBar {
    if (self.tabBarController.tabBar.hidden == YES) {
        return;
    }
    UIView *contentView;
    if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    else
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x,  contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height + self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = YES;
    
}
#pragma mark 判断文本框是否有内容
-(void)judgementTextField{
    __weak AdviseController *weakSelf=self;
    /*主题*/
    self.subjectView.textField.placeholder=@"亲!请填写您的主题";
    [self.subjectView setTextValidationBlock:^BOOL(NSString *text) {
        if (text.length<1) {
            weakSelf.subjectView.alertView.title=@"主题不能为空";
            return NO;
        }else{
            return YES;
        }
    }];
    /*姓名*/
    self.nameView.textField.placeholder=@"亲!请填写您的姓名";
    [self.nameView setTextValidationBlock:^BOOL(NSString *text) {
        if (text.length<1) {
            weakSelf.nameView.alertView.title=@"姓名不能为空";
            return NO;
        }else{
            return YES;
        }
    }];
    /*地址*/
    self.formView.textField.placeholder=@"亲!请填写您的详细地址";
    [self.formView setTextValidationBlock:^BOOL(NSString *text) {
        if (text.length<1) {
            weakSelf.formView.alertView.title=@"地址不能为空";
            return NO;
        }else{
            return YES;
        }
    }];
    /*手机*/
    self.phoneView.textField.placeholder=@"亲!请填写您的手机号码";
    self.phoneView.textField.keyboardType=UIKeyboardTypePhonePad;
    [self.phoneView setTextValidationBlock:^BOOL(NSString *text) {
        NSString * phoneRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
        NSPredicate *phoneTest=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
        if (![phoneTest evaluateWithObject:text]&&text.length>0) {
            weakSelf.phoneView.alertView.title=@"请填写正确的手机号码";
            return NO;
        }else{
            return YES;
        }
    }];
    /*QQ*/
    self.qqView.textField.placeholder=@"亲!请填写您的QQ号码";
    self.qqView.textField.keyboardType=UIKeyboardTypePhonePad;
    [self.qqView setTextValidationBlock:^BOOL(NSString *text) {
        if (text.length<1) {
            weakSelf.qqView.alertView.title=@"请填写正确的QQ号码";
            return NO;
        }else{
            return YES;
        }
    }];
    /*邮箱*/
    self.emailView.textField.placeholder=@"亲!请填写您的邮箱";
    self.emailView.textField.keyboardType=UIKeyboardTypeEmailAddress;
    [self.emailView setTextValidationBlock:^BOOL(NSString *text) {
        NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
        if (![emailTest evaluateWithObject:text]&&text.length>0) {
            weakSelf.emailView.alertView.title = @"请填写正确的邮箱";
            return NO;
            //_flag=NO;
            } else  {
               // _flag=YES;
                return YES;
            }
        }];

}
@end
