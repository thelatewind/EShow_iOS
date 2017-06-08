//
//  NSString+changeNum.h
//  test
//
//  Created by Yuri on 16/9/12.
//  Copyright © 2016年 Yuri. All rights reserved.
//


/**
 *  将阿拉伯数字转换为中文数字
 */
#import <Foundation/Foundation.h>

@interface NSString (changeNum)
+(NSString *)translationArabicNum:(NSInteger)arabicNum;
@end
