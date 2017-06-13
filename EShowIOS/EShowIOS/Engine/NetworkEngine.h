//
//  NetworkEngine.h
//  EShowIOS
//
//  Created by 王迎军 on 2016/11/23.
//  Copyright © 2016年 王迎军. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"
//请求超时
#define TIMEOUT 30


@interface NetworkEngine : NSObject

+ (instancetype)sharedManager;

#pragma mark User
- (void)request_Login_WithParams:(NSDictionary *)params andBlock:(void (^)(id data, NSError *error))block;
- (void)request_Login_Captcha_WithParams:(NSDictionary *)params andBlock:(void (^)(id data, NSError *error))block;
- (void)request_Login_Third_WithParams:(NSDictionary *)params andBlock:(void (^)(id data, NSError *error))block;
- (void)request_Send_Captcha_WithParams:(NSDictionary *)params andBlock:(void (^)(id data, NSError *error))block;
- (void)request_Reset_Password_WithParams:(NSDictionary *)params andBlock:(void (^)(id data, NSError *error))block;
- (void)request_Register_WithParams:(NSDictionary *)params andBlock:(void (^)(id data, NSError *error))block;
- (void)request_Bind_Third_WithParams:(NSDictionary *)params andBlock:(void (^)(id data, NSError *error))block;



#pragma mark Account
- (void)request_Save_AlipayAccount_WithParams:(NSDictionary *)params andBlock:(void (^)(id data, NSError *error))block;
- (void)request_Save_WeiXinAccount_WithParams:(NSDictionary *)params andBlock:(void (^)(id data, NSError *error))block;
- (void)request_Save_BankCardAccount_WithParams:(NSDictionary *)params andBlock:(void (^)(id data, NSError *error))block;
- (void)request_BankCardList_WithParams:(NSDictionary *)params andBlock:(void (^)(id data, NSError *error))block;

@end
