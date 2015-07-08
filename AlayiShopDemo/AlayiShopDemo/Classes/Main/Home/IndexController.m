//
//  IndexController.m
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/6/30.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "IndexController.h"

@interface IndexController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;
@end

@implementation IndexController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor redColor];
}

-(void)updateViewConstraints{
    [super updateViewConstraints];
    //设置高度
    self.viewHeight.constant=CGRectGetHeight([UIScreen mainScreen].bounds)*2;
}
@end
