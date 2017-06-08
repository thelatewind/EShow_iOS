//
//  UIView+Extension.m
//  黑马微博2期
//
//  Created by apple on 14-10-7.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "UIView+lr_Extension.h"

@implementation UIView (Extension)

- (void)setLr_x:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setLr_y:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)lr_x
{
    return self.frame.origin.x;
}

- (CGFloat)lr_y
{
    return self.frame.origin.y;
}

- (void)setLr_width:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setLr_height:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)lr_height
{
    return self.frame.size.height;
}

- (CGFloat)lr_width
{
    return self.frame.size.width;
}

- (void)setLr_size:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)lr_size
{
    return self.frame.size;
}

- (void)setLr_origin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)lr_origin
{
    return self.frame.origin;
}
- (void)setLr_centerX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)lr_centerX
{
    return self.center.x;
}

- (void)setLr_centerY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)lr_centerY
{
    return self.center.y;
}

- (void)setLr_top:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)lr_top
{
    return self.frame.origin.y;
}

- (void)setLr_bottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)lr_bottom
{
    return CGRectGetMaxY(self.frame);
}

- (void)setLr_right:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)lr_right
{
    return CGRectGetMaxX(self.frame);
}

- (void)setLr_left:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)lr_left
{
    return self.frame.origin.x;
}
@end
