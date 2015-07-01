//
//  PersonalController.m
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/1.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "PersonalController.h"


@interface PersonalController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;

@end

@implementation PersonalController

- (void)viewDidLoad {
    [super viewDidLoad];
}

/**
 *  更新约束
 */
-(void)updateViewConstraints
{
    [super updateViewConstraints];
    //设置高度
    self.viewHeight.constant=CGRectGetHeight([UIScreen mainScreen].bounds);
}
@end
