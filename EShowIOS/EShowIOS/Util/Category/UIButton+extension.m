//
//  UIButton+extension.m
//  XinJia
//
//  Created by 季金勇 on 16/5/23.
//  Copyright © 2016年 金璟. All rights reserved.
//

#import "UIButton+extension.h"

@implementation UIButton (extension)

+ (UIButton *)buttonWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage disableImage:(NSString *)disableImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.backgroundColor = [JKUtil getColor:@"8cc152"];
//    UIImage *normalImg = [UIImage imageNamed:image];
//    UIImage *highImg = [UIImage imageNamed:highImage];
//    UIImage *disImg = [UIImage imageNamed:disableImage];
    UIImage *normalImg = [UIImage imageWithColor:KTabbarNormalColor];
    UIImage *highImg = [UIImage imageWithColor:KTabbarSelectedColor];
    UIImage *disImg = [UIImage imageWithColor:[UIColor colorWithRed:0.89 green:0.54 blue:0.50 alpha:1]];
    normalImg = [JKUtil stretchImage:normalImg capInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    highImg = [JKUtil stretchImage:highImg capInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    disImg = [JKUtil stretchImage:disImg capInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    [btn setBackgroundImage:normalImg forState:UIControlStateNormal];
    [btn setBackgroundImage:highImg forState:UIControlStateHighlighted];
    [btn setBackgroundImage:disImg forState:UIControlStateDisabled];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}


+ (UIButton *)buttonWithStretchImageAndTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage selectImage:(NSString *)selectImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    btn.backgroundColor = [JKUtil getColor:@"8cc152"];
    UIImage *normalImg = [UIImage imageNamed:image];
    UIImage *highImg = [UIImage imageNamed:highImage];
    UIImage *selImage = [UIImage imageNamed:selectImage];
    normalImg = [JKUtil stretchImage:normalImg capInsets:UIEdgeInsetsMake(30, 30, 30, 30) resizingMode:UIImageResizingModeStretch];
    highImg = [JKUtil stretchImage:highImg capInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    selImage = [JKUtil stretchImage:selImage capInsets:UIEdgeInsetsMake(30, 30, 30, 30) resizingMode:UIImageResizingModeStretch];
    [btn setBackgroundImage:normalImg forState:UIControlStateNormal];
    [btn setBackgroundImage:highImg forState:UIControlStateHighlighted];
    [btn setBackgroundImage:selImage forState:UIControlStateSelected];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

+ (UIButton *)buttonWithSmallStretchImageAndTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage selectImage:(NSString *)selectImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    btn.backgroundColor = [JKUtil getColor:@"8cc152"];
    UIImage *normalImg = [UIImage imageNamed:image];
    UIImage *highImg = [UIImage imageNamed:highImage];
    UIImage *selImage = [UIImage imageNamed:selectImage];
    normalImg = [JKUtil stretchImage:normalImg capInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    highImg = [JKUtil stretchImage:highImg capInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    selImage = [JKUtil stretchImage:selImage capInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    [btn setBackgroundImage:normalImg forState:UIControlStateNormal];
    [btn setBackgroundImage:highImg forState:UIControlStateHighlighted];
    [btn setBackgroundImage:selImage forState:UIControlStateSelected];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (UIImage *)resizeImage:(NSString *)image
{
    UIEdgeInsets insets = UIEdgeInsetsMake(10, 10, 10, 10);
    UIImage *img = [UIImage imageNamed:image];
    img = [img resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    return img;
}

@end
