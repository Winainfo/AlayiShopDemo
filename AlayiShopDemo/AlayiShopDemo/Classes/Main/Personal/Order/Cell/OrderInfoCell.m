//
//  OrderInfoCell.m
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/7.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "OrderInfoCell.h"

@implementation OrderInfoCell

- (void)awakeFromNib {
    self.titleTextView.userInteractionEnabled=NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
