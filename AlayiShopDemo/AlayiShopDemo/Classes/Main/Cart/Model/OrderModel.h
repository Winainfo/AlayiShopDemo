//
//  OrderModel.h
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/17.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import <Foundation/Foundation.h>
/**数据模型存进沙盒需要遵循<NSCoding>协议*/
@interface OrderModel : NSObject<NSCoding>
/**支付方式*/
@property (retain,nonatomic)NSString *paytype;
/**取货方式*/
@property (retain,nonatomic)NSString *taketype;
/**收货人地址*/
@property (retain,nonatomic)NSString *sendaddress;
/**收获人电话*/
@property (retain,nonatomic)NSString *telephone;
/**收货人名称*/
@property (retain,nonatomic)NSString *receivename;
@end
