//
//  AddSelfFoodViewController.m
//  AlayiShopDemo
//
//  Created by ibokan on 15/7/7.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "AddSelfFoodViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface AddSelfFoodViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *foodImage;
@property (weak, nonatomic) IBOutlet UITextField *foodName;
@property (weak, nonatomic) IBOutlet UITextView *describeText;

@end

@implementation AddSelfFoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置输入的文本框的边框
    self.describeText.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.describeText.layer.borderWidth = 1;
    
    self.foodImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *imageTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseImage)];
    [self.foodImage addGestureRecognizer:imageTap];
    
    [self setNavStyle];
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
}
//放回回上一页
-(void)backView
{
    [self.navigationController popViewControllerAnimated:YES];
}


//调用系统相册
-(void)chooseImage
{
    BOOL isSource = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
    if (isSource) {
        //打开照片库
        UIImagePickerController *pick = [UIImagePickerController new];
        pick.delegate = self;
        //跳转页面
        [self presentViewController:pick animated:YES completion:nil];
    }
}
//图片选择代理，摄像代理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *orgImg=info[UIImagePickerControllerOriginalImage];
    self.foodImage.image=orgImg;
    //图片控制器消失
    [picker dismissViewControllerAnimated:YES completion:nil];
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
