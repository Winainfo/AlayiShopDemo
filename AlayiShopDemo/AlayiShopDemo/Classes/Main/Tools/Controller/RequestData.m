//
//  RequestData.m
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/6/30.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "RequestData.h"
#define URL @"http://www.alayicai.com/service"
#define  APPID @"1001"
@implementation RequestData

/**
 *  字典转字符串工具类
 *
 *  @param dic <#dic description#>
 *
 *  @return <#return value description#>
 */
+(NSString*)getJsonStr:(NSDictionary*)dic{
    NSError *error = nil;
    NSData *jsonData=[NSJSONSerialization dataWithJSONObject:dic
                                                     options:NSJSONWritingPrettyPrinted
                                                       error:&error];
    if ([jsonData length] > 0 && error == nil){
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonString;
    }else{
        return nil;
    }
}
#pragma mark 登录
/**
 *  登录接口
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)lgin:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    NSString *jsonDic=[RequestData getJsonStr:data];
    NSDictionary *params=@{@"method":@"login",@"appid":APPID,@"data":jsonDic};
    [mgr POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"登录请求成功-----%@",responseObject[@"code"]);
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"登录请求失败-%@",error);
    }];
    
}
#pragma mark 注册
/**
 *  注册接口
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)registers:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSString *))block
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    NSString *jsonDic=[RequestData getJsonStr:data];
    NSDictionary *params=@{@"method":@"register",@"appid":APPID,@"data":jsonDic};
    [mgr POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSLog(@"注册请求成功-----%@",responseObject[@"code"]);
        block(responseObject[@"code"]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"注册请求失败-%@",error);
    }];
}
#pragma mark菜单分类
/**
 *  获取所有菜单分类信息
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)getFoodSortList:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    NSString *jsonDic=[RequestData getJsonStr:data];
    NSDictionary *params=@{@"method":@"getFoodSortList",@"appid":APPID,@"data":jsonDic};
    [mgr POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSLog(@"分类请求成功--");
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"分类请求失败-%@",error);
    }];
}
#pragma mark 分类菜的信息
/**
 *  获取某分类菜单下的菜或所有菜
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)getFoodListWithPage:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    //2.拼接参数
    NSString *jsonDic=[RequestData getJsonStr:data];
    NSDictionary *params=@{@"method":@"getFoodListWithPage",@"appid":APPID,@"data":jsonDic};
    //3.发生请求
    
    [mgr POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSData *data = responseObject;
        NSString *str=[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSString *newstr=[RequestData flattenHTML:str trimWhiteSpace:YES];
        NSDictionary *dict=[RequestData dictionaryWithJsonString:newstr];
        NSLog(@"信息数据请求成功--");
        block(dict);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"信息数据请求失败-%@",error);
    }];
}
#pragma mark 菜的详细信息
/**
 *  获取菜的详细信息
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)getFoodById:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    NSString *jsonDic=[RequestData getJsonStr:data];
    NSDictionary *params=@{@"method":@"getFoodById",@"appid":APPID,@"data":jsonDic};
    [mgr POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"数据请求成功--");
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"数据请求失败-%@",error);
    }];
}
#pragma mark－－－－购物车
/**
 *  获取用户所有购物车的商品
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)getUserCartList:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    NSString *jsonDic=[RequestData getJsonStr:data];
    NSDictionary *params=@{@"method":@"getUserCartList",@"appid":APPID,@"data":jsonDic};
    [mgr POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"购物车数据请求成功--");
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"购物车数据请求失败-%@",error);
    }];
}
/**
 *  获取用户购物车数量
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)getUserCartListCount:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    NSString *jsonDic=[RequestData getJsonStr:data];
    NSDictionary *params=@{@"method":@"getUserCartListCount",@"appid":APPID,@"data":jsonDic};
    [mgr POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"购物车数据请求成功--");
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"购物车数据请求失败-%@",error);
    }];
}
/**
 *  添加购物车
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)doAddCart:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    NSString *jsonDic=[RequestData getJsonStr:data];
    NSDictionary *params=@{@"method":@"doAddCart",@"appid":APPID,@"data":jsonDic};
    [mgr POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"购物车数据请求成功--");
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"购物车数据请求失败-%@",error);
    }];
}
/**
 *  删除购物选中某个菜
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)doDeleteCart:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    NSString *jsonDic=[RequestData getJsonStr:data];
    NSDictionary *params=@{@"method":@"doDeleteCart",@"appid":APPID,@"data":jsonDic};
    [mgr POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"购物车数据请求成功--");
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"购物车数据请求失败-%@",error);
    }];
}
/**
 *  删除用户所有购物车
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)delUserAllCart:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    NSString *jsonDic=[RequestData getJsonStr:data];
    NSDictionary *params=@{@"method":@"delUserAllCart",@"appid":APPID,@"data":jsonDic};
    [mgr POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"购物车数据请求成功--");
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"购物车数据请求失败-%@",error);
    }];
}
/**
 *  更新购物车菜单数量
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)updateCartNumber:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    NSString *jsonDic=[RequestData getJsonStr:data];
    NSDictionary *params=@{@"method":@"updateCartNumber",@"appid":APPID,@"data":jsonDic};
    [mgr POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"更新购物车数据请求成功--");
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"更新购物车数据请求失败-%@",error);
    }];
}
#pragma mark  取货地点
+(void)getShopList:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    NSString *jsonDic=[RequestData getJsonStr:data];
    NSDictionary *params=@{@"method":@"getShopList",@"appid":APPID,@"data":jsonDic};
    [mgr POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"更新购物车数据请求成功--");
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"更新购物车数据请求失败-%@",error);
    }];
}
#pragma mark -----订单
/**
 *  用户下单，添加订单及订单明细，并删除所有购物车
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)doCartToOrder:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    NSString *jsonDic=[RequestData getJsonStr:data];
    NSDictionary *params=@{@"method":@"doCartToOrder",@"appid":APPID,@"data":jsonDic};
    [mgr POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"更新购物车数据请求成功--");
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"更新购物车数据请求失败-%@",error);
    }];
}
/**
 *  获取用户所有订单
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)getUserOrderListWithPage:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    NSString *jsonDic=[RequestData getJsonStr:data];
    NSDictionary *params=@{@"method":@"getUserOrderListWithPage",@"appid":APPID,@"data":jsonDic};
    [mgr POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"订单数据请求成功--");
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"订单数据请求失败-%@",error);
    }];
}
/**
 * 获取订单信息
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)getOrderInfoByOrderid:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    NSString *jsonDic=[RequestData getJsonStr:data];
    NSDictionary *params=@{@"method":@"getOrderInfoByOrderid",@"appid":APPID,@"data":jsonDic};
    [mgr POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"订单数据请求成功--");
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"订单数据请求失败-%@",error);
    }];
}
/**
 * 获取订单所有明细信息
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)getOrderListByOrderid:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    NSString *jsonDic=[RequestData getJsonStr:data];
    NSDictionary *params=@{@"method":@"getOrderListByOrderid",@"appid":APPID,@"data":jsonDic};
    [mgr POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"订单数据请求成功--");
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"订单数据请求失败-%@",error);
    }];
}
#pragma mark -----信息
/**
 * 获取所有信息类型
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)getInfoSortList:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    //2.拼接参数
    NSString *jsonDic=[RequestData getJsonStr:data];
    NSDictionary *params=@{@"method":@"getInfoSortList",@"appid":APPID,@"data":jsonDic};
    //3.发生请求
    [mgr POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"信息数据请求成功--");
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"信息数据请求失败-%@",error);
    }];
}
/**
 * 获取所有服务信息
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)getInfoListWithPage:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    //2.拼接参数
    NSString *jsonDic=[RequestData getJsonStr:data];
    NSDictionary *params=@{@"method":@"getInfoListWithPage",@"appid":APPID,@"data":jsonDic};
    //3.发生请求
    [mgr POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"信息数据请求成功--");
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"信息数据请求失败-%@",error);
    }];
}
/**
 * 获取服务信息详情
 *
 *  @param data  <#data description#>
 *  @param block block description
 */
+(void)getInfoById:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    //2.拼接参数
    NSString *jsonDic=[RequestData getJsonStr:data];
    NSDictionary *params=@{@"method":@"getInfoById",@"appid":APPID,@"data":jsonDic};
    //3.发生请求
    
    [mgr POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data=[RequestData changeFormat:responseObject];
      NSString *str=[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSString *newstr=[RequestData flattenHTML:str trimWhiteSpace:YES];
        NSDictionary *dict=[RequestData dictionaryWithJsonString:newstr];
        NSLog(@"信息数据请求成功--%@",data);
        block(dict);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"信息数据请求失败-%@",error);
    }];
}


/**
 * 添加反馈信息
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)doAddUserFeedback:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    //2.拼接参数
    NSString *jsonDic=[RequestData getJsonStr:data];
    NSDictionary *params=@{@"method":@"doAddUserFeedback",@"appid":APPID,@"data":jsonDic};
    //3.发生请求
    [mgr POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"信息数据请求成功--");
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"信息数据请求失败-%@",error);
    }];
}

#pragma mark ---自制菜
/**
 * 获取所有自制菜
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)getAllSelfFoodWithPage:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    //2.拼接参数
    NSString *jsonDic=[RequestData getJsonStr:data];
    NSDictionary *params=@{@"method":@"getAllSelfFoodWithPage",@"appid":APPID,@"data":jsonDic};
    //3.发生请求
    [mgr POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"自制菜数据请求成功--%@---",responseObject);
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"自制菜数据请求失败-%@",error);
    }];
}
/**
 * 获取用户所有自制菜
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)getUserSelfFoodWithPage:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    //2.拼接参数
    NSString *jsonDic=[RequestData getJsonStr:data];
    NSDictionary *params=@{@"method":@"getUserSelfFoodWithPage",@"appid":APPID,@"data":jsonDic};
    //3.发生请求
    [mgr POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"自制菜数据请求成功--");
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"自制菜数据请求失败-%@",error);
    }];
}
/**
 * 获取自制菜详细信息
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)getSelfFoodById:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    //2.拼接参数
    NSString *jsonDic=[RequestData getJsonStr:data];
    NSDictionary *params=@{@"method":@"getSelfFoodById",@"appid":APPID,@"data":jsonDic};
    //3.发生请求
    [mgr POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"自制菜数据请求成功--");
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"自制菜数据请求失败-%@",error);
    }];
}
#pragma mark 评论
/**
 * 获取菜单所有评论信息--获取普通菜的评论 type只能用1 relateid：普通菜的id 获取自制菜的评论 type只能用2 relateid：自制菜的id
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)getFoodCommentList:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    //2.拼接参数
    NSString *jsonDic=[RequestData getJsonStr:data];
    NSDictionary *params=@{@"method":@"getFoodCommentList",@"appid":APPID,@"data":jsonDic};
    //3.发生请求
    [mgr POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"评论数据请求成功--");
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"评论数据请求失败-%@",error);
    }];
}
#pragma mark 积分
/**
 * 获取用户未付款订单数、进行中订单数、积分信息
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)getUsercenterInfo:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    //2.拼接参数
    NSString *jsonDic=[RequestData getJsonStr:data];
    NSDictionary *params=@{@"method":@"getUsercenterInfo",@"appid":APPID,@"data":jsonDic};
    //3.发生请求
    [mgr POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"积分数据请求成功--");
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"积分数据请求失败-%@",error);
    }];
}
/**
 * 获取用户所有积分记录
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)getUserAllScoreWithPage:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    //2.拼接参数
    NSString *jsonDic=[RequestData getJsonStr:data];
    NSDictionary *params=@{@"method":@"getUserAllScoreWithPage",@"appid":APPID,@"data":jsonDic};
    //3.发生请求
    [mgr POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"积分数据请求成功--");
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"积分数据请求失败-%@",error);
    }];
}

#pragma mark －－账号
/**
 * 修改密码
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)chgpass:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    //2.拼接参数
    NSString *jsonDic=[RequestData getJsonStr:data];
    NSDictionary *params=@{@"method":@"chgpass",@"appid":APPID,@"data":jsonDic};
    //3.发生请求
    [mgr POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"修改密码请求成功--");
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"修改密码请求失败-%@",error);
    }];
}
/**
 * 编辑账户
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)dobjzh:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    //2.拼接参数
    NSString *jsonDic=[RequestData getJsonStr:data];
    NSDictionary *params=@{@"method":@"dobjzh",@"appid":APPID,@"data":jsonDic};
    //3.发生请求
    [mgr POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"修改帐号请求成功--");
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"修改帐号请求失败-%@",error);
    }];
}
#pragma mark 热菜信息
/**
 * 获取所有热销菜信息
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)getAllHotFoodList:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    //2.拼接参数
    NSString *jsonDic=[RequestData getJsonStr:data];
    NSDictionary *params=@{@"method":@"getAllHotFoodList",@"appid":APPID,@"data":jsonDic};
    //3.发生请求
    [mgr POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"请求成功--");
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败-%@",error);
    }];
}

/**
 *  将传入的二进制数据转为字符串后将content字段删除
 *  @param data 包含content字段的二进制数据
 *  @return 不包含content字段的二进制数据
 */
+(NSData*) changeFormat:(NSData*) data{
    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"hello" ofType:@"json"];
    str=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSString *regStr=@"\"content\":\"<.+,\"fmtContent2\"";
    NSRange rage=[str rangeOfString:regStr options:NSRegularExpressionSearch];
    NSString *newStr= [str stringByReplacingCharactersInRange:rage withString:@"\"fmtContent2\""];
    NSData *newData=[newStr dataUsingEncoding:NSUTF8StringEncoding];
    return newData;
}

/**
 *  NSString去除所有HTML标签
 *
 *  @param html <#html description#>
 *  @param trim <#trim description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)flattenHTML:(NSString *)html trimWhiteSpace:(BOOL)trim {
    NSScanner *theScanner = [NSScanner scannerWithString:html];
    NSString *text = nil;
    
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [ NSString stringWithFormat:@"%@>", text]
                                               withString:@""];
    }
    // trim off whitespace
    return trim ? [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] : html;
}

/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
@end
