//
//  MineAlipayViewController.h
//  YiShiBang
//
//  Created by 王迎军 on 2017/6/12.
//  Copyright © 2017年 王迎军. All rights reserved.
//

#import "BaseViewController.h"
typedef void (^BackAlipayBlock)(NSString *str);
@interface MineAlipayViewController : BaseViewController
@property(nonatomic,copy)BackAlipayBlock backAlipayBlock;
@end
