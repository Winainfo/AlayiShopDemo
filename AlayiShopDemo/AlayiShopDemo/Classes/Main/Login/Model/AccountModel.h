//
//  AccountModel.h
//  AlayiShopDemo
//
//  Created by 吴金林 on 15/7/2.
//  Copyright (c) 2015年 kolin. All rights reserved.
//

#import <Foundation/Foundation.h>
/**数据模型存进沙盒需要遵循<NSCoding>协议*/
@interface AccountModel : NSObject<NSCoding>
/**用户id*/
@property(retain,nonatomic)NSString *userId;
/**用户名*/
@property (retain,nonatomic)NSString *name;
/**密码*/
@property (retain,nonatomic)NSString *password;
/**积分*/
@property (retain,nonatomic)NSString *pilescore;
/**邮箱*/
@property (retain,nonatomic)NSString *email;
/**性别*/
@property (retain,nonatomic)NSString *sex;
/**电话*/
@property (retain,nonatomic)NSString *telephone;

/**字典转换成数据模型*/
+(instancetype)accountWithDict:(NSDictionary *)dict;
@end
