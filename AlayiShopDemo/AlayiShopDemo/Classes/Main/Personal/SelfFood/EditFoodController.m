//
//  EditFoodController.m
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/15.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "EditFoodController.h"
#import "RequestData.h"
#import "AccountTool.h"
#import "UIImageView+WebCache.h"
@interface EditFoodController ()
@property (retain,nonatomic)NSData *imagedata;
@end

@implementation EditFoodController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavStyle];
     NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:self.foodId,@"id", nil];
     [RequestData getSelfFoodById:params FinishCallbackBlock:^(NSDictionary *data) {
         //NSLog(@"%@",data[@"selfFood"]);
         self.nameTextField.text=data[@"selfFood"][@"title"];
         self.describeText.text=data[@"selfFood"][@"fmtContent"];
         //照片
         //拼接图片网址
         NSString *urlStr =[NSString stringWithFormat:@"http://www.alayicai.com%@",data[@"selfFood"][@"pic"]];
         //转换成url
         NSURL *imgUrl = [NSURL URLWithString:urlStr];
         [self.goodsImageView sd_setImageWithURL:imgUrl];
         self.imagedata=UIImagePNGRepresentation(self.goodsImageView.image);
     }];
}


/**设置导航栏按钮样式*/
-(void)setNavStyle
{
    //更改导航栏返回按钮图片
    UIButton *leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"my_left_arrow"] forState:UIControlStateNormal];
    leftBtn.frame=CGRectMake(-5, 5, 30, 30);
    [leftBtn addTarget:self action:@selector(backView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem=left;
    //设置导航栏标题颜色和字体大小UITextAttributeFont:[UIFont fontWithName:@"Heiti TC" size:0.0]
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Heiti Sc" size:16.0],NSForegroundColorAttributeName:[UIColor blackColor]}];
}
//放回回上一页
-(void)backView
{
    [self.navigationController popViewControllerAnimated:YES];
}
/**完成*/
- (IBAction)addClick:(UIButton *)sender {
   NSLog(@"----%@---",self.imagedata);
    AccountModel *account=[AccountTool account];
    NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:self.flag,@"flag",account.userId,@"userid",account.name,@"username",self.imagedata,@"fjfile",@"pic2015.png",@"fjfileFileName",self.foodId,@"id",self.describeText.text,@"content",self.nameTextField.text,@"title",nil];
    [RequestData saveSelfFood:params FinishCallbackBlock:^(NSDictionary *data) {
        NSLog(@"保存成功%@",data);
    }];
}

@end
