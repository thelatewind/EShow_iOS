//
//  Login.m
//  EShowIOS
//
//  Created by 王迎军 on 2017/6/2.
//  Copyright © 2017年 王迎军. All rights reserved.
//

#import "Login.h"


#define kLoginStatus @"login_status"
@implementation Login

+ (void)doLogin:(NSDictionary *)loginData{
    if (loginData) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:loginData[@"user"][@"username"] forKey:@"user.username"];
//        [userDefaults setObject:passwordNum forKey:@"user.password"];
        [userDefaults setObject:loginData[@"user"][@"id"] forKey:@"user.userid"];
        //                                  返回user对象
        [[NSUserDefaults standardUserDefaults] setObject:loginData[@"accessToken"][@"accessToken"] forKey:@"accessTokenLogin"];
        if(![loginData[@"user"][@"photo"] isKindOfClass:[NSNull class]])
        {
            [[NSUserDefaults standardUserDefaults] setObject:loginData[@"user"][@"photo"] forKey:@"user.photo"];
        }
        if (![loginData[@"user"][@"realname"] isKindOfClass:[NSNull class]]) {
            [[NSUserDefaults standardUserDefaults] setObject:loginData[@"user"][@"realname"] forKey:@"realname"];
        }else{
            [[NSUserDefaults standardUserDefaults] setObject:@"未填写" forKey:@"realname"];
        }
        
        if (![loginData[@"user"][@"realname"] isKindOfClass:[NSNull class]]) {
            [[NSUserDefaults standardUserDefaults] setObject:loginData[@"user"][@"realname"] forKey:@"user.realname"];
        } else {
            [[NSUserDefaults standardUserDefaults] setObject:@"未填写" forKey:@"user.realname"];
        }
        
        if (![loginData[@"user"][@"nickname"] isKindOfClass:[NSNull class]]) {
            [[NSUserDefaults standardUserDefaults] setObject:loginData[@"user"][@"nickname"] forKey:@"user.nickname"];
        } else {
            [[NSUserDefaults standardUserDefaults] setObject:@"未填写" forKey:@"user.nickname"];
        }
        
        if (![loginData[@"user"][@"age"] isKindOfClass:[NSNull class]]) {
            [[NSUserDefaults standardUserDefaults] setInteger:[loginData[@"user"][@"age"] intValue]forKey:@"user.age"];
        } else {
            [[NSUserDefaults standardUserDefaults] setObject:@"未填写" forKey:@"user.age"];
        }
        
        if (![loginData[@"user"][@"male"] isKindOfClass:[NSNull class]]) {
            [[NSUserDefaults standardUserDefaults] setInteger:[loginData[@"user"][@"male"] intValue]forKey:@"user.male"];
        } else {
            [[NSUserDefaults standardUserDefaults] setObject:@"未知" forKey:@"user.male"];
        }
        
        if (![loginData[@"user"][@"email"] isKindOfClass:[NSNull class]]) {
            [[NSUserDefaults standardUserDefaults] setObject:loginData[@"user"][@"email"] forKey:@"user.email"];
        } else {
            [[NSUserDefaults standardUserDefaults] setObject:@"未填写" forKey:@"user.email"];
        }
        
        if (![loginData[@"user"][@"birthday"] isKindOfClass:[NSNull class]]) {
            [[NSUserDefaults standardUserDefaults] setObject:loginData[@"user"][@"birthday"] forKey:@"user.birthday"];
        } else {
            [[NSUserDefaults standardUserDefaults] setObject:@"请选择" forKey:@"user.birthday"];
        }
        
        if (![loginData[@"user"][@"intro"] isKindOfClass:[NSNull class]]) {
            [[NSUserDefaults standardUserDefaults] setObject:loginData[@"user"][@"intro"]forKey:@"user.intro"] ;
        } else {
            [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"user.intro"];
        }
         [userDefaults synchronize];
    }else{
        [Login doLogout];
    }
}
+ (void)doLogout{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithBool:NO] forKey:kLoginStatus];
    [defaults synchronize];
}
@end
