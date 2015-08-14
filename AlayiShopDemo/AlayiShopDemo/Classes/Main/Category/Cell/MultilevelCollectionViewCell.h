//
//  MultilevelCollectionViewCell.h
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/13.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARLabel.h"
@interface MultilevelCollectionViewCell : UICollectionViewCell
/**规格*/
@property (weak, nonatomic) IBOutlet ARLabel *goodsSpecLabel;
/**商品图片*/
@property (weak, nonatomic) IBOutlet UIImageView *goodsImagView;
/**商品名字*/
@property (weak, nonatomic) IBOutlet ARLabel *goodsNameLabel;
/**商品价格*/
@property (weak, nonatomic) IBOutlet ARLabel *goodsPriceLabel;
/**商品ID**/
@property (retain, nonatomic) NSString * gID;

@end
