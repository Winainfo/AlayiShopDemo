//
//  PersonalTableViewController.m
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/1.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "PersonalTableViewController.h"

@interface PersonalTableViewController ()
@property (strong, nonatomic) IBOutlet UITableView *myTableview;

@end

@implementation PersonalTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //取消滚动条
    self.myTableview.showsVerticalScrollIndicator=NO;
}



@end
