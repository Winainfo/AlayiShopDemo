//
//  CartCell.h
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/13.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARLabel.h"
#import "GoodsInfoModel.h"
//添加代理，用于按钮加减的实现
@protocol CartCellDelegate <NSObject>

-(void)btnClick:(UITableViewCell *)cell andFlag:(int)flag;

@end
@interface CartCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *imgeView;
/**选中框*/
@property (weak, nonatomic) IBOutlet UIImageView *selectImage;
/**商品图片*/
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
/**商品名字*/
@property (weak, nonatomic) IBOutlet ARLabel *goodsNameLabel;
/**商品价格*/
@property (weak, nonatomic) IBOutlet ARLabel *goodsPriceLabel;
/**减号*/
@property (weak, nonatomic) IBOutlet UIButton *subBtn;
/**加号*/
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
/**商品数量*/
@property (weak, nonatomic) IBOutlet UITextField *numText;

@property(assign,nonatomic) BOOL flag;

@property(assign,nonatomic)BOOL selectState;//选中状态

//赋值
-(void)addTheValue:(GoodsInfoModel *)goodsModel;

@property(assign,nonatomic)id<CartCellDelegate>delegate;
@end
