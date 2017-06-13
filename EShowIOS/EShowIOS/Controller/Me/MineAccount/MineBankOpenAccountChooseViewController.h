//
//  MineBankOpenAccountChooseViewController.h
//  YiShiBang
//
//  Created by 王迎军 on 2017/6/12.
//  Copyright © 2017年 王迎军. All rights reserved.
//

#import "BaseViewController.h"
typedef void (^BackVonseBlock)(NSString *str,NSString *str2);
@interface MineBankOpenAccountChooseViewController : BaseViewController
@property(nonatomic,copy)BackVonseBlock backVonseBlock;

@end
