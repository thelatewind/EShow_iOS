//
//  ForgetPasswordViewController.m
//  EShowIOS
//
//  Created by 王迎军 on 2017/3/28.
//  Copyright © 2017年 王迎军. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "TPKeyboardAvoidingTableView.h"

@interface ForgetPasswordViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UIButton *footerBtn;
@property (strong, nonatomic) TPKeyboardAvoidingTableView *myTableView;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) UITextField *username_textField;
@property (nonatomic ,strong) UITextField *captcha_textField;
@property (nonatomic ,strong) UITextField *paaaword_textField;
@property (nonatomic, strong) UITextField *newpassword_again;

@property (nonatomic, strong) UIButton *captchaBtn;

@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"重置密码";
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
    self.username_textField = [self setNormalTextField];
    self.username_textField.frame = CGRectMake(20.0f, 0, ScreenWidth-30.0f, 55.0f);
    self.username_textField.placeholder = @"请输入手机号码";
    if ([(NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:@"user.username"] length] > 0) {
        _username_textField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"user.username"];
    }
    _captcha_textField = [self setNormalTextField];
    _captcha_textField.frame = CGRectMake(20, 0, ScreenWidth-145, 55.0);
    _captcha_textField.placeholder = @"请输入验证码";
    
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
    _paaaword_textField = [self setNormalTextField];
    _paaaword_textField.frame = CGRectMake(20, 0, ScreenWidth-20, 55.0);
    _paaaword_textField.placeholder = @"请输入密码";
    _paaaword_textField.secureTextEntry = YES;
    _paaaword_textField.keyboardType = UIKeyboardTypeDefault;
    _newpassword_again = [self setNormalTextField];
    _newpassword_again.frame = CGRectMake(20, 0, ScreenWidth-20, 55.0);
    _newpassword_again.placeholder = @"请再次输入密码";
    _newpassword_again.secureTextEntry = YES;
    _newpassword_again.keyboardType = UIKeyboardTypeDefault;
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row == 0) {
        [cell.contentView addSubview:self.username_textField];
    }else if (indexPath.row == 1) {
        [cell.contentView addSubview:_captcha_textField];
        [cell.contentView addSubview:_captchaBtn];
    }else if (indexPath.row == 2){
        [cell.contentView addSubview:_paaaword_textField];
    }else{
        [cell.contentView addSubview:_newpassword_again];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55.0;
}
#pragma mark - Table view Header Footer
- (UIView *)customHeaderView{
    UIView *headerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.04*ScreenHeight)];
    headerV.backgroundColor = [UIColor clearColor];
    return headerV; 
}
- (UIView *)customFooterView{
    UIView *footerV = [[UIView alloc] initWithFrame:CGRectMake(0, 100, ScreenWidth, 150)];
    _footerBtn = [UIButton buttonWithStyle:StrapSuccessStyle andTitle:@"提交" andFrame:CGRectMake(kLoginPaddingLeftWidth, 20, ScreenWidth-kLoginPaddingLeftWidth*2, 45) target:self action:@selector(sendRegister)];
    _footerBtn.enabled = NO;
    [footerV addSubview:_footerBtn];
    return footerV;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (_username_textField.text.length > 0 && _captcha_textField.text.length > 0 && _paaaword_textField.text.length > 0 && _newpassword_again.text.length > 0) {
        _footerBtn.enabled = YES;
    }else{
        _footerBtn.enabled = NO;
    }
    return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    _footerBtn.enabled = NO;
    return YES;
}
- (void)voicePrompt{
    if ([ForgetPasswordViewController valiMobile:self.username_textField.text]){
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
        [[NetworkEngine sharedManager] request_Send_Captcha_WithParams:@{@"captcha.mobile":self.username_textField.text,@"captcha.type":@"password"} andBlock:^(id data, NSError *error) {}];
    }else{
        [NSObject showHudTipStr:@"请输入正确的手机号!"];
    }
}
#pragma mark Btn Clicked
- (void)sendRegister{
    if (_username_textField.text.length > 0 && _captcha_textField.text.length > 0 && _paaaword_textField.text.length > 0 && _newpassword_again.text.length > 0 && [_paaaword_textField.text isEqualToString:_newpassword_again.text]) {
        [[NetworkEngine sharedManager] request_Reset_Password_WithParams:@{@"user.username":_username_textField.text,@"code":_captcha_textField.text,@"user.password":_paaaword_textField.text,@"user.confirmPassword":_newpassword_again.text} andBlock:^(id data, NSError *error) {
            if (data) {
                [NSObject showHudTipStr:@"密码重置成功! 正在返回登录界面..."];
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:_username_textField.text forKey:@"user.username"];
                [userDefaults synchronize];
                double delayInSeconds = 1.0;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [((AppDelegate *)[UIApplication sharedApplication].delegate) setupLoginViewController];
                });
            }
        }];
    }else if (![_paaaword_textField.text isEqualToString:_newpassword_again.text]){
        [NSObject showHudTipStr:@"两次密码不一致!"];
    }else{
        [NSObject showHudTipStr:@"请确保信息完整!"];
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
