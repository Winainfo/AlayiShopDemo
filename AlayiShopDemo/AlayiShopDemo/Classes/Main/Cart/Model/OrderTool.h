//
//  OrderTool.h
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/17.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderModel.h"
/**
 *  业务逻辑
 */
@interface OrderTool : NSObject
/**
 *  存储订单信息
 *
 *  @param  订单模型
 */
+(void)saveOrder:(OrderModel *)order;
/**
 *  返回订单信息
 *
 *  @return 订单模型
 */
+(OrderModel *)order;
@end
