//
//  CategoryCell.h
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/12.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARLabel.h"
@interface CategoryCell : UITableViewCell
/**规格*/
@property (weak, nonatomic) IBOutlet ARLabel *specLabel;
/**商品图片*/
@property (weak, nonatomic) IBOutlet UIImageView *goodsImagView;
/**商品名字*/
@property (weak, nonatomic) IBOutlet ARLabel *goodsNameLabel;
/**商品价格*/
@property (weak, nonatomic) IBOutlet ARLabel *goodsPriceLabel;
/**商品销量*/
@property (weak, nonatomic) IBOutlet ARLabel *goodsSaleslabel;

@end
