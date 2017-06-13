//
//  MineBankSetInfoViewController.h
//  YiShiBang
//
//  Created by 王迎军 on 2017/6/12.
//  Copyright © 2017年 王迎军. All rights reserved.
//

#import "BaseViewController.h"
typedef void (^BackInfoBlock)(NSString *str);
@interface MineBankSetInfoViewController : BaseViewController
@property(nonatomic,copy)BackInfoBlock backInfoBlock;
@property(nonatomic,strong)NSString *infoStr;
@property(nonatomic,assign)BOOL isNumber;
@end
