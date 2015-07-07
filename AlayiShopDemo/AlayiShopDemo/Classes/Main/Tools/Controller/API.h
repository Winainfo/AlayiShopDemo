//
//  API.h
//  Alayicai
//
//  Created by ibokan on 15/7/3.
//  Copyright (c) 2015年 FiM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface API : NSObject
+(void)netAccess:(NSDictionary*) data
      andMethod :(NSString*) method
         success:(void(^)(NSDictionary *successCode)) mysuccess
          falure:(void(^)(NSError * er)) myfalure;
@end
