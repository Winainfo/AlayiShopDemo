//
//  RequestData.h
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/6/30.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface RequestData : NSObject
/**
 *  登录接口
 *
 *  @param data  传入字典
 *  @param block 返回块值
 */
+(void)lgin:(NSDictionary *)data FinishCallbackBlock:(void(^)(NSString *))block;
/**
 *  注册接口
 *
 *  @param data  传入字典
 *  @param block 返回块值
 */
+(void)registers:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSString *))block;
/**
 *  获取所有菜单分类信息
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)getFoodSortList:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block;
@end
