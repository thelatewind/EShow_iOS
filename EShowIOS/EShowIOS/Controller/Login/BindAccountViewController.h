//
//  BindAccountViewController.h
//  EShowIOS
//
//  Created by 王迎军 on 2017/3/28.
//  Copyright © 2017年 王迎军. All rights reserved.
//

#import "BaseViewController.h"

@interface BindAccountViewController : BaseViewController

//@property (strong, nonatomic) NSString *thirdPartyID;

@property (strong, nonatomic) NSString *thirdPartyID;     //第三方平台的口令
@property (strong, nonatomic) NSString *thirdPartyIcon;   //第三方平台的头像
@property (strong, nonatomic) NSString *thirdPartyNickName;
@property (strong, nonatomic) NSString *thirdPartyType;
@end
