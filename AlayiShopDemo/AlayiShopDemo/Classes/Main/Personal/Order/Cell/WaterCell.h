//
//  WaterCell.h
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/4.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARLabel.h"
@interface WaterCell : UITableViewCell<UIScrollViewDelegate>
/**订单编号*/
@property (weak, nonatomic) IBOutlet ARLabel *orderidLabel;
/**订单日期*/
@property (weak, nonatomic) IBOutlet ARLabel *timeLabel;
/**商品图片*/
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
/**商品价格*/
@property (weak, nonatomic) IBOutlet ARLabel *priceLabel;
/**收货按钮*/
@property (weak, nonatomic) IBOutlet UIButton *stateButton;
/**分割线*/
@property (weak, nonatomic) IBOutlet ARLabel *lineLabel;
/**产品图片滚动*/
@property (weak, nonatomic) IBOutlet UIScrollView *imageScrollView;
@property (weak, nonatomic) IBOutlet UIView *goodsView;
/**内容*/
@property (weak, nonatomic) IBOutlet UILabel *contetLabel;
@end
