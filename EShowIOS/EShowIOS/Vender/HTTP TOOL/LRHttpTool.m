//
//  LRHttpTool.m
//  06-友盟登陆
//
//  Created by 123 on 16/1/21.
//  Copyright © 2016年 123. All rights reserved.
//

#import "LRHttpTool.h"
#import "AFNetworking.h"

@implementation LRHttpTool

+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置请求的  contentType
    [mgr.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    mgr.responseSerializer.acceptableContentTypes = [mgr.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    mgr.responseSerializer.acceptableContentTypes = [mgr.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    // 设置超时
    [mgr POST:URLString parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        WBLog(@"--%@,fengzhuang%@",responseObject,[NSThread currentThread]);
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if (failure) {

            // 打印下错误信息
//            [MBProgressHUD showError:@"网络连接失败"];
            WBLog(@"---打印错误信息---%@",error.localizedDescription);
            failure(error);
        }
    }];
}
// 苹果系统自带的方法
+ (void)ConnectionPOST:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure
{
    NSString *encodeStr = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:encodeStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval = 3.0f;
    request.HTTPMethod = @"POST";
    //    // 参数
    //    NSMutableDictionary *canshu = [NSMutableDictionary dictionary];
    //    canshu[@"openId"] = @"F7BDFE5C01FF24D77AA0AD582514DD3A";
    //    canshu[@"nickName"] = @"dfgsdf";
    //    canshu[@"cooperativeAccount"] = @"sinaBlog";
    //    canshu[@"icon"] = @"http://qzapp.qlogo.cn/qzapp/100424468/F7BDFE5C01FF24D77AA0AD582514DD3A/100";
    //    canshu[@"loginType"] = @2;
    NSData *dataJson = [NSJSONSerialization dataWithJSONObject:parameters options:nil error:nil];
    request.HTTPBody = dataJson;
    //    // 一部请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        WBLog(@"-------------%s-----%@",__func__,data);
//        NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        WBLog(@"-------------%s-----%@",__func__,dataStr);
        success(dataStr);
    }];

}


// 苹果系统自带的get方法
+ (void)ConnectionGET:(NSString *)URLString
            parameters:(id)parameters
               success:(void (^)(id responseObject))success
               failure:(void (^)(NSError *error))failure
{
    NSURL *url = [NSURL URLWithString:URLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:([NSOperationQueue mainQueue]) completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSDictionary *responseObjc = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        WBLog(@"responseObjc ----%@",responseObjc);
        success(responseObjc);
    }];
}






// get请求
+ (void)GET:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(id responseObject))success
                        failure:(void (^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [mgr.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    mgr.responseSerializer.acceptableContentTypes = [mgr.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
//    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
//        mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    //    mgr.responseSerializer = [AFHTTPRequestSerializer serializer];
    [mgr GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            // 打印下错误信息
            WBLog(@"---打印错误信息---%@",error.description);
            failure(error);
        }

    }];
}




// get请求
+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
    setRequestSerializer:(AFHTTPResponseSerializer *)responseSerializer
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = responseSerializer;
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer]; // 序列化起
    //    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    //        mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    //    mgr.responseSerializer = [AFHTTPRequestSerializer serializer];
    [mgr GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            
            WBLog(@"---打印错误信息---%@",error.description);
            failure(error);
        }
        
    }];
}
@end



