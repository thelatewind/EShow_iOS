//
//  SetMobileViewController.h
//  EShowIOS
//
//  Created by 王迎军 on 16/8/9.
//  Copyright © 2016年 金璟. All rights reserved.
//

#import "BaseViewController.h"

@interface SetMobileViewController : BaseViewController
@property (strong, nonatomic) NSString *thirdPartyID;     //第三方平台的口令
@property (strong, nonatomic) NSString *thirdPartyIcon;   //第三方平台的头像
@property (strong, nonatomic) NSString *thirdPartyNickName;
@property (strong, nonatomic) NSString *thirdPartyType;
@end
