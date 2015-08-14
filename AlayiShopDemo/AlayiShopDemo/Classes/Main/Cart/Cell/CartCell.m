//
//  CartCell.m
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/13.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "CartCell.h"
#import "UIImageView+WebCache.h"
@implementation CartCell

- (void)awakeFromNib {
    [[self.imgeView layer]setBorderWidth:0.5];//线的宽度
    [[self.imgeView layer]setBorderColor:[UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:0.8].CGColor];
    [[self.imgeView layer]setCornerRadius:8.0];//圆角
    //监听文本输入框的改变
    //1.拿到通知中心
    NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
    //2.注册监听
    [center addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.numText];
    
}
-(void)dealloc
{
    //移除监听
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

/**
 *  文本改变事件
 */
-(void)textChange{
    int numberInt =[self.numText.text intValue];
    NSLog(@"%d",numberInt);
    if (numberInt>1) {
        [self.subBtn setBackgroundImage:[UIImage imageNamed:@"syncart_less_btn_enable"] forState: UIControlStateNormal];
    }
    if (numberInt==1) {
        [self.subBtn setBackgroundImage:[UIImage imageNamed:@"syncart_less_btn_disable"] forState: UIControlStateNormal];
    }
    if (numberInt==200) {
        [self.addBtn setBackgroundImage:[UIImage imageNamed:@"syncart_more_btn_disable"] forState: UIControlStateNormal];
    }
    if (numberInt>200) {
        self.numText.text=[NSString stringWithFormat:@"200"];
    }
    if (numberInt<1) {
        self.numText.text=[NSString stringWithFormat:@"1"];
    }
    [self.selectImage setImage:[UIImage imageNamed:@"syncart_round_check2"]];
    _flag=YES;
}
/**
 *  点击添加数量
 *
 *  @param sender <#sender description#>
 */
- (IBAction)addClick:(UIButton *)sender {
    //调用代理
    [self.delegate btnClick:self andFlag:(int)sender.tag];
    
}
/**
 *  减法
 *
 *  @param sender <#sender description#>
 */
- (IBAction)subClick:(UIButton *)sender {
    //调用代理
    [self.delegate btnClick:self andFlag:(int)sender.tag];
}



/**
 *  给单元格赋值
 *
 *  @param goodsModel 里面存放各个控件需要的数值
 */
-(void)addTheValue:(GoodsInfoModel *)goodsModel
{
    //照片
    //拼接图片网址·
    NSString *urlStr =[NSString stringWithFormat:@"http://www.alayicai.com%@",goodsModel.imageName];
    //转换成url
    NSURL *imgUrl = [NSURL URLWithString:urlStr];
    [self.goodsImageView sd_setImageWithURL:imgUrl];
    self.goodsNameLabel.text=goodsModel.goodsTitle;
    self.goodsPriceLabel.text=[NSString stringWithFormat:@"¥:%.2f",goodsModel.goodsPrice];
    self.numText.text=[NSString stringWithFormat:@"%d",goodsModel.goodsNum];
    
    if (goodsModel.selectState)
    {
        _selectState = YES;
        _selectImage.image = [UIImage imageNamed:@"syncart_round_check2"];
    }else{
        _selectState = NO;
        _selectImage.image = [UIImage imageNamed:@"syncart_round_check1"];
    }
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}


@end
