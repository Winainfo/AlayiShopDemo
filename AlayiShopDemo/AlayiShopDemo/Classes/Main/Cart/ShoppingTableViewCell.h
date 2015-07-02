//
//  ShoppingTableViewCell.h
//  AlayiShopDemo
//
//  Created by ibokan on 15/7/2.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingTableViewCell : UITableViewCell
//物品图片
@property (strong, nonatomic) IBOutlet UIImageView *foodView;
//商品名称
@property (strong, nonatomic) IBOutlet UILabel *nameLab;
//商品数量
@property (strong, nonatomic) IBOutlet UILabel *numlab;

@end
