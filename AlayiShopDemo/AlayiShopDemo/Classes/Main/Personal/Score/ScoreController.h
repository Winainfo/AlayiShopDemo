//
//  ScoreController.h
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/5.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScoreCell.h"
#import "MJRefresh.h"
@interface ScoreController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@end
