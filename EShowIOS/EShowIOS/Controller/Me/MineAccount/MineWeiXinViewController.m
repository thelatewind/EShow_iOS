//
//  MineWeiXinViewController.m
//  YiShiBang
//
//  Created by 王迎军 on 2017/6/12.
//  Copyright © 2017年 王迎军. All rights reserved.
//

#import "MineWeiXinViewController.h"
#import "MineBankSetInfoViewController.h"
@interface MineWeiXinViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    UITableView *tableV;
    NSArray *leftTitleArr;
    UITextField *phoneNumField;
    UITextField *verifyNumField;
    UIButton *timeBtn;
    NSString *weixinNum;//微信号
    NSString *weixinName;//姓名
}
@property (strong, nonatomic) UIButton *captchaBtn;
@end

@implementation MineWeiXinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"微信";
    _captchaBtn = [UIButton buttonWithTarget:self action:@selector(timeBtnClick) image:nil highImage:nil disableImage:nil];
    [_captchaBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [_captchaBtn setBackgroundImage:[UIImage imageWithColor:[JKUtil getColor:@"ecf1f5"]] forState:UIControlStateHighlighted];
    _captchaBtn.layer.masksToBounds = YES;
    _captchaBtn.layer.cornerRadius = 5;
    _captchaBtn.layer.borderColor = [ [UIColor colorWithRed:(247 / 255.0f) green:(105 / 255.0f) blue:(86 / 255.0f) alpha:1] CGColor];
    _captchaBtn.layer.borderWidth = 1;
    _captchaBtn.frame = CGRectMake(ScreenWidth-117, 7.5, 101, 40);
    [_captchaBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [_captchaBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_captchaBtn setTitleColor: [UIColor colorWithRed:(247 / 255.0f) green:(105 / 255.0f) blue:(86 / 255.0f) alpha:1] forState:UIControlStateNormal];
    [_captchaBtn setTitleColor:[JKUtil getColor:@"999999"] forState:UIControlStateDisabled];
    [self createData];
    [self createTableView];

}
-(void)createData{
    leftTitleArr = @[@[@"微信",@"姓名"],@[@"手机号码",@"请输入验证码"]];
}
-(void)createTableView{
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 220*ScaleSize+45-44*ScaleSize)];
    tableV.delegate = self;
    tableV.backgroundColor = KTabBackgroundColor;
    tableV.dataSource = self;
    tableV.scrollEnabled = NO;
    tableV.tableFooterView = [[UIView alloc]init];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 15)];
    view.backgroundColor = KTabBackgroundColor;
    tableV.tableHeaderView = view;
    [self.view addSubview:tableV];
    
    UIButton *presentBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    presentBtn.backgroundColor = [UIColor colorWithRed:0.33 green:0.72 blue:0.87 alpha:1];
    [presentBtn setTitle:@"提交" forState:UIControlStateNormal];
    [presentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    presentBtn.layer.cornerRadius = 4;
    presentBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [presentBtn addTarget:self action:@selector(presentBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:presentBtn];
    [presentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.top.equalTo(tableV.mas_bottom).offset(10);
        make.width.mas_equalTo(ScreenWidth-30);
        make.height.mas_equalTo(44*ScaleSize);
    }];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [phoneNumField resignFirstResponder];
    [verifyNumField resignFirstResponder];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44*ScaleSize;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 15)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifier = @"indentifier";
    UITableViewCell *cell = [tableV cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indentifier];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.text = leftTitleArr[indexPath.section][indexPath.row];
    if (indexPath.section==0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row==0) {
            if (weixinNum.length==0) {
                
                NSString *weixinStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"weixinName"];
                if (weixinStr.length) {
                    cell.detailTextLabel.text = weixinStr;
                    cell.detailTextLabel.textColor = RGBColor(51, 51, 51);
                }
                else{
                    cell.detailTextLabel.text = @"请输入微信账号";
                    cell.detailTextLabel.textColor = [UIColor colorWithRed:0.33 green:0.72 blue:0.87 alpha:1];
                }
                
            }else{
                cell.detailTextLabel.text = weixinNum;
                cell.detailTextLabel.textColor = RGBColor(51, 51, 51);
            }
        }else if (indexPath.row==1) {
            if (weixinName.length==0) {
                cell.detailTextLabel.text = @"请输入微信姓名";
                cell.detailTextLabel.textColor = [UIColor colorWithRed:0.33 green:0.72 blue:0.87 alpha:1];
            }else{
                cell.detailTextLabel.text = weixinName;
                cell.detailTextLabel.textColor = RGBColor(51, 51, 51);
            }
        }
    }else if(indexPath.section==1){
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row==0) {
            phoneNumField = [[UITextField alloc]init];
            phoneNumField.delegate = self;
            
            phoneNumField.keyboardType = UIKeyboardTypeNumberPad;
            phoneNumField.textAlignment = NSTextAlignmentRight;
            phoneNumField.placeholder = @"请输入手机号码";
            [cell.contentView addSubview:phoneNumField];
            [phoneNumField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell.contentView.mas_right).offset(-16);
                make.top.equalTo(cell.contentView.mas_top).offset(0);
                make.height.mas_equalTo(44*ScaleSize);
                make.width.mas_equalTo(ScreenWidth/3*2);
                
            }];
        }else if (indexPath.row==1) {
            [cell.contentView addSubview:_captchaBtn];
            [_captchaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell.contentView.mas_right).offset(-16);
                make.bottom.equalTo(cell.contentView.mas_bottom).offset(-5*ScaleSize);
                make.width.mas_equalTo(100);
                make.height.mas_equalTo(34*ScaleSize);
            }];
            verifyNumField = [[UITextField alloc]init];
            verifyNumField.delegate = self;
            verifyNumField.keyboardType = UIKeyboardTypeNumberPad;
            verifyNumField.textAlignment = NSTextAlignmentRight;
            [cell.contentView addSubview:verifyNumField];
            [verifyNumField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(_captchaBtn.mas_left).offset(-5);
                make.top.equalTo(cell.contentView.mas_top).offset(0);
                make.height.mas_equalTo(44*ScaleSize);
                make.width.mas_equalTo(120);
                
            }];
        }
    }
    return cell;
}
//- (NSString *)valiMobile:(NSString *)mobile{
//    if ([mobile length] !=11) {
//        return @"请输入11位手机号码";
//    }
//    NSString *regex = @"[1][34578]\\d{9}";
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    BOOL isMatch = [pred evaluateWithObject:mobile];
//    if (!isMatch) {
//        return @"请输入正确的手机号码格式";
//    }else{
//        return nil;
//    }
//}

-(void)timeBtnClick{
    
    if (phoneNumField.text.length!=11) {
        [NSObject showHudTipStr:@"请输入11位手机号码"];
    }else{
        if ([MineWeiXinViewController valiMobile:phoneNumField.text]) {
            [self requestVerify];
        }else{
            [NSObject showHudTipStr:@"请输入正确的手机号码格式"];
        }
    }
}

-(void)change{
    __block int timeout = 60;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [_captchaBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                _captchaBtn.layer.borderColor =  [UIColor colorWithRed:(247 / 255.0f) green:(105 / 255.0f) blue:(86 / 255.0f) alpha:1].CGColor;
                [_captchaBtn setTitleColor: [UIColor colorWithRed:(247 / 255.0f) green:(105 / 255.0f) blue:(86 / 255.0f) alpha:1] forState:UIControlStateNormal];
                _captchaBtn.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [_captchaBtn setTitle:[NSString stringWithFormat:@"%@秒重发",strTime] forState:UIControlStateNormal];
                _captchaBtn.layer.borderColor = [JKUtil getColor:@"dbe1e8"].CGColor;
                [_captchaBtn setTitleColor:[JKUtil getColor:@"cacaca"] forState:UIControlStateNormal];
                
                [UIView commitAnimations];
                _captchaBtn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

//提交
-(void)presentBtnClick{
    if (weixinNum.length==0) {
        [self.view makeToast:@"请输入微信账号" duration:1 position:@"center"];
    }else if (weixinName.length==0) {
        [self.view makeToast:@"请输入微信姓名" duration:1 position:@"center"];
    }else if (phoneNumField.text.length==0) {
        [self.view makeToast:@"请输入手机号码" duration:1 position:@"center"];
    }else if (verifyNumField.text.length==0) {
        [self.view makeToast:@"请输入验证码" duration:1 position:@"center"];
    }else{
        [[NetworkEngine sharedManager] request_Save_WeiXinAccount_WithParams:@{} andBlock:^(id data, NSError *error) {
            
        }];
//        NSDictionary *dict = @{
//                               @"user.realname":weixinName,
//                               @"user.weixin":weixinNum,
//                               @"code":verifyNumField.text,
//                               @"accessToken":[YUserDefaults objectForKey:@"accessTokenLogin"],
//                               };
//        NSString *url = [NSString stringWithFormat:@"%@user/updateWeiXin.json?",BaseUrl];
//        [[NetworkEngine sharedManager] getParameter:dict url:url successBlock:^(id responseBody) {
//            NSDictionary *dic = (NSDictionary *)responseBody;
//            if([dic[@"status"] integerValue]==1){
//                [YUserDefaults setObject:weixinNum forKey:@"weixinName"];
//                if (self.backWeiXinBlock) {
//                    self.backWeiXinBlock(@"");
//                }
//                [self.view makeToast:dic[@"msg"] duration:1 position:@"center"];
//                [self.navigationController popViewControllerAnimated:YES];
//            }else{
//                [self.view makeToast:dic[@"msg"] duration:1 position:@"center"];
//            }
//        } failureBlock:^(NSString *error) {
//            [self.view makeToast:@"网络连接失败" duration:1 position:@"center"];
//        }];
        
    }
    
}

//验证码
-(void)requestVerify{
    //    位置：query ?type=weixin、alipay、bank
    //    说明：weixin微信验证、aplipay支付宝验证、bank银行卡验证
    
//    NSDictionary *dict = @{
//                           @"mobile":phoneNumField.text,
//                           @"type":@"weixin",
//                           };
//    NSString *url = [NSString stringWithFormat:@"%@code/send.json?",BaseUrl];
//    [[NetworkEngine sharedManager] getParameter:dict url:url successBlock:^(id responseBody) {
//        NSDictionary *dic = (NSDictionary *)responseBody;
//        
//        if([dic[@"status"] integerValue]==1){
//            [self change];
//            [self.view makeToast:dic[@"msg"] duration:1 position:@"center"];
//        }else{
//            [self.view makeToast:dic[@"msg"] duration:1 position:@"center"];
//        }
//    } failureBlock:^(NSString *error) {
//        [self.view makeToast:@"网络连接失败" duration:1 position:@"center"];
//    }];
    [[NetworkEngine sharedManager] request_Send_Captcha_WithParams:@{@"captcha.mobile":phoneNumField.text,@"captcha.type":@"identity"} andBlock:^(id data, NSError *error) {
        if (data) {
            [self change];
        }
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section==0){
        if (indexPath.row==0) {
            MineBankSetInfoViewController *vc = [[MineBankSetInfoViewController alloc]init];
            vc.infoStr = @"微信账号";
            vc.backInfoBlock = ^(NSString *str){
                weixinNum = str;
                [tableView reloadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row==1) {
            MineBankSetInfoViewController *vc = [[MineBankSetInfoViewController alloc]init];
            vc.infoStr = @"微信姓名";
            vc.backInfoBlock = ^(NSString *str){
                weixinName = str;
                [tableView reloadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
            
        }
    }else if(indexPath.section==1){
        
    }
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
