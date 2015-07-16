//
//  SettleController.h
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/16.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARLabel.h"
#import "OrderTableController.h"
@interface SettleController : UIViewController
{
    OrderTableController *order;
}
@property (weak, nonatomic) IBOutlet ARLabel *priceLabel;
@property (retain,nonatomic) NSString *price;
/**支付方式*/
@property(retain,nonatomic) NSString *paytype;
/**取货方式*/
@property(retain,nonatomic) NSString *taketype;
@end
