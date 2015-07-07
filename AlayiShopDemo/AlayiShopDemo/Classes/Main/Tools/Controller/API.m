//
//  API.m
//  Alayicai
//
//  Created by ibokan on 15/7/3.
//  Copyright (c) 2015年 FiM. All rights reserved.
//

#import "API.h"
#import "AFNetworking.h"

#define APPID @"1001"
#define URL @"http://www.alayicai.com/service"

@interface API()
@property(retain,nonatomic)NSDictionary *returnData;
@end

@implementation API

//创建管理器
+(AFHTTPRequestOperationManager*) getManager{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    return manager;
}
//传入dic  返回json
+(NSString*)getJsonStr:(NSDictionary*)dic{
    NSError *error = nil;
    //将字典转化为json data
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
//通用网络访问方法
+(void)netAccess:(NSDictionary*) data
      andMethod :(NSString*) method
         success:(void(^)(NSDictionary *successCode)) mysuccess
          falure:(void(^)(NSError * er)) myfalure{
    //获取管理器对象
    AFHTTPRequestOperationManager *ma=[API getManager];
    NSDictionary *dic=[NSDictionary new];
    if (data!=nil) {
        //字典转换为JSON
        NSString *jsonDic = [API getJsonStr:data];
        //创建请求参数字典
        dic=@{@"method":method,@"appid":APPID,@"data":jsonDic};
    }else{
        dic=nil;
    }
    
    [ma POST:URL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //将JSON解析成字典
        NSDictionary*resDict = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        mysuccess(resDict);
//        NSLog(@"%@",resDict);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        myfalure(error);
    }];
}
@end
