//
//  RegisterViewController.m
//  EShowIOS
//
//  Created by 王迎军 on 2017/2/7.
//  Copyright © 2017年 王迎军. All rights reserved.
//

#import "RegisterViewController.h"
#import "TPKeyboardAvoidingTableView.h"
//#import "Input_OnlyText_Cell.h"//文本
#import "UITTTAttributedLabel.h"
#import "AppDelegate.h"
@interface RegisterViewController ()<UITableViewDataSource,UITableViewDelegate,TTTAttributedLabelDelegate>

@property (strong, nonatomic) UIButton *footerBtn;
@property (strong, nonatomic) TPKeyboardAvoidingTableView *myTableView;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) UITextField *username_textField;
@property (nonatomic ,strong) UITextField *captcha_textField;
@property (nonatomic ,strong) UITextField *paaaword_textField;

@property (nonatomic, strong) UIButton *captchaBtn;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"注册";
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
    
    if (self.navigationController.childViewControllers.count <= 1) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismissSelf)];
    }
    self.username_textField = [self setNormalTextField];
    self.username_textField.frame = CGRectMake(20.0f, 0, ScreenWidth-30.0f, 55.0f);
    self.username_textField.placeholder = @"请输入手机号码";
    _captcha_textField = [self setNormalTextField];
    _captcha_textField.frame = CGRectMake(20, 0, ScreenWidth-45, 55.0);
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
    _paaaword_textField.keyboardType = UIKeyboardTypeDefault;
    _paaaword_textField.placeholder = @"请输入密码";
    _paaaword_textField.secureTextEntry = YES;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)dismissSelf{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
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
    }else{
        [cell.contentView addSubview:_paaaword_textField];
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    [footerV addSubview:_footerBtn];
    UITTTAttributedLabel *lineLabel = ({
        UITTTAttributedLabel *label = [UITTTAttributedLabel new];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor grayColor];
        label.numberOfLines = 0;
        label.linkAttributes = kLinkAttributes;
        label.activeLinkAttributes = kLinkAttributesActive;
        label.delegate = self;
        label;
    });
    NSString * tipStr = @"我已阅读并同意《EShow 使用协议》";
    lineLabel.text = tipStr;
    [lineLabel addLinkToTransitInformation:@{@"actionStr": @"gotoServiceTermsVC"} withRange:[tipStr rangeOfString:@"《EShow 使用协议》"]];
    CGRect footerBtnFrame = _footerBtn.frame;
    lineLabel.frame = CGRectMake(CGRectGetMinX(footerBtnFrame), CGRectGetMaxY(footerBtnFrame) +12, CGRectGetWidth(footerBtnFrame), 12);
    [footerV addSubview:lineLabel];
    
    return footerV;
}
- (void)voicePrompt{
    if ([RegisterViewController valiMobile:_username_textField.text]) {
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
        [[NetworkEngine sharedManager] request_Send_Captcha_WithParams:@{@"captcha.mobile":_username_textField.text,@"captcha.type":@"signup"} andBlock:^(id data, NSError *error) {}];
    }else{
        [NSObject showHudTipStr:@"请输入正确的手机号!"];
    }
}
#pragma mark Btn Clicked
- (void)sendRegister{
    [_username_textField resignFirstResponder];
    [_captcha_textField resignFirstResponder];
    [_paaaword_textField resignFirstResponder];
    if (_username_textField.text.length > 0 && _captcha_textField.text.length > 0 && _paaaword_textField.text.length > 0) {
        [[NetworkEngine sharedManager] request_Register_WithParams:@{@"user.username":_username_textField.text,@"code":_captcha_textField.text,@"user.password":_paaaword_textField.text} andBlock:^(id data, NSError *error) {
            if (_thirdPartyType.length > 0) {
                [[NetworkEngine sharedManager] request_Bind_Third_WithParams:@{@"accessToken":[[NSUserDefaults standardUserDefaults] objectForKey:@"accessTokenLogin"],@"thirdParty.username":_username_textField.text,@"thirdParty.nickname":_thirdPartyNickName,@"thirdParty.photo":_thirdPartyIcon,@"thirdParty.platform":_thirdPartyType} andBlock:^(id data, NSError *error) {
                    if (data) {
                        [((AppDelegate *)[UIApplication sharedApplication].delegate) setupTabViewController];
                    }
                }];
            }else{
                if (data) {
                    [NSObject showHudTipStr:@"注册成功! 正在前往登录界面..."];
                    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                    [userDefaults setObject:_username_textField.text forKey:@"user.username"];
                    [userDefaults synchronize];
                    double delayInSeconds = 1.0;
                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                        [((AppDelegate *)[UIApplication sharedApplication].delegate) setupLoginViewController];
                    });
                }

            }
        }];
    }
}
#pragma mark TTTAttributedLabelDelegate
- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithTransitInformation:(NSDictionary *)components{
    [self gotoServiceTermsVC];
}

#pragma mark VC
- (void)gotoServiceTermsVC{
    
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
