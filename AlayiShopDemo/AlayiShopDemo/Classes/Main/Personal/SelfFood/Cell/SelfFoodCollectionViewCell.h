//
//  SelfFoodCollectionViewCell.h
//  AlayiShopDemo
//
//  Created by ibokan on 15/7/5.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARLabel.h"
//添加代理，用于按钮删除的实现
@protocol SelfFoodDelegate <NSObject>

-(void)btnClick:(UICollectionViewCell *)cell andFlag:(int)flag;

@end
@interface SelfFoodCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *foodImage;
@property (weak, nonatomic) IBOutlet ARLabel *foodTitle;
@property(retain,nonatomic) NSString *foodId;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;

@property (unsafe_unretained, nonatomic) IBOutlet UIView *imageView;
@property(assign,nonatomic)id<SelfFoodDelegate>delegate;
@end
