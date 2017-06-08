//
//  LoginCaptchViewController.m
//  EShowIOS
//
//  Created by 王迎军 on 2017/3/28.
//  Copyright © 2017年 王迎军. All rights reserved.
//

#import "LoginCaptchViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "RegisterViewController.h"
#import "SetMobileViewController.h"
#import "AppDelegate.h"
#import "UMSocial.h"
#import "WXApi.h"
@interface LoginCaptchViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    UITextField * username;
    UITextField * password;
}
@property (strong, nonatomic) TPKeyboardAvoidingTableView *myTableView;
@property (strong, nonatomic) UIButton *loginBtn;
@property (strong, nonatomic) UITextField *telephone_text;
@property (strong, nonatomic) UITextField *password_text;
@property (nonatomic, strong) UIButton *captchaBtn;

@property (strong, nonatomic) UIButton *QQ_button;
@property (strong, nonatomic) UIButton *Wechat_button;
@property (strong, nonatomic) UIImageView *rightImage, *leftImage;
@property (strong, nonatomic) UILabel *otherLoginWay;
@end

@implementation LoginCaptchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"验证码登录";
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(ClickedRegisterButton:)]];
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
    [self configBottomView];
}
- (void)ClickedRegisterButton:(UIButton *)sender{
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
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
    _loginBtn = [UIButton buttonWithStyle:StrapSuccessStyle andTitle:@"登录" andFrame:CGRectMake(kLoginPaddingLeftWidth, 0.04*ScreenHeight, ScreenWidth-kLoginPaddingLeftWidth*2, 45) target:self action:@selector(sendLogin)];
    _loginBtn.enabled = NO;
    [footerV addSubview:_loginBtn];
    UIButton *captchLoginBtn = ({
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [button setTitleColor:[UIColor colorWithRed:(247 / 255.0f) green:(105 / 255.0f) blue:(86 / 255.0f) alpha:1] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:(247 / 255.0f) green:(105 / 255.0f) blue:(86 / 255.0f) alpha:1] forState:UIControlStateHighlighted];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //        button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [button setTitle:@"账号密码登录" forState:UIControlStateNormal];
        [footerV addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make){
            make.size.mas_equalTo(CGSizeMake(100, 30));
            make.left.equalTo (footerV).with.offset(kLoginPaddingLeftWidth);
            make.top.equalTo(_loginBtn.mas_bottom).offset(20);
        }];
        button;
    });
    [captchLoginBtn addTarget:self action:@selector(cannotLoginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
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
#pragma mark BottomView
- (void)configBottomView{
    CGFloat buttonWidth = ScreenWidth * 0.3;
    CGFloat buttonHeight = kScaleFrom_iPhone5_Desgin(40);
    CGFloat paddingToCenter = kScaleFrom_iPhone5_Desgin(20);
    CGFloat paddingToBottom = kScaleFrom_iPhone5_Desgin(20);
    self.Wechat_button = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(WechatBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor clearColor];
        [button setImage:[UIImage imageNamed:@"wx_login_open"] forState:UIControlStateNormal];
        button;
    });
    self.QQ_button = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(QQBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        
        button.backgroundColor = [UIColor clearColor];
        [button setImage:[UIImage imageNamed:@"qq_login_open"] forState:UIControlStateNormal];
        button;
    });
    [self.view addSubview:self.Wechat_button];
    [self.view addSubview:self.QQ_button];
    [self.Wechat_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(buttonWidth, buttonHeight));
        make.right.equalTo(self.view.mas_centerX).offset(-paddingToCenter);
        make.bottom.equalTo(self.view).offset(-paddingToBottom);
    }];
    [self.QQ_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(buttonWidth, buttonHeight));
        make.left.equalTo(self.view.mas_centerX).offset(paddingToCenter);
        make.bottom.equalTo(self.view).offset(-paddingToBottom);
    }];
    //label
    self.otherLoginWay = ({
        UILabel *label = [[UILabel alloc] init];
        label.text = @"或用其它方式快速登录";
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentCenter;
        label;
    });
    [self.view addSubview:self.otherLoginWay];
    CGFloat labelWidth = ScreenWidth/2;
    CGFloat labelHeight = kScaleFrom_iPhone5_Desgin(20);
    CGFloat labelToCenter = ScreenWidth/4;
    CGFloat labelToBottom = kScaleFrom_iPhone5_Desgin(80);
    [self.otherLoginWay mas_makeConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(labelWidth, labelHeight));
        make.right.equalTo (self.view.mas_centerX).offset(labelToCenter);
        make.bottom.equalTo(self.view).offset(-labelToBottom);
    }];
    //imageview
    self.rightImage = ({
        UIImageView *image = [[UIImageView alloc] init];
        image.backgroundColor = [UIColor grayColor];
        image;
    });
    self.leftImage = ({
        UIImageView *image = [[UIImageView alloc] init];
        image.backgroundColor = [UIColor grayColor];
        image;
    });
    [self.view addSubview:self.rightImage];
    [self.view addSubview:self.leftImage];
    CGFloat imageWith = ScreenWidth/4;
    CGFloat imageHeight = 0.5f;
    CGFloat imageToCenter = kScaleFrom_iPhone5_Desgin(15);
    CGFloat imageToBottom = kScaleFrom_iPhone5_Desgin(90);
    [self.rightImage mas_makeConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(imageWith, imageHeight));
        make.right.equalTo (self.view).with.offset(-imageToCenter);
        make.bottom.equalTo(self.view).offset(-imageToBottom);
    }];
    [self.leftImage mas_makeConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo (CGSizeMake(imageWith, imageHeight));
        make.left.equalTo (self.view).with.offset(imageToCenter);
        make.bottom.equalTo(self.view).offset(-imageToBottom);
    }];
}
- (void)voicePrompt{
    if ([LoginCaptchViewController valiMobile:_telephone_text.text]) {
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
            if (data) {
                [((AppDelegate *)[UIApplication sharedApplication].delegate) setupTabViewController];
            }
        }];
    }else{
        [NSObject showHudTipStr:@"请输入手机号或验证码!"];
    }
}
- (void)cannotLoginBtnClicked:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)WechatBtnClicked{
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
            [parameter setObject:@"weixin" forKey:@"thirdParty.platform"];
            [parameter setObject:snsAccount.userName forKey:@"thirdParty.nickname"];
            [parameter setObject:snsAccount.iconURL forKey:@"thirdParty.username.url"];
            [parameter setObject:snsAccount.usid forKey:@"thirdParty.username"];
            [[NetworkEngine sharedManager] request_Login_Third_WithParams:parameter andBlock:^(id data, NSError *error) {
                if (data) {
                    if ([data[@"bind"] intValue] == 0) {
                        SetMobileViewController *mobile = [SetMobileViewController new];
                        mobile.thirdPartyID = snsAccount.usid;
                        mobile.thirdPartyIcon = snsAccount.iconURL;
                        mobile.thirdPartyType = @"wx";
                        mobile.thirdPartyNickName = snsAccount.userName;
                        [self.navigationController pushViewController:mobile animated:YES];
                    }else{
                        [((AppDelegate *)[UIApplication sharedApplication].delegate) setupTabViewController];
                    }
                }
            }];
        }
    });
}
- (void)QQBtnClicked{
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
            [parameter setObject:@"qq" forKey:@"thirdParty.platform"];
            [parameter setObject:snsAccount.userName forKey:@"thirdParty.nickname"];
            [parameter setObject:snsAccount.iconURL forKey:@"thirdParty.username.url"];
            [parameter setObject:snsAccount.usid forKey:@"thirdParty.username"];
            [[NetworkEngine sharedManager] request_Login_Third_WithParams:parameter andBlock:^(id data, NSError *error) {
                if (data) {
                    if ([data[@"bind"] intValue] == 0) {
                        SetMobileViewController *mobile = [SetMobileViewController new];
                        mobile.thirdPartyID = snsAccount.usid;
                        mobile.thirdPartyIcon = snsAccount.iconURL;
                        mobile.thirdPartyType = @"qq";
                        mobile.thirdPartyNickName = snsAccount.userName;
                        [self.navigationController pushViewController:mobile animated:YES];
                    }else{
                        [((AppDelegate *)[UIApplication sharedApplication].delegate) setupTabViewController];
                    }
                }
            }];
        }
        
    });
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
}

@end
