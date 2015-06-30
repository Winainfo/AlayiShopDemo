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
#pragma mark 登录
/**
 *  登录接口
 *
 *  @param data  <#data description#>
 *  @param block <#block description#>
 */
+(void)lgin:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSString *))block
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    NSString *jsonDic=[RequestData getJsonStr:data];
    NSDictionary *params=@{@"method":@"login",@"appid":APPID,@"data":jsonDic};
    [mgr POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"登录请求成功-----%@",responseObject[@"code"]);
        block(responseObject[@"code"]);
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
+(void)getFoodSortList:(NSDictionary *)data FinishCallbackBlock:(void (^)(NSDictionary *))block
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    NSString *jsonDic=[RequestData getJsonStr:data];
    NSDictionary *params=@{@"method":@"getFoodSortList",@"appid":APPID,@"data":jsonDic};
    [mgr POST:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"分类请求成功-----%@",responseObject);
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"分类请求失败-%@",error);
    }];
}

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
+(void)setCode:(NSString *)Uid addToken:(NSString *)Token andCode:(NSString *)Code FinishCallbackBlock:(void (^)(NSString *, NSString *))block
{
    //请求路径:http://1.youngcouple.sinaapp.com/setCode.php
    /**
     请求参数
     access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
     uid	false	int64	需要查询的用户ID。
     code 验证码
     参数uid与screen_name二者必选其一，且只能选其一；
     */
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    mgr.responseSerializer=[AFJSONResponseSerializer serializer];
    //2.拼接请求参数
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"uid"]=Uid;
    params[@"access_token"]=Token;
    params[@"code"]=Code;
    //3.发生请求
    [mgr GET:@"http://1.youngcouple.sinaapp.com/setCode.php" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"请求成功-----%@",responseObject);
        block(responseObject[@"uida"],responseObject[@"success"]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败-%@",error);
    }];
}
@end
