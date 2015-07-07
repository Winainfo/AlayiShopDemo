//
//  OrderInfoController.h
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/7.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestData.h"
@interface OrderInfoController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
/**订单编号*/
@property (retain,nonatomic) NSString *orderId;
@end
