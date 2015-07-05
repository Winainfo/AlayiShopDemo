//
//  MoreController.m
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/2.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "MoreController.h"
#import "PersonalController.h"
#import "AccountTool.h"
@interface MoreController ()<UIAlertViewDelegate>

@end

@implementation MoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    //沙盒路径
    AccountModel *account=[AccountTool account];
    //判断是否有登录
    if(account)
    {
        self.logoutView.hidden=NO;
    }else
    {
        self.logoutView.hidden=YES;
    }
}
/**
 *  pop方法
 *
 *  @param sender <#sender description#>
 */
- (IBAction)popSender:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  退出事件
 *
 *  @param sender <#sender description#>
 */
- (IBAction)logoutSender:(UIButton *)sender {
    //初始化AlertView
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定退出登录?" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    [alert show];

}

#pragma marks -- UIAlertViewDelegate --
//根据被点击按钮的索引处理点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"clickButtonAtIndex:%ld",(long)buttonIndex);
    if (buttonIndex==1) {
        [self deleteFile];
        //设置故事板为第一启动
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"wjl" bundle:nil];
        PersonalController *Personal=[storyboard instantiateViewControllerWithIdentifier:@"个人中心View"];
        [self.navigationController pushViewController:Personal animated:YES];
    }
}

/**
 *  清除缓存事件
 *
 *  @param sender <#sender description#>
 */
- (IBAction)ClickSender:(UIButton *)sender {
    //初始化AlertView
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定退出登录?" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    [alert show];
}

// 删除沙盒里的文件
-(void)deleteFile {
    NSFileManager* fileManager=[NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
    //文件名
    NSString *uniquePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:@"userInfo.archive"];
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:uniquePath];
    if (!blHave) {
        NSLog(@"no  have");
        return ;
    }else {
        NSLog(@" have");
        BOOL blDele= [fileManager removeItemAtPath:uniquePath error:nil];
        if (blDele) {
            NSLog(@"dele success");
        }else {
            NSLog(@"dele fail");
        }
        
    }
}
@end
