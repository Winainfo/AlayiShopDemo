//
//  OrderController.h
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/3.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "orderCell.h"
#import "WaterCell.h"
@protocol RefreshDelegate
-(void)tableViewReloadData;
@end
@interface OrderController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (retain,nonatomic)NSString *type;
@property (nonatomic,retain)  id <RefreshDelegate> delegate;
@end
