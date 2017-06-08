//
//  UIBarButtonItem+Extension.h
//  新浪微博
//
//  Created by 季金勇 on 15/11/24.
//  Copyright © 2015年 _lanre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;

@end
