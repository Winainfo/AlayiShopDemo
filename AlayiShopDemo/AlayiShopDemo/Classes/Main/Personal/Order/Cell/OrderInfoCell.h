//
//  OrderInfoCell.h
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/7.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARLabel.h"
@interface OrderInfoCell : UITableViewCell
/**商品图片*/
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
/**商品名字*/
@property (weak, nonatomic) IBOutlet UITextView *titleTextView;
/**商品数量*/
@property (weak, nonatomic) IBOutlet ARLabel *numLabel;
/**商品价格*/
@property (weak, nonatomic) IBOutlet ARLabel *priceLabel;

@end
