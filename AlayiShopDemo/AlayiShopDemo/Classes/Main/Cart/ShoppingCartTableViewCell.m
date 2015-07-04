//
//  ShoppingCartTableViewCell.m
//  AlayiShopDemo
//
//  Created by ibokan on 15/7/4.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "ShoppingCartTableViewCell.h"


@implementation ShoppingCartTableViewCell

- (void)awakeFromNib {
    
    self.cellMoveNum.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
   
    //限制输入的字符串长度
    NSMutableString *text = [self.cellMoveNum.text mutableCopy];
    [text replaceCharactersInRange:range withString:string];
    return [text length] <= 4;

}


@end
