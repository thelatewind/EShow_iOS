//
//  AppDelegate.h
//  EShowIOS
//
//  Created by 王迎军 on 2016/11/12.
//  Copyright © 2016年 王迎军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
- (void)setupTabViewController;
- (void)setupIntroductionViewController;
- (void)setupLoginViewController;
- (void)setupRegisterViewController;

@end

