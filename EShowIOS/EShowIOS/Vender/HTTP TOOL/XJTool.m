//
//  XJTool.m
//  XinJia
//
//  Created by 季金勇 on 16/5/12.
//  Copyright © 2016年 金璟. All rights reserved.
//

#import "XJTool.h"

@implementation XJTool

+(CGRect)sizeForString:(NSString *)aString width:(CGFloat)width height:(CGFloat)height size:(CGFloat)size;
{
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:FONTSIZE(size)]};
    CGRect rect = [aString boundingRectWithSize:CGSizeMake(width, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect;
}

+ (UIImage *)resizedImageWithImage:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

@end
