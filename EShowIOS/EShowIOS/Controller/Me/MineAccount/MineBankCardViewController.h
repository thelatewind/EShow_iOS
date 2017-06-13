//
//  MineBankCardViewController.h
//  YiShiBang
//
//  Created by 王迎军 on 2017/6/12.
//  Copyright © 2017年 王迎军. All rights reserved.
//

#import "BaseViewController.h"
typedef void (^BackBankBlock)(NSString *str);
@interface MineBankCardViewController : BaseViewController
@property(nonatomic,copy)BackBankBlock backBankBlock;

@end
