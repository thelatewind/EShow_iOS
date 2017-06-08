//
//  UIButton+extension.h
//  XinJia
//
//  Created by 季金勇 on 16/5/23.
//  Copyright © 2016年 金璟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (extension)

+ (UIButton *)buttonWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage disableImage:(NSString *)disableImage;

+ (UIButton *)buttonWithStretchImageAndTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage selectImage:(NSString *)selectImage;
+ (UIButton *)buttonWithSmallStretchImageAndTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage selectImage:(NSString *)selectImage;

@end
