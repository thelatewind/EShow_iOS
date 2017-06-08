//
//  EShowNetAPIClient.m
//  EShowIOS
//
//  Created by 王迎军 on 2017/6/1.
//  Copyright © 2017年 王迎军. All rights reserved.
//

#define kNetworkMethodName @[@"Get", @"Post", @"Put", @"Delete"]

#import "EShowNetAPIClient.h"

@implementation EShowNetAPIClient{
    NSTimer *timer;
    int timeCount;
}

static EShowNetAPIClient *_sharedClient = nil;
static dispatch_once_t onceToken;
+ (EShowNetAPIClient *)sharedJsonClient {
    dispatch_once(&onceToken, ^{
        _sharedClient = [[EShowNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:[NSObject baseURLStr]]];
    });
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
    
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [self.requestSerializer setValue:url.absoluteString forHTTPHeaderField:@"Referer"];
    
    self.securityPolicy.allowInvalidCertificates = YES;
    timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
    timeCount = 0;
    return self;
}

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(NetworkMethod)method
                       andBlock:(void (^)(id data, NSError *error))block{
    [self requestJsonDataWithPath:aPath withParams:params withMethodType:method autoShowError:YES andBlock:block];
}

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(NetworkMethod)method
                  autoShowError:(BOOL)autoShowError
                       andBlock:(void (^)(id data, NSError *error))block{
    if (!aPath || aPath.length <= 0) {
        return;
    }
    //log请求数据
    NSLog(@"\n===========request===========\n%@\n%@:\n%@", kNetworkMethodName[method], aPath, params);
    aPath = [aPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //    发起请求
    switch (method) {
        case Get:{
            //所有 Get 请求，增加缓存机制
            NSMutableString *localPath = [aPath mutableCopy];
            if (params) {
                [localPath appendString:params.description];
            }
            [self GET:aPath parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                block(responseObject, nil);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"\n===========response===========\n%@:\n%@\n%@", aPath, error, operation.responseString);
                block(nil, error);
            }];
            break;}
        case Post:{
            [self POST:aPath parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                NSDictionary *paramdict = @{@"appSecret":@"rg3pVd22g31Fv1mF",
                                            @"appKey":@"ZY4X2HYwhLIU9smY",
                                            @"record.mode":@"POST",
                                            @"record.url":aPath,
                                            @"record.params":[self convertToJsonData:params],
                                            @"record.network":@"4G",
                                            @"record.versionName":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                                            @"record.model":[[UIDevice currentDevice] model],
                                            @"record.osName":@"iPhone",
                                            @"record.responseTime":[NSString stringWithFormat:@"%zd",timeCount],
                                            @"record.responseSize":[NSString stringWithFormat:@"%zd",[[self convertToJsonData:responseObject] length]],
                                            @"record.statusCode":[NSString stringWithFormat:@"%zd",operation.response.statusCode],
                                            @"record.crash":@"NO",
                                            @"record.result":[self convertToJsonData:responseObject],
                                            @"record.versionCode":[[UIDevice currentDevice] systemVersion],};
                [self POST:@"https://api.monitor.easyapi.com/record/save.json" parameters:paramdict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                    
                } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
                    
                }];
                if ([responseObject[@"status"] intValue] == 1) {
                    block(responseObject, nil);
                }else{
                    [NSObject showHudTipStr:responseObject[@"msg"]];
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"\n===========response===========\n%@:\n%@\n%@\n%zd\n%zd", aPath, error, operation.responseString,error.code,operation.response.statusCode);
                NSLog(@"%ld",[[NSString stringWithFormat:@"%@",[error.userInfo objectForKey:@"NSUnderlyingError"]] length]);
                NSDictionary *paramdict = @{@"appSecret":@"rg3pVd22g31Fv1mF",
                                            @"appKey":@"ZY4X2HYwhLIU9smY",
                                            @"record.mode":@"POST",
                                            @"record.url":aPath,
                                            @"record.params":[self convertToJsonData:params],
                                            @"record.network":@"4G",
                                            @"record.versionName":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
                                            @"record.model":[[UIDevice currentDevice] model],
                                            @"record.osName":@"iPhone",
                                            @"record.responseTime":[NSString stringWithFormat:@"%zd",timeCount],
                                            @"record.responseSize":[NSString stringWithFormat:@"%zd",[[NSString stringWithFormat:@"%@",[error.userInfo objectForKey:@"NSUnderlyingError"]] length]],
                                            @"record.statusCode":[NSString stringWithFormat:@"%zd",operation.response.statusCode],
                                            @"record.crash":@"NO",
                                            @"record.result":[error.userInfo objectForKey:@"NSUnderlyingError"],
                                            @"record.versionCode":[[UIDevice currentDevice] systemVersion],};
                [self POST:@"https://api.monitor.easyapi.com/record/save.json" parameters:paramdict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                    
                } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
                    
                }];
                 NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
                 if (errorStr.length > 0) {
                     [NSObject showHudTipStr:errorStr];
                 }else{
                     [NSObject showHudTipStr:@"Requst Failed:bad gateway (502)"];
                 }
            }];
            
            
            
            break;}
        case Put:{
            [self PUT:aPath parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                block(responseObject, nil);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"\n===========response===========\n%@:\n%@\n%@", aPath, error, operation.responseString);
                block(nil, error);
            }];
            break;}
        case Delete:{
            [self DELETE:aPath parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                block(responseObject, nil);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"\n===========response===========\n%@:\n%@\n%@", aPath, error, operation.responseString);
                block(nil, error);
            }];
            break;}
        default:
            break;
    }
    
}
- (void)timeAction{
    timeCount ++;
}
-(NSString *)convertToJsonData:(NSDictionary *)dict{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}
@end
