//
//  CategoryController.h
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/12.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryController : UIViewController
/**销量*/
@property (weak, nonatomic) IBOutlet UIImageView *salesImageView;
/**价格*/
@property (weak, nonatomic) IBOutlet UIImageView *priceImageView;

@property(retain,nonatomic)NSString *type;
@end
