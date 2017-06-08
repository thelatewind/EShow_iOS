//
//  NSObject+Common.h
//  EShowIOS
//
//  Created by 王迎军 on 2017/6/1.
//  Copyright © 2017年 王迎军. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Common)

+ (NSString *)baseURLStr;
+ (void)showHudTipStr:(NSString *)tipStr;

#pragma mark NetError
-(id)handleResponse:(id)responseJSON;
-(id)handleResponse:(id)responseJSON autoShowError:(BOOL)autoShowError;
@end
