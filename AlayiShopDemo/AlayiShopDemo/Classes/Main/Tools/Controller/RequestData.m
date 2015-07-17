//
//  RequestData.m
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/6/30.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import "RequestData.h"
#import <CommonCrypto/CommonDigest.h>
#define URL @"http://www.alayicai.com/service"
#define  APPID @"1001"
#define APPKEY @"9E16EEB623B98424"
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
    //获取加密的sign
    NSString *sign = [self getMD5StrMethod:@"login" andData:jsonDic andAppId:APPID andAppKey:APPKEY];
    NSLog(@"---%@---",sign);
    NSDictionary *params=@{@"method":@"login",@"appid":APPID,@"data":jsonDic,@"sign":sign};
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
    //获取加密的sign
    NSString *sign = [self getMD5StrMethod:@"register" andData:jsonDic andAppId:APPID andAppKey:APPKEY];
    NSDictionary *params=@{@"method":@"register",@"appid":APPID,@"data":jsonDic,@"sign":sign};
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
    //获取加密的sign
    NSString *sign = [self getMD5StrMethod:@"getFoodSortList" andData:jsonDic andAppId:APPID andAppKey:APPKEY];
    NSDictionary *params=@{@"method":@"getFoodSortList",@"appid":APPID,@"data":jsonDic,@"sign":sign};
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
    //获取加密的sign
    NSString *sign = [self getMD5StrMethod:@"getFoodListWithPage" andData:jsonDic andAppId:APPID andAppKey:APPKEY];
    NSDictionary *params=@{@"method":@"getFoodListWithPage",@"appid":APPID,@"data":jsonDic,@"sign":sign};
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
    //获取加密的sign
    NSString *sign = [self getMD5StrMethod:@"getFoodById" andData:jsonDic andAppId:APPID andAppKey:APPKEY];
    NSDictionary *params=@{@"method":@"getFoodById",@"appid":APPID,@"data":jsonDic,@"sign":sign};
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
    //获取加密的sign
    NSString *sign = [self getMD5StrMethod:@"getUserCartList" andData:jsonDic andAppId:APPID andAppKey:APPKEY];
    NSDictionary *params=@{@"method":@"getUserCartList",@"appid":APPID,@"data":jsonDic,@"sign":sign};
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
    //获取加密的sign
    NSString *sign = [self getMD5StrMethod:@"getUserCartListCount" andData:jsonDic andAppId:APPID andAppKey:APPKEY];
    NSDictionary *params=@{@"method":@"getUserCartListCount",@"appid":APPID,@"data":jsonDic,@"sign":sign};
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
    //获取加密的sign
    NSString *sign = [self getMD5StrMethod:@"doAddCart" andData:jsonDic andAppId:APPID andAppKey:APPKEY];
    NSDictionary *params=@{@"method":@"doAddCart",@"appid":APPID,@"data":jsonDic,@"sign":sign};
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
    //获取加密的sign
    NSString *sign = [self getMD5StrMethod:@"doDeleteCart" andData:jsonDic andAppId:APPID andAppKey:APPKEY];
    NSDictionary *params=@{@"method":@"doDeleteCart",@"appid":APPID,@"data":jsonDic,@"sign":sign};
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
    //获取加密的sign
    NSString *sign = [self getMD5StrMethod:@"delUserAllCart" andData:jsonDic andAppId:APPID andAppKey:APPKEY];
    NSDictionary *params=@{@"method":@"delUserAllCart",@"appid":APPID,@"data":jsonDic,@"sign":sign};
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
    //获取加密的sign
    NSString *sign = [self getMD5StrMethod:@"updateCartNumber" andData:jsonDic andAppId:APPID andAppKey:APPKEY];
    NSDictionary *params=@{@"method":@"updateCartNumber",@"appid":APPID,@"data":jsonDic,@"sign":sign};
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
    //获取加密的sign
    NSString *sign = [self getMD5StrMethod:@"getShopList" andData:jsonDic andAppId:APPID andAppKey:APPKEY];
    NSDictionary *params=@{@"method":@"getShopList",@"appid":APPID,@"data":jsonDic,@"sign":sign};
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
    //获取加密的sign
    NSString *sign = [self getMD5StrMethod:@"doCartToOrder" andData:jsonDic andAppId:APPID andAppKey:APPKEY];
    NSDictionary *params=@{@"method":@"doCartToOrder",@"appid":APPID,@"data":jsonDic,@"sign":sign};
    [mgr POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"提交数据请求成功--");
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"提交数据请求失败-%@",error);
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
    //获取加密的sign
    NSString *sign = [self getMD5StrMethod:@"getUserOrderListWithPage" andData:jsonDic andAppId:APPID andAppKey:APPKEY];
    NSDictionary *params=@{@"method":@"getUserOrderListWithPage",@"appid":APPID,@"data":jsonDic,@"sign":sign};
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
    //获取加密的sign
    NSString *sign = [self getMD5StrMethod:@"getOrderInfoByOrderid" andData:jsonDic andAppId:APPID andAppKey:APPKEY];
    NSDictionary *params=@{@"method":@"getOrderInfoByOrderid",@"appid":APPID,@"data":jsonDic,@"sign":sign};
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
    //获取加密的sign
    NSString *sign = [self getMD5StrMethod:@"getOrderListByOrderid" andData:jsonDic andAppId:APPID andAppKey:APPKEY];
    NSDictionary *params=@{@"method":@"getOrderListByOrderid",@"appid":APPID,@"data":jsonDic,@"sign":sign};
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
    //获取加密的sign
    NSString *sign = [self getMD5StrMethod:@"getInfoSortList" andData:jsonDic andAppId:APPID andAppKey:APPKEY];
    NSDictionary *params=@{@"method":@"getInfoSortList",@"appid":APPID,@"data":jsonDic,@"sign":sign};
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
    //获取加密的sign
    NSString *sign = [self getMD5StrMethod:@"getInfoListWithPage" andData:jsonDic andAppId:APPID andAppKey:APPKEY];
    NSDictionary *params=@{@"method":@"getInfoListWithPage",@"appid":APPID,@"data":jsonDic,@"sign":sign};
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
    mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    //2.拼接参数
    NSString *jsonDic=[RequestData getJsonStr:data];
    //获取加密的sign
    NSString *sign = [self getMD5StrMethod:@"getInfoById" andData:jsonDic andAppId:APPID andAppKey:APPKEY];
    NSDictionary *params=@{@"method":@"getInfoById",@"appid":APPID,@"data":jsonDic,@"sign":sign};
    //3.发生请求
    
    [mgr POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSData *data=[RequestData changeFormat:responseObject];
        NSString *str=[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
       // NSString *newstr=[RequestData flattenHTML:str trimWhiteSpace:YES];
        NSDictionary *dict=[RequestData dictionaryWithJsonString:str];
        NSLog(@"信息数据请求成功--");
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
    //获取加密的sign
    NSString *sign = [self getMD5StrMethod:@"doAddUserFeedback" andData:jsonDic andAppId:APPID andAppKey:APPKEY];
    NSDictionary *params=@{@"method":@"doAddUserFeedback",@"appid":APPID,@"data":jsonDic,@"sign":sign};
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
    //获取加密的sign
    NSString *sign = [self getMD5StrMethod:@"getAllSelfFoodWithPage" andData:jsonDic andAppId:APPID andAppKey:APPKEY];
    NSDictionary *params=@{@"method":@"getAllSelfFoodWithPage",@"appid":APPID,@"data":jsonDic,@"sign":sign};
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
    //获取加密的sign
    NSString *sign = [self getMD5StrMethod:@"getUserSelfFoodWithPage" andData:jsonDic andAppId:APPID andAppKey:APPKEY];
    NSDictionary *params=@{@"method":@"getUserSelfFoodWithPage",@"appid":APPID,@"data":jsonDic,@"sign":sign};
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
    //获取加密的sign
    NSString *sign = [self getMD5StrMethod:@"getSelfFoodById" andData:jsonDic andAppId:APPID andAppKey:APPKEY];
    NSDictionary *params=@{@"method":@"getSelfFoodById",@"appid":APPID,@"data":jsonDic,@"sign":sign};
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
    //获取加密的sign
    NSString *sign = [self getMD5StrMethod:@"getFoodCommentList" andData:jsonDic andAppId:APPID andAppKey:APPKEY];
    NSDictionary *params=@{@"method":@"getFoodCommentList",@"appid":APPID,@"data":jsonDic,@"sign":sign};
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
    //获取加密的sign
    NSString *sign = [self getMD5StrMethod:@"getUsercenterInfo" andData:jsonDic andAppId:APPID andAppKey:APPKEY];
    NSDictionary *params=@{@"method":@"getUsercenterInfo",@"appid":APPID,@"data":jsonDic,@"sign":sign};
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
    //获取加密的sign
    NSString *sign = [self getMD5StrMethod:@"getUserAllScoreWithPage" andData:jsonDic andAppId:APPID andAppKey:APPKEY];
    NSDictionary *params=@{@"method":@"getUserAllScoreWithPage",@"appid":APPID,@"data":jsonDic,@"sign":sign};
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
    //获取加密的sign
    NSString *sign = [self getMD5StrMethod:@"chgpass" andData:jsonDic andAppId:APPID andAppKey:APPKEY];
    NSDictionary *params=@{@"method":@"chgpass",@"appid":APPID,@"data":jsonDic,@"sign":sign};
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
    //获取加密的sign
    NSString *sign = [self getMD5StrMethod:@"dobjzh" andData:jsonDic andAppId:APPID andAppKey:APPKEY];
    NSDictionary *params=@{@"method":@"dobjzh",@"appid":APPID,@"data":jsonDic,@"sign":sign};
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
    //获取加密的sign
    NSString *sign = [self getMD5StrMethod:@"getAllHotFoodList" andData:jsonDic andAppId:APPID andAppKey:APPKEY];
    NSDictionary *params=@{@"method":@"getAllHotFoodList",@"appid":APPID,@"data":jsonDic,@"sign":sign};
    //3.发生请求
    [mgr POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"请求成功--");
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败-%@",error);
    }];
}

#pragma mark 删除自制菜信息
/**
 * 删除自制菜信息
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)delSelfFood:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    //2.拼接参数
    NSString *jsonDic=[RequestData getJsonStr:data];
    //获取加密的sign
    NSString *sign = [self getMD5StrMethod:@"delSelfFood" andData:jsonDic andAppId:APPID andAppKey:APPKEY];
    NSDictionary *params=@{@"method":@"delSelfFood",@"appid":APPID,@"data":jsonDic,@"sign":sign};
    //3.发生请求
    [mgr POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"请求成功--");
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败-%@",error);
    }];
}

#pragma mark 编辑自制菜信息
/**
 * 编辑自制菜信息
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)saveSelfFood:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    //2.拼接参数
    NSString *jsonDic=[RequestData getJsonStr:data];
    //获取加密的sign
    NSString *sign = [self getMD5StrMethod:@"saveSelfFood" andData:jsonDic andAppId:APPID andAppKey:APPKEY];
    NSDictionary *params=@{@"method":@"saveSelfFood",@"appid":APPID,@"data":jsonDic,@"sign":sign};
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
/**
 *  添加评论
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)addFoodComment:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    NSString *jsonDic=[RequestData getJsonStr:data];
    //获取加密的sign
    NSString *sign = [self getMD5StrMethod:@"addFoodComment" andData:jsonDic andAppId:APPID andAppKey:APPKEY];
    NSDictionary *params=@{@"method":@"addFoodComment",@"appid":APPID,@"data":jsonDic,@"sign":sign};
    [mgr POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"添加请求成功--");
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"数据请求失败-%@",error);
    }];
}
/**
 *  取消订单
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)orderCancel:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    NSString *jsonDic=[RequestData getJsonStr:data];
    //获取加密的sign
    NSString *sign = [self getMD5StrMethod:@"orderCancel" andData:jsonDic andAppId:APPID andAppKey:APPKEY];
    NSDictionary *params=@{@"method":@"orderCancel",@"appid":APPID,@"data":jsonDic,@"sign":sign};
    [mgr POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"添加请求成功--");
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"数据请求失败-%@",error);
    }];
}
/**
 *  获取用户所有的送货地址信息
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)getAllUserSendAddressByUserid:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    NSString *jsonDic=[RequestData getJsonStr:data];
    //获取加密的sign
    NSString *sign = [self getMD5StrMethod:@"getAllUserSendAddressByUserid" andData:jsonDic andAppId:APPID andAppKey:APPKEY];
    NSDictionary *params=@{@"method":@"getAllUserSendAddressByUserid",@"appid":APPID,@"data":jsonDic,@"sign":sign};
    [mgr POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"添加请求成功--");
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"数据请求失败-%@",error);
    }];
}

/**
 *  获取用户所有的送货地址信息
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)getUserSendAddressById:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    NSString *jsonDic=[RequestData getJsonStr:data];
    //获取加密的sign
    NSString *sign = [self getMD5StrMethod:@"getUserSendAddressById" andData:jsonDic andAppId:APPID andAppKey:APPKEY];
    NSDictionary *params=@{@"method":@"getUserSendAddressById",@"appid":APPID,@"data":jsonDic,@"sign":sign};
    [mgr POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"添加请求成功--");
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"数据请求失败-%@",error);
    }];
}
/**
 *  添加或修改用户送货地址信息
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)saveUserSendAddress:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    NSString *jsonDic=[RequestData getJsonStr:data];
    //获取加密的sign
    NSString *sign = [self getMD5StrMethod:@"saveUserSendAddress" andData:jsonDic andAppId:APPID andAppKey:APPKEY];
    NSDictionary *params=@{@"method":@"saveUserSendAddress",@"appid":APPID,@"data":jsonDic,@"sign":sign};
    [mgr POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"添加请求成功--");
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"数据请求失败-%@",error);
    }];
}
/**
 *  删除用户送货地址信息
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)delUserSendAddress:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    NSString *jsonDic=[RequestData getJsonStr:data];
    //获取加密的sign
    NSString *sign = [self getMD5StrMethod:@"delUserSendAddress" andData:jsonDic andAppId:APPID andAppKey:APPKEY];
    NSDictionary *params=@{@"method":@"delUserSendAddress",@"appid":APPID,@"data":jsonDic,@"sign":sign};
    [mgr POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"添加请求成功--");
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"数据请求失败-%@",error);
    }];
}
/**
 *  修改用户送货地址为默认地址
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)updateIsdefault:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    NSString *jsonDic=[RequestData getJsonStr:data];
    //获取加密的sign
    NSString *sign = [self getMD5StrMethod:@"updateIsdefault" andData:jsonDic andAppId:APPID andAppKey:APPKEY];
    NSDictionary *params=@{@"method":@"updateIsdefault",@"appid":APPID,@"data":jsonDic,@"sign":sign};
    [mgr POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"添加请求成功--");
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"数据请求失败-%@",error);
    }];
}
/**
 *  根据地址、电话、姓名，获取用户所有的送货地址信息
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)getAllUserSendAddressByAddressPhoneName:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    NSString *jsonDic=[RequestData getJsonStr:data];
    //获取加密的sign
    NSString *sign = [self getMD5StrMethod:@"getAllUserSendAddressByAddressPhoneName" andData:jsonDic andAppId:APPID andAppKey:APPKEY];
    NSDictionary *params=@{@"method":@"getAllUserSendAddressByAddressPhoneName",@"appid":APPID,@"data":jsonDic,@"sign":sign};
    [mgr POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"添加请求成功--");
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"数据请求失败-%@",error);
    }];
}


//获得md5加密后的字符串
+(NSString*) getMD5StrMethod:(NSString*) method andData:(NSString*) data andAppId :(NSString*) appid andAppKey:(NSString*) appkey
{
    //设置需要加密的字符串
    NSMutableString * str = [NSMutableString stringWithCapacity:4];
    [str appendString:method];
    [str appendString:data];
    [str appendString:appid];
    [str appendString:appkey];
    
    //去除空格和\n
    NSString *resString =
    [[str stringByReplacingOccurrencesOfString:@" " withString:@""]
     stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    const char *cStr = [resString UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
@end
