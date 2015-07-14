//
//  GoodsInfoModel.m
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/14.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "GoodsInfoModel.h"

@implementation GoodsInfoModel
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.goodsId=[dict[@"goodsId"] intValue];
        self.imageName = dict[@"imageName"];
        self.goodsTitle = dict[@"goodsTitle"];
        self.goodsPrice = [dict[@"goodsPrice"] floatValue];
        self.goodsNum = [dict[@"goodsNum"] intValue];
        self.selectState = [dict[@"selectState"]boolValue];
    }
    return  self;
}
@end
