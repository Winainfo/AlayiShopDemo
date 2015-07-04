//
//  AccountModel.m
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/2.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "AccountModel.h"

@implementation AccountModel
+(instancetype)accountWithDict:(NSDictionary *)dict
{
    AccountModel *account=[[self alloc]init];
    account.userId=dict[@"id"];
    account.name=dict[@"name"];
    account.password=dict[@"password"];
    account.telephone=dict[@"telephone"];
    return account;
}
#pragma mark 实现代理协议
/**
 *数据模型存进沙盒需要遵循<NSCoding>协议
 *  当一个对象要归档进沙盒中时，就会调用这个方法
 *  目的：在这个方法中说明这个对象的哪些属性要存进沙盒
 *  @param aCoder <#aCoder description#>
 */
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeObject:self.pilescore forKey:@"pilescore"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.sex forKey:@"sex"];
    [aCoder encodeObject:self.telephone forKey:@"telephone"];
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
        self.userId=[aDecoder decodeObjectForKey:@"userId"];
        self.name=[aDecoder decodeObjectForKey:@"name"];
        self.password=[aDecoder decodeObjectForKey:@"password"];
        self.pilescore=[aDecoder decodeObjectForKey:@"pilescore"];
        self.email=[aDecoder decodeObjectForKey:@"email"];
        self.sex=[aDecoder decodeObjectForKey:@"sex"];
        self.telephone=[aDecoder decodeObjectForKey:@"telephone"];
    }
    return self;
}
@end
