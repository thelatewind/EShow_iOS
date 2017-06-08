//
//  NetworkEngine.m
//  EShowIOS
//
//  Created by 王迎军 on 2016/11/23.
//  Copyright © 2016年 王迎军. All rights reserved.
//

#import "NetworkEngine.h"
#import "EShowNetAPIClient.h"
#import "Toast+UIView.h"
@implementation NetworkEngine
+ (instancetype)sharedManager {
    static NetworkEngine *shared_manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        shared_manager = [[self alloc] init];
    });
    return shared_manager;
}
- (void)request_Login_WithParams:(NSDictionary *)params andBlock:(void (^)(id data, NSError *))block{
    [[EShowNetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"user/login.json"] withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            [Login doLogin:data];
            block(data,nil);
        }else{
            block(nil,error);
        }
    }];
}
- (void)request_Login_Captcha_WithParams:(NSDictionary *)params andBlock:(void (^)(id, NSError *))block{
    [[EShowNetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"captcha/login.json"] withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            [Login doLogin:data];
            block(data,nil);
        }else{
            block(nil,error);
        }
    }];
}
- (void)request_Login_Third_WithParams:(NSDictionary *)params andBlock:(void (^)(id, NSError *))block{
    [[EShowNetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"third-party/login.json"] withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            if ([data[@"bind"] intValue] == 1) {
                [Login doLogin:data];
            }
            block(data,nil);
        }else{
            block(nil,error);
        }
    }];
}
- (void)request_Send_Captcha_WithParams:(NSDictionary *)params andBlock:(void (^)(id, NSError *))block{
    [[EShowNetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"captcha/send.json"] withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            [NSObject showHudTipStr:data[@"msg"]];
            block(data,nil);
        }else{
            block(nil,error);
        }
    }];
}
- (void)request_Reset_Password_WithParams:(NSDictionary *)params andBlock:(void (^)(id, NSError *))block{
    [[EShowNetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"forget-password/reset.json"] withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            [NSObject showHudTipStr:data[@"msg"]];
            block(data,nil);
        }else{
            block(nil,error);
        }
    }];
}
- (void)request_Register_WithParams:(NSDictionary *)params andBlock:(void (^)(id, NSError *))block{
    [[EShowNetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"user/signup.json"] withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            [Login doLogin:data];
            [NSObject showHudTipStr:data[@"msg"]];
            block(data,nil);
        }else{
            block(nil,error);
        }
    }];
}
- (void)request_Bind_Third_WithParams:(NSDictionary *)params andBlock:(void (^)(id, NSError *))block{
    [[EShowNetAPIClient sharedJsonClient] requestJsonDataWithPath:[NSString stringWithFormat:@"third-party/save.json"] withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
        if (data) {
            block(data,nil);
        }else{
            block(nil,error);
        }
    }];
}
@end
