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
+(void)lgin:(NSDictionary *)data FinishCallbackBlock:(void(^)(NSDictionary *))block;
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
/**
 *  获取某分类菜单下的菜或获取所有菜
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)getFoodListWithPage:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block;
/**
 *  获取菜的详细信息
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)getFoodById:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block;
/**
 *  获取用户所有购物车的商品
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)getUserCartList:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block;
/**
 *  获取用户购物车商品的数量
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)getUserCartListCount:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block;
/**
 *  添加购物车
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)doAddCart:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block;
/**
 *  删除购物选中某个菜
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)doDeleteCart:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block;
/**
 *  删除用户所有购物车
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)delUserAllCart:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block;
/**
 *  更新购物车菜单数量
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)updateCartNumber:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block;
/**
 *  获取所有取货点
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)getShopList:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block;
/**
 * 用户下单，添加订单及订单明细，并删除所有购物车
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)doCartToOrder:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block;
/**
 * 获取用户所有订单
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)getUserOrderListWithPage:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block;
/**
 * 获取订单信息
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)getOrderInfoByOrderid:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block;
/**
 * 获取订单所有明细信息
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)getOrderListByOrderid:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block;
/**
 * 获取所有信息类型
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)getInfoSortList:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block;
/**
 * 获取所有服务信息
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)getInfoListWithPage:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block;
/**
 * 获取服务信息详情
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)getInfoById:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block;
/**
 * 添加反馈信息
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)doAddUserFeedback:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block;
/**
 * 获取所有自制菜
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)getAllSelfFoodWithPage:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block;
/**
 * 获取用户所有自制菜
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)getUserSelfFoodWithPage:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block;
/**
 * 获取自制菜详细信息
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)getSelfFoodById:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block;
/**
 * 获取菜单所有评论信息--获取普通菜的评论 type只能用1 relateid：普通菜的id 获取自制菜的评论 type只能用2 relateid：自制菜的id
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)getFoodCommentList:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block;
/**
 * 获取用户未付款订单数、进行中订单数、积分信息
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)getUsercenterInfo:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block;
/**
 * 获取用户所有积分记录
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)getUserAllScoreWithPage:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block;
/**
 * 修改密码
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)chgpass:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block;
/**
 * 编辑账户
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)dobjzh:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block;
/**
 * 获取所有热销菜信息
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)getAllHotFoodList:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block;
/**
 删除自制菜
 */
+(void)delSelfFood:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block;
/**
 保存自制菜
 */
+(void)saveSelfFood:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block;
@end
