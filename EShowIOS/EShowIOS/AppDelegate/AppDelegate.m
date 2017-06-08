//
//  AppDelegate.m
//  EShowIOS
//
//  Created by 王迎军 on 2016/11/12.
//  Copyright © 2016年 王迎军. All rights reserved.
//

#import "AppDelegate.h"
#import "IntroductionViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "RootTabViewController.h"


#import "EShowNetAPIClient.h"

#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocial.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.4
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //判断是否登录
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *isLogin = [userDefault objectForKey:@"user.password"];
    
    //设置友盟AppKey
    [UMSocialData setAppKey:@"56ceca68e0f55a2ece000d68"];
    //友盟第三方登录
    [UMSocialQQHandler setQQWithAppId:@"1105423356" appKey:@"TdaUYNbEZM2AHdEM" url:@"http://www.umeng.com/social"];
    [UMSocialWechatHandler setWXAppId:@"wx924e88ce094d3c17" appSecret:@"9232387cdab41d34db6b741503cdb3c7" url:@"http://www.umeng.com/social"];
    
    
    
    
    [[EShowNetAPIClient sharedJsonClient] requestJsonDataWithPath:@"http://bangqu.com/shop/product-order/save.json" withParams:@{@"addressId":@"1",@"cartIds":@"233",@"accessToken":@"1",@"couponId":@"1",@"productOrder.no":@"213564"} withMethodType:Post andBlock:^(id data, NSError *error) {
        
    }];
    
    [self customizeInterface];
    [self setupIntroductionViewController];
    
    [self.window makeKeyAndVisible];
   
    //设置启动图时间
    [NSThread sleepForTimeInterval:1.0];
    return YES;
}




#pragma mark - Methods Private
- (void)setupTabViewController{
    RootTabViewController *root_vc = [[RootTabViewController alloc] init];
    [self.window setRootViewController:root_vc];
}
- (void)setupIntroductionViewController{
    IntroductionViewController *introductionVC = [[IntroductionViewController alloc] init];
    [self.window setRootViewController:introductionVC];
}
- (void)setupLoginViewController{
    LoginViewController *login = [[LoginViewController alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:login];
    [self.window setRootViewController:nav];
}
- (void)setupRegisterViewController{
    RegisterViewController *regist = [[RegisterViewController alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:regist];
    [self.window setRootViewController:nav];
}
- (void)customizeInterface {
    //设置Nav的背景色和title色
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    [navigationBarAppearance setBackgroundColor:[UIColor whiteColor]];
    [navigationBarAppearance setTintColor:[UIColor colorWithRed:(247 / 255.0f) green:(105 / 255.0f) blue:(86 / 255.0f) alpha:1]];//返回按钮的箭头颜色
    NSDictionary *textAttributes = @{
                                     NSFontAttributeName: [UIFont boldSystemFontOfSize:kNavTitleFontSize],
                                     NSForegroundColorAttributeName: [UIColor colorWithRed:(247 / 255.0f) green:(105 / 255.0f) blue:(86 / 255.0f) alpha:1],
                                     };
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma umSocial
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}

@end
