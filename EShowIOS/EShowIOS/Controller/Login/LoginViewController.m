//
//  LoginViewController.m
//  EShowIOS
//
//  Created by 王迎军 on 2017/2/7.
//  Copyright © 2017年 王迎军. All rights reserved.
//

#import "LoginViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "RegisterViewController.h"
#import "LoginCaptchViewController.h"
#import "ForgetPasswordViewController.h"
#import "SetMobileViewController.h"
#import "UMSocial.h"
#import "WXApi.h"

#import "Login.h"
@interface LoginViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    UITextField * username,* password;
}

@property (strong, nonatomic) UIView *bottomView;//第三方登录所在view
@property (strong, nonatomic) TPKeyboardAvoidingTableView *myTableView;
@property (strong, nonatomic) UIButton *loginBtn;
@property (strong, nonatomic) UITextField *telephone_text;
@property (strong, nonatomic) UITextField *password_text;
@property (strong, nonatomic) UIButton *QQ_button;
@property (strong, nonatomic) UIButton *Wechat_button;
@property (strong, nonatomic) UIImageView *rightImage, *leftImage;
@property (strong, nonatomic) UILabel *otherLoginWay;

@property (strong, nonatomic) NSString *msg, *status;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登录";
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(ClickedRegisterButton:)]];
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
    _password_text.frame = CGRectMake(20, 0, ScreenWidth - 20, 55.0);
    _password_text.keyboardType = UIKeyboardTypeDefault;
    _password_text.placeholder = @"请输入密码";
    _password_text.secureTextEntry = YES;
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
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55.0;
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
        UIButton *button = [self setNormalButton];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button setTitle:@"验证码登录" forState:UIControlStateNormal];
        [footerV addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make){
            make.size.mas_equalTo(CGSizeMake(100, 30));
            make.left.equalTo (footerV).with.offset(kLoginPaddingLeftWidth);
            make.top.equalTo(_loginBtn.mas_bottom).offset(20);
        }];
        button;
    });
    [captchLoginBtn addTarget:self action:@selector(captchLoginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *cannotLoginBtn = ({
        UIButton *button = [self setNormalButton];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [button setTitle:@"忘记密码?" forState:UIControlStateNormal];
        [footerV addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make){
            make.size.mas_equalTo(CGSizeMake(100, 30));
            make.right.equalTo (footerV).with.offset(-kLoginPaddingLeftWidth);
            make.top.equalTo(_loginBtn.mas_bottom).offset(20);
        }];
        button;
    });
    [cannotLoginBtn addTarget:self action:@selector(cannotLoginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    return footerV;
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
- (void)sendLogin{
    [_telephone_text resignFirstResponder];
    [_password_text resignFirstResponder];
    if (_telephone_text.text.length > 0 && _password_text.text.length > 0) {
        NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
        [parameter setObject:_telephone_text.text forKey:@"user.username"];
        [parameter setObject:_password_text.text forKey:@"user.password"];
        [[NetworkEngine sharedManager] request_Login_WithParams:parameter andBlock:^(id data, NSError *error) {
            if (data) {
                [((AppDelegate *)[UIApplication sharedApplication].delegate) setupTabViewController];
            }
        }];
    }
}
- (void)captchLoginBtnClicked:(UIButton *)sender{
    LoginCaptchViewController *captch = [[LoginCaptchViewController alloc] init];
    [self.navigationController pushViewController:captch animated:YES];
}
- (void)cannotLoginBtnClicked:(UIButton *)sender{
    ForgetPasswordViewController *forget = [[ForgetPasswordViewController alloc] init];
    [self.navigationController pushViewController:forget animated:YES];
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
