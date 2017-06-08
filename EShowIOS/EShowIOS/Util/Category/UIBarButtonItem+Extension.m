//
//  UIBarButtonItem+Extension.m
//  新浪微博
//
//  Created by 季金勇 on 15/11/24.
//  Copyright © 2015年 _lanre. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//    [btn setTitle:@"点击" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    // 设置图片
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage]  forState:UIControlStateHighlighted];
    // 设置尺寸
//    btn.size = btn.currentBackgroundImage.size;
    btn.size = CGSizeMake(25, 25);
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
