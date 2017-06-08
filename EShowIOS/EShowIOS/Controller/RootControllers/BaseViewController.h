//
//  BaseViewController.h
//  EShowIOS
//
//  Created by 王迎军 on 2016/11/22.
//  Copyright © 2016年 王迎军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController


+ (BOOL)valiMobile:(NSString *)mobile;
- (UIButton *)setNormalButton;
- (UITextField *)setNormalTextField;
@end
