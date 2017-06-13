//
//  BaseViewController.m
//  EShowIOS
//
//  Created by 王迎军 on 2016/11/22.
//  Copyright © 2016年 王迎军. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UITextFieldDelegate>

@end

@implementation BaseViewController
+ (BOOL)valiMobile:(NSString *)mobile{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = KTabBackgroundColor;
}
- (UIView *)setView{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}
- (UIButton *)setButton{
    UIButton *btn = [UIButton new];
    [btn setBackgroundImage:[UIImage imageWithColor:KTabbarNormalColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return btn;
}
- (UILabel *)setCellFineLabel{
    UILabel *label = [UILabel new];
    label.textColor = KTabBlackTextColor;
    label.font = [UIFont systemFontOfSize:15];
    return label;
}
#pragma mark - Table view Header Footer
- (UIView *)customHeaderView{
    UIView *headerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 15)];
    headerV.backgroundColor = [UIColor clearColor];
    return headerV;
}
- (UIView *)customFooterView{
    UIView *headerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.04*ScreenHeight)];
    headerV.backgroundColor = [UIColor clearColor];
    return headerV;
}

- (UIButton *)setNormalButton{
    UIButton *btn = [UIButton new];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [btn setTitleColor:KTabbarNormalColor forState:UIControlStateNormal];
    [btn setTitleColor:KTabbarSelectedColor forState:UIControlStateHighlighted];
    return btn;
}
- (UITextField *)setNormalTextField{
    UITextField *text = [UITextField new];
    text.delegate = self;
    text.clearButtonMode = UITextFieldViewModeAlways;
    text.keyboardType = UIKeyboardTypePhonePad;
    return text;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
