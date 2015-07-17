//
//  OrderModel.m
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/17.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel
#pragma mark 实现代理协议
/**
 *数据模型存进沙盒需要遵循<NSCoding>协议
 *  当一个对象要归档进沙盒中时，就会调用这个方法
 *  目的：在这个方法中说明这个对象的哪些属性要存进沙盒
 *  @param aCoder <#aCoder description#>
 */
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.paytype forKey:@"paytype"];
    [aCoder encodeObject:self.taketype forKey:@"taketype"];
    [aCoder encodeObject:self.sendaddress forKey:@"sendaddress"];
    [aCoder encodeObject:self.telephone forKey:@"telephone"];
    [aCoder encodeObject:self.receivename forKey:@"receivename"];
}
/**
 *  当从沙盒解析一个对象(从沙盒加载一个对象时)时，就会调用这个方法
 *  目的:在这个方法中说明沙盒中的属性该怎么解析（需要取出哪些属性）
 *  @param aDecoder <#aDecoder description#>
 *
 *  @return <#return value description#>
 */
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super init]) {
        self.paytype=[aDecoder decodeObjectForKey:@"paytype"];
        self.taketype=[aDecoder decodeObjectForKey:@"taketype"];
        self.sendaddress=[aDecoder decodeObjectForKey:@"sendaddress"];
        self.telephone=[aDecoder decodeObjectForKey:@"telephone"];
        self.receivename=[aDecoder decodeObjectForKey:@"receivename"];
    }
    return self;
}
@end
