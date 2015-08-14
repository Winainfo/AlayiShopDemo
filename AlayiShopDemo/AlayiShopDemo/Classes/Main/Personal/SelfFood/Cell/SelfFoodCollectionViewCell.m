//
//  SelfFoodCollectionViewCell.m
//  AlayiShopDemo
//
//  Created by ibokan on 15/7/5.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "SelfFoodCollectionViewCell.h"

@implementation SelfFoodCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"SelfFoodCollectionViewCell" owner:self options:nil];
        
        // 如果路径不存在，return nil
        if (arrayOfViews.count < 1)
        {
            return nil;
        }
        // 如果xib中view不属于UICollectionViewCell类，return nil
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]])
        {
            return nil;
        }
        // 加载nib
        self = [arrayOfViews objectAtIndex:0];
    }
    return self;
}

- (void)awakeFromNib {
    self.imageView.layer.cornerRadius=8;
    self.imageView.layer.masksToBounds=YES;
    
}
//编辑我的自制菜
- (IBAction)editClick:(UIButton *)sender {
    //调用代理
    [self.delegate btnClick:self andFlag:(int)sender.tag];
}

//删除我的自制菜
- (IBAction)deleteClick:(UIButton *)sender {
    //调用代理
    [self.delegate btnClick:self andFlag:(int)sender.tag];
}

@end
