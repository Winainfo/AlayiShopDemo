//
//  orderCell.m
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/3.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "orderCell.h"
#import "RequestData.h"
#import "UIImageView+WebCache.h"
@implementation orderCell

- (void)awakeFromNib {
    self.contentTextView.userInteractionEnabled=NO;
    /**textview 改变字体的行间距 */
    NSMutableParagraphStyle *paragrphStyle=[[NSMutableParagraphStyle alloc]init];
    paragrphStyle.lineSpacing=5;//字体的行间距
    //字体大小UITextAttributeFont:[UIFont fontWithName:@"Heiti TC" size:0.0]
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont fontWithName:@"Heiti Sc" size:14.0], NSParagraphStyleAttributeName:paragrphStyle};
    self.contentTextView.attributedText=[[NSAttributedString alloc]initWithString:self.contentTextView.text attributes:attributes];
    
    //设置代理
   // self.imageScrollView.delegate=self;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
