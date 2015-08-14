//
//  OrderTableController.h
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/16.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARLabel.h"
@interface OrderTableController : UITableViewController
/**姓名*/
@property (weak, nonatomic) IBOutlet ARLabel *nameLabel;
/**电话*/
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
/**地址*/
@property (weak, nonatomic) IBOutlet ARLabel *addressLabel;
/**滚动视图*/
@property (weak, nonatomic) IBOutlet UIScrollView *srollView;
/**统计*/
@property (weak, nonatomic) IBOutlet ARLabel *countLabel;
/**图片*/
@property (weak, nonatomic) IBOutlet UIImageView *foodImageView;
/**商品名字*/
@property (weak, nonatomic) IBOutlet ARLabel *foodNameLabel;
/**商品数量*/
@property (weak, nonatomic) IBOutlet ARLabel *foodNumLabel;
/**商品价格*/
@property (weak, nonatomic) IBOutlet ARLabel *foodPriceLabel;
/**支付方式*/
@property (weak, nonatomic) IBOutlet ARLabel *payLabel;
/**送货方式*/
@property (weak, nonatomic) IBOutlet ARLabel *sendLabel;
/**留言*/
@property (weak, nonatomic) IBOutlet UITextField *messageText;
/**视图A*/
@property (weak, nonatomic) IBOutlet UIView *ViewA;
/**视图B*/
@property (weak, nonatomic) IBOutlet UIView *ViewB;
/**总金额*/
@property(retain,nonatomic)NSString *sumPrice;

@end
