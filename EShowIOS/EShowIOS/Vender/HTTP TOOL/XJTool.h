//
//  XJTool.h
//  XinJia
//
//  Created by 季金勇 on 16/5/12.
//  Copyright © 2016年 金璟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XJTool : NSObject

+ (CGRect)sizeForString:(NSString *)aString width:(CGFloat)width height:(CGFloat)height size:(CGFloat)size;

+ (UIImage *)resizedImageWithImage:(NSString *)imageName;
@end
