//
//  LRHttpTool.h
//  06-友盟登陆
//
//  Created by 123 on 16/1/21.
//  Copyright © 2016年 123. All rights reserved.
//  网络请求业务类

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


@interface LRHttpTool : NSObject

/**
 *  post请求
 *
 *  @param URLString   URL
 *  @param parameters  参数
 *  @param success    成功
 *  @param failure    失败
 */
+ (void)POST:(NSString *)URLString
                      parameters:(id)parameters
                         success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure;

/**
 *  get请求
 *
 *  @param URLString  URL
 *  @param parameters 擦数
 *  @param success    成功
 *  @param failure    失败
 */
+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;

+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
setRequestSerializer:(AFHTTPResponseSerializer *)responseSerializer
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;

+ (void)ConnectionGET:(NSString *)URLString
           parameters:(id)parameters
              success:(void (^)(id responseObject))success
              failure:(void (^)(NSError *error))failure;

+ (void)ConnectionPOST:(NSString *)URLString
            parameters:(id)parameters
               success:(void (^)(id responseObject))success
               failure:(void (^)(NSError *error))failure;
@end
