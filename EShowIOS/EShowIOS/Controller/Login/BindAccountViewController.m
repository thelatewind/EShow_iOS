//
//  BindAccountViewController.m
//  EShowIOS
//
//  Created by 王迎军 on 2017/3/28.
//  Copyright © 2017年 王迎军. All rights reserved.
//

#import "BindAccountViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "RegisterViewController.h"
#import "SetMobileViewController.h"
#import "AppDelegate.h"
#import "UMSocial.h"
#import "WXApi.h"
@interface BindAccountViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    UITextField * username;
    UITextField * password;
}
@property (strong, nonatomic) TPKeyboardAvoidingTableView *myTableView;
@property (strong, nonatomic) UIButton *loginBtn;
@property (strong, nonatomic) UITextField *telephone_text;
@property (strong, nonatomic) UITextField *password_text;
@property (nonatomic, strong) UIButton *captchaBtn;

@end

@implementation BindAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"绑定手机号";
    //添加myTableView
    _myTableView = ({
        TPKeyboardAvoidingTableView *tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.backgroundColor = [UIColor colorWithRed:(247.0 / 255.0f) green:(247.0 /255.0f) blue:(240.0 / 255.0f) alpha:1.0f];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        tableView;
    });
    self.myTableView.tableHeaderView = [self customHeaderView];
    self.myTableView.tableFooterView=[self customFooterView];
    _telephone_text = [self setNormalTextField];
    _telephone_text.frame = CGRectMake(20, 0, ScreenWidth - 20, 55.0);
    _telephone_text.placeholder = @"请输入手机号码";
    if ([(NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:@"user.username"] length] > 0) {
        _telephone_text.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"user.username"];
    }
    _password_text = [self setNormalTextField];
    _password_text.frame = CGRectMake(20, 0, ScreenWidth-145, 55.0);
    _password_text.placeholder = @"请输入验证码";
    _captchaBtn = [UIButton buttonWithTarget:self action:@selector(voicePrompt) image:nil highImage:nil disableImage:nil];
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
}
#pragma mark - tableViewCell
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row == 0) {
        [cell.contentView addSubview:_telephone_text];
    }else {
        [cell.contentView addSubview:_password_text];
        [cell.contentView addSubview:_captchaBtn];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55.0;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view Header Footer
- (UIView *)customHeaderView{
    UIView *headerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.04*ScreenHeight)];
    headerV.backgroundColor = [UIColor clearColor];
    return headerV;
}
- (UIView *)customFooterView{
    UIView *footerV = [[UIView alloc] initWithFrame:CGRectMake(0, 100, ScreenWidth, 150)];
    _loginBtn = [UIButton buttonWithStyle:StrapSuccessStyle andTitle:@"绑定" andFrame:CGRectMake(kLoginPaddingLeftWidth, 0.04*ScreenHeight, ScreenWidth-kLoginPaddingLeftWidth*2, 45) target:self action:@selector(sendLogin)];
    _loginBtn.enabled = NO;
    [footerV addSubview:_loginBtn];
    return footerV;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (_telephone_text.text.length > 0 && _password_text.text.length > 0) {
        _loginBtn.enabled = YES;
    }else{
        _loginBtn.enabled = NO;
    }
    return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    _loginBtn.enabled = NO;
    return YES;
}
- (void)voicePrompt{
    if ([BindAccountViewController valiMobile:_telephone_text.text]) {
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
        [[NetworkEngine sharedManager] request_Send_Captcha_WithParams:@{@"captcha.mobile":_telephone_text.text,@"captcha.type":@"login"} andBlock:^(id data, NSError *error) {}];
    }else{
        [NSObject showHudTipStr:@"请输入正确的手机号!"];
    }
}
- (void)sendLogin{
    if (_telephone_text.text.length > 0 && _password_text.text.length > 0) {
        [[NetworkEngine sharedManager] request_Login_Captcha_WithParams:@{@"user.username":_telephone_text.text,@"code":_password_text.text} andBlock:^(id data, NSError *error) {
            [[NetworkEngine sharedManager] request_Bind_Third_WithParams:@{@"accessToken":[[NSUserDefaults standardUserDefaults] objectForKey:@"accessTokenLogin"],@"thirdParty.username":_thirdPartyID,@"thirdParty.nickname":_thirdPartyNickName,@"thirdParty.photo":_thirdPartyIcon,@"thirdParty.platform":_thirdPartyType} andBlock:^(id data, NSError *error) {
                if (data) {
                    [((AppDelegate *)[UIApplication sharedApplication].delegate) setupTabViewController];
                }
            }];
        }];
    }else{
        [NSObject showHudTipStr:@"请输入手机号或验证码!"];
    }
}
- (void)cannotLoginBtnClicked:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
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
