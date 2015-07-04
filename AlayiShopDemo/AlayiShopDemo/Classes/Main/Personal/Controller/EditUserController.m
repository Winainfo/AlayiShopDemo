//
//  EditUserController.m
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/3.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "EditUserController.h"

@interface EditUserController ()

@end

@implementation EditUserController
@synthesize name;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.valueLabel.text=name;
}


@end
