//
//  CartController.h
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/13.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartCell.h"
@interface CartController : UIViewController<UITableViewDataSource,UITableViewDelegate,CartCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
/**合计*/
@property (weak, nonatomic) IBOutlet UILabel *priceCount;
/*编辑按钮*/
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@end
