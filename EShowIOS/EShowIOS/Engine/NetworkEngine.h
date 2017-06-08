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
//typedef void(^SuccessBlock)(id responseBody);
//
//typedef void(^FailureBlock)(id error);

@interface NetworkEngine : NSObject

//+(NetworkEngine *)sharedManager;
//-(AFHTTPRequestOperationManager *)baseHtppRequest;
//
//- (void)PostParameter:(NSDictionary *)parameter url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

+ (instancetype)sharedManager;

#pragma mark User
- (void)request_Login_WithParams:(NSDictionary *)params andBlock:(void (^)(id data, NSError *error))block;
- (void)request_Login_Captcha_WithParams:(NSDictionary *)params andBlock:(void (^)(id data, NSError *error))block;
- (void)request_Login_Third_WithParams:(NSDictionary *)params andBlock:(void (^)(id data, NSError *error))block;
- (void)request_Send_Captcha_WithParams:(NSDictionary *)params andBlock:(void (^)(id data, NSError *error))block;
- (void)request_Reset_Password_WithParams:(NSDictionary *)params andBlock:(void (^)(id data, NSError *error))block;
- (void)request_Register_WithParams:(NSDictionary *)params andBlock:(void (^)(id data, NSError *error))block;
- (void)request_Bind_Third_WithParams:(NSDictionary *)params andBlock:(void (^)(id data, NSError *error))block;

@end
