//
//  AddressCell.m
//  AlayiShopDemo
//
//  Created by ibokan on 15/7/16.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "AddressCell.h"

@implementation AddressCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}


- (IBAction)editBtn:(UIButton *)sender {
    //调用代理
    [self.delegate btnClick:self andFlag:(int)sender.tag];
}

@end
