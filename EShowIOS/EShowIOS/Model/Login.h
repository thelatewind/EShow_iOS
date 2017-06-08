//
//  Login.h
//  EShowIOS
//
//  Created by 王迎军 on 2017/6/2.
//  Copyright © 2017年 王迎军. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Login : NSObject

+ (BOOL) isLogin;
+ (void) doLogin:(NSDictionary *)loginData;
+ (void) doLogout;

@end
