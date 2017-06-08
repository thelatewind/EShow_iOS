//
//  NSObject+Common.m
//  EShowIOS
//
//  Created by 王迎军 on 2017/6/1.
//  Copyright © 2017年 王迎军. All rights reserved.
//

#import "NSObject+Common.h"

@implementation NSObject (Common)





#pragma mark NetError
-(id)handleResponse:(id)responseJSON{
    return [self handleResponse:responseJSON autoShowError:YES];
}
-(id)handleResponse:(id)responseJSON autoShowError:(BOOL)autoShowError{
    NSError *error = nil;
    //code为非0值时，表示有错
    NSInteger errorCode = [(NSNumber *)[responseJSON valueForKeyPath:@"code"] integerValue];
    
//    if (errorCode != 0) {
//        error = [NSError errorWithDomain:[NSObject baseURLStr] code:errorCode userInfo:responseJSON];
//        if (errorCode == 1000 || errorCode == 3207) {//用户未登录
////            if ([Login isLogin]) {
////                [Login doLogout];//已登录的状态要抹掉
////                //更新 UI 要延迟 >1.0 秒，否则屏幕可能会不响应触摸事件。。暂不知为何
////                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////                    [((AppDelegate *)[UIApplication sharedApplication].delegate) setupLoginViewController];
////                    kTipAlert(@"%@", [NSObject tipFromError:error]);
////                });
////            }
//        }else{
//            //验证码弹窗
//            NSMutableDictionary *params = nil;
//            if (errorCode == 907) {//operation_need_captcha 比如：每日新增关注用户超过 20 个
//                params = @{@"type": @3}.mutableCopy;
//            }else if (errorCode == 1018){//user_not_get_request_too_many
//                params = @{@"type": @1}.mutableCopy;
//            }
//            if (params) {
//                [NSObject showCaptchaViewParams:params];
//            }
//            //错误提示
//            if (autoShowError) {
//                [NSObject showError:error];
//            }
//        }
//    }
    return error;
}
#pragma mark BaseURL
+ (NSString *)baseURLStr{
    NSString *baseURLStr;
//    if ([self baseURLStrIsTest]) {
//        //staging
//        baseURLStr = kBaseUrlStr_Test;
//    }else{
        //生产
        baseURLStr = @"http://api.eshow.org.cn/";
//    }
    return baseURLStr;
}
+ (void)showHudTipStr:(NSString *)tipStr{
    if (tipStr && tipStr.length > 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabelFont = [UIFont boldSystemFontOfSize:15.0];
        hud.detailsLabelText = tipStr;
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:2.0];
    }
}
@end
