//
//  SelfFoodCollectionViewCell.h
//  AlayiShopDemo
//
//  Created by ibokan on 15/7/5.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARLabel.h"

@interface SelfFoodCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *foodImage;
@property (weak, nonatomic) IBOutlet ARLabel *foodTitle;
@property(assign,nonatomic)int foodId;


@end