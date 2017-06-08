//
//  SetMobileViewController.m
//  EShowIOS
//
//  Created by 王迎军 on 16/8/9.
//  Copyright © 2016年 金璟. All rights reserved.
//

#import "SetMobileViewController.h"
#import "BindAccountViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "RegisterViewController.h"
//#import "Input_OnlyText_Cell.h"//文本
#import "UITTTAttributedLabel.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
@interface SetMobileViewController ()<UITableViewDataSource,UITableViewDelegate,TTTAttributedLabelDelegate>

@property (strong, nonatomic) UIButton *footerBtn;
@property (strong, nonatomic) TPKeyboardAvoidingTableView *myTableView;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) UITextField *username_textField;

@end

@implementation SetMobileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.title = @"绑定帐号";
  
    [self createUI];
}
-(void)createUI{
    
    UILabel *titleLab = [[UILabel alloc]init];
    if ([_thirdPartyType isEqualToString:@"wx"]) {
        titleLab.text = @"绑定后可同时使用EShow账号和微信账号登录";
    }else{
        titleLab.text = @"绑定后可同时使用EShow账号和QQ账号登录";
    }
    
    titleLab.font = [UIFont systemFontOfSize:14];
    titleLab.textColor = [UIColor grayColor];
    titleLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(84);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(ScreenWidth);
    }];
    
    UIImageView *weixinImg = [[UIImageView alloc]init];
    [weixinImg sd_setImageWithURL:[NSURL URLWithString:_thirdPartyIcon]];
    weixinImg.backgroundColor = [UIColor grayColor];
    weixinImg.layer.cornerRadius = 8;
    [self.view addSubview:weixinImg];
    [weixinImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-ScreenWidth/2-30);
        make.top.equalTo(titleLab.mas_bottom).offset(20);
        make.height.mas_equalTo(60);
        make.width.mas_equalTo(60);
    }];
    UILabel *weixinLab = [[UILabel alloc]init];
    weixinLab.text = _thirdPartyNickName;
    weixinLab.textAlignment = NSTextAlignmentCenter;
    weixinLab.textColor = [UIColor grayColor];
    weixinLab.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:weixinLab];
    [weixinLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-ScreenWidth/2);
        make.top.equalTo(weixinImg.mas_bottom).offset(5);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(120);
    }];
    
    UIImageView *guanlinImg = [[UIImageView alloc]init];
    guanlinImg.image = [UIImage imageNamed:@"guanlian.png"];
    [self.view addSubview:guanlinImg];
    
    [guanlinImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weixinImg.mas_right).offset(10);
        make.top.equalTo(titleLab.mas_bottom).offset(35);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(40);
    }];
    
    
    
    
    UIImageView *xinJiaImg = [[UIImageView alloc]init];
    xinJiaImg.image = [UIImage imageNamed:@"icon_180"];
    // xinJiaImg.backgroundColor = [UIColor grayColor];
    xinJiaImg.layer.cornerRadius = 8;
    [self.view addSubview:xinJiaImg];
    [xinJiaImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(ScreenWidth/2+30);
        make.top.equalTo(titleLab.mas_bottom).offset(20);
        make.height.mas_equalTo(60);
        make.width.mas_equalTo(60);
    }];
    UILabel *xinJiaLab = [[UILabel alloc]init];
    xinJiaLab.text = @"EShow";
    xinJiaLab.textColor = [UIColor grayColor];
    xinJiaLab.textAlignment = NSTextAlignmentCenter;
    xinJiaLab.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:xinJiaLab];
    [xinJiaLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(ScreenWidth/2);
        make.top.equalTo(weixinImg.mas_bottom).offset(5);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(120);
    }];
    
    
    UIButton *newBtn = [UIButton buttonWithTarget:self action:@selector(newBtnClick) image:@"btn_green_n" highImage:@"btn_green_p" disableImage:@"btn_green_d"];
    [newBtn setTitle:@"我是新用户" forState:UIControlStateNormal];
    [newBtn setTitle:@"我是新用户" forState:UIControlStateDisabled];
    newBtn.titleLabel.font = SystemFont(17);
    [self.view addSubview:newBtn];
    [newBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.top.equalTo(xinJiaLab.mas_bottom).offset(40);
        // make.height.mas_equalTo(50);
        make.height.mas_equalTo(40);
    }];
    UIButton *oldBtn = [UIButton buttonWithTarget:self action:@selector(oldBtnClick) image:@"btn_green_n" highImage:@"btn_green_p" disableImage:@"btn_green_d"];
    [oldBtn setTitle:@"已有EShow账号" forState:UIControlStateNormal];
    [oldBtn setTitle:@"已有EShow账号" forState:UIControlStateDisabled];
    oldBtn.titleLabel.font = SystemFont(17);
    [self.view addSubview:oldBtn];
    [oldBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.top.equalTo(newBtn.mas_bottom).offset(20);
        // make.height.mas_equalTo(50);
        make.height.mas_equalTo(40);
    }];
    
}
-(void)newBtnClick{
    RegisterViewController *bind = [[RegisterViewController alloc] init];
    bind.thirdPartyID = _thirdPartyID;
    bind.thirdPartyIcon = _thirdPartyIcon;
    bind.thirdPartyType = _thirdPartyType;
    bind.thirdPartyNickName = _thirdPartyNickName;
    [self.navigationController pushViewController:bind animated:YES];
}
-(void)oldBtnClick{
    BindAccountViewController *bind = [[BindAccountViewController alloc] init];
    bind.thirdPartyID = _thirdPartyID;
    bind.thirdPartyIcon = _thirdPartyIcon;
    bind.thirdPartyType = _thirdPartyType;
    bind.thirdPartyNickName = _thirdPartyNickName;
    [self.navigationController pushViewController:bind animated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
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
