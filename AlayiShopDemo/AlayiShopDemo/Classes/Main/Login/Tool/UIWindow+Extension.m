//
//  UIWindow+Extension.m
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/2.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "AccountTool.h"
@implementation UIWindow (Extension)
-(void)switchRootViewController
{
    //沙盒路径
    AccountModel *account=[AccountTool account];
    if (account) {//之前登录成功过
        //设置故事板为第一启动
        //        UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Chat" bundle:nil];
        //        self.rootViewController=[storyBoard instantiateInitialViewController];
    }else{//如果第一次登录
        //设置故事板为第一启动
        UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self.rootViewController=[storyBoard instantiateInitialViewController];
    }
}
@end
