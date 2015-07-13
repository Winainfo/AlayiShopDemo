//
//  Category_Cell.h
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/12.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARLabel.h"
@interface Category_Cell : UICollectionViewCell
/**规格*/
@property (weak, nonatomic) IBOutlet ARLabel *goodsSpecLabel;
/**商品图片*/
@property (weak, nonatomic) IBOutlet UIImageView *goodsImagView;
/**商品名字*/
@property (weak, nonatomic) IBOutlet ARLabel *goodsNameLabel;
/**商品价格*/
@property (weak, nonatomic) IBOutlet ARLabel *goodsPriceLabel;
/**商品销量*/
@property (weak, nonatomic) IBOutlet ARLabel *goodsSaleslabel;
@end
