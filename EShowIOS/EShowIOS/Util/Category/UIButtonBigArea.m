//
//  UIButtonBigArea.m
//  masonry
//
//  Created by jun.wang on 15/12/18.
//  Copyright © 2015年 jun.wang. All rights reserved.
//

#import "UIButtonBigArea.h"

@implementation UIButtonBigArea



- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    CGRect rectBig = CGRectInset(self.bounds, -(self.extraWidth/2), -(self.extraHeight/2));
    if (CGRectContainsPoint(rectBig, point)) {
        return self;
    }else{
        return nil;
    }
    return self;
}



@end
