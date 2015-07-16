//
//  OrderTool.m
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/17.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "OrderTool.h"

/**
 *  账号的存储路径
 *
 *  @param NSDocumentDirectory <#NSDocumentDirectory description#>
 *  @param NSUserDomainMask    <#NSUserDomainMask description#>
 *  @param YES                 <#YES description#>
 *
 *  @return <#return value description#>
 */
#define  OrderPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"orderInfo.archive"]
@implementation OrderTool
/**
 *   存储订单信息
 *
 *  @param order <#account description#>
 */
+(void)saveOrder:(OrderModel *)order
{
    //利用NSKeyedArchiver类 写进沙盒
    //自定义对象的存储必须用NSKeyedArchiver,不再有什么writeToFile方法
    [NSKeyedArchiver archiveRootObject:order toFile:OrderPath];
}
/**
 *  返回订单信息
 *
 *  @return
 */
+(OrderModel *)order
{
    //加载模型
    OrderModel *order=[NSKeyedUnarchiver unarchiveObjectWithFile:OrderPath];
    return order;
}
@end
