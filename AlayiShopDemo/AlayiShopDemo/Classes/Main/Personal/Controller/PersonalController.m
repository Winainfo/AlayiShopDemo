//
//  PersonalController.m
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/2.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "PersonalController.h"
#import "AccountTool.h"
#import "TencentOpenAPI/QQApiInterface.h"
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
//跳转到QQ临时会话窗口
- (IBAction)QQClick:(UIButton *)sender {
    //跳转到QQ临时会话窗口
    [self sendToQQWPA];
}
- (void)sendToQQWPA
{
    //设置一个有效的号码
    NSString * qqNum = @"149583628";
    
    
    QQApiWPAObject *wpaObj = [QQApiWPAObject objectWithUin:qqNum];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:wpaObj];
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    [self handleSendResult:sent];
}
- (void)handleSendResult:(QQApiSendResultCode)sendResult
{
    NSLog(@"%s",__FUNCTION__);
}



@end
