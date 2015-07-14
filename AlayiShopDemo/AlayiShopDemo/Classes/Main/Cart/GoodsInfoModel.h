//
//  GoodsInfoModel.h
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/14.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsInfoModel : NSObject
@property(assign,nonatomic)int goodsId;
@property(strong,nonatomic)NSString *imageName;//商品图片
@property(strong,nonatomic)NSString *goodsTitle;//商品标题
@property(assign,nonatomic)float goodsPrice;//商品单价
@property(assign,nonatomic)BOOL selectState;//是否选中状态
@property(assign,nonatomic)int goodsNum;//商品个数

-(instancetype)initWithDict:(NSDictionary *)dict;
@end
