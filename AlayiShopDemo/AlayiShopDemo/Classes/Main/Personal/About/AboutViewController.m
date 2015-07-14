//
//  AboutViewController.m
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/14.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "AboutViewController.h"
#import "RequestData.h"
@interface AboutViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation AboutViewController
@synthesize type;
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([type isEqualToString:@"1"]) {
        self.title=@"关于我们";
    }else if([type isEqualToString:@"2"])
    {
        self.title=@"加盟合作";
    }else if([type isEqualToString:@"3"])
    {
        self.title=@"配送区域";
    }
    //设置导航栏标题颜色和字体大小UITextAttributeFont:[UIFont fontWithName:@"Heiti TC" size:0.0]
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Heiti Sc" size:16.0],NSForegroundColorAttributeName:[UIColor blackColor]}];
    //1.关于我们、2.加盟合作、3.配送区域、4.首页-公司简介、5.紧急通知
    NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:type,@"id",nil];
    [RequestData getInfoById:params FinishCallbackBlock:^(NSDictionary *data) {
        NSLog(@"%@",data[@"info"][@"content"]);
        //baseURL:桥接HTML字符串里面的图片路径.以保证图标等能够正常显示 例如:http://221.4.222.110:8078
        [self.webView loadHTMLString:data[@"info"][@"content"] baseURL:[NSURL URLWithString:nil]];
    }];
    
}


@end
