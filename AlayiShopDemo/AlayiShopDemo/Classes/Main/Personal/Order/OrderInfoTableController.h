//
//  OrderInfoTableController.h
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/4.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARLabel.h"
@interface OrderInfoTableController : UITableViewController
@property (retain,nonatomic)NSString *name;
/**订单编号*/
@property (weak, nonatomic) IBOutlet ARLabel *orderNumLabel;
/**用户名*/
@property (weak, nonatomic) IBOutlet ARLabel *userNameLabel;
/**电话*/
@property (weak, nonatomic) IBOutlet ARLabel *phoneNumLabel;
/**地址*/
@property (weak, nonatomic) IBOutlet ARLabel *addressLabel;
/**商品图片*/
@property (weak, nonatomic) IBOutlet UIImageView *faceImageView;
/**商品详情*/
@property (weak, nonatomic) IBOutlet UITextView *goodsInfo;
/**商品数量*/
@property (weak, nonatomic) IBOutlet ARLabel *numLabel;
/**商品价格*/
@property (weak, nonatomic) IBOutlet ARLabel *priceLabel;
/**商品总额*/
@property (weak, nonatomic) IBOutlet ARLabel *goodsPrice;
/**订单编号*/
@property(retain,nonatomic)NSString *orderNum;

@property(retain,nonatomic)NSString *statuText;
/**支付方式*/
@property (weak, nonatomic) IBOutlet ARLabel *paytypeLabel;
@property(retain,nonatomic)NSString *taketype;
/**配送方式*/
@property (weak, nonatomic) IBOutlet ARLabel *taketypeLabel;

/**实付款*/
@property(retain,nonatomic)NSString *formatSumprice;

@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;

@property (weak, nonatomic) IBOutlet UIView *infoView;


@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@end
