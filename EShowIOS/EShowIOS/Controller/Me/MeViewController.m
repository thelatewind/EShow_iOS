//
//  MeViewController.m
//  EShowIOS
//
//  Created by 王迎军 on 2016/11/22.
//  Copyright © 2016年 王迎军. All rights reserved.
//

#import "MeViewController.h"
#import "MineAccountViewController.h"
@interface MeViewController ()

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的";
    
    
    UIButton *captchLoginBtn = ({
        UIButton *button = [self setNormalButton];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button setTitle:@"我的账户" forState:UIControlStateNormal];
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make){
            make.size.mas_equalTo(CGSizeMake(100, 30));
            make.left.equalTo (self.view).with.offset(kLoginPaddingLeftWidth);
            make.top.equalTo(self.view.mas_top).offset(150);
        }];
        button;
    });
    [captchLoginBtn addTarget:self action:@selector(captchLoginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)captchLoginBtnClicked:(id)sender{
    MineAccountViewController *account  = [MineAccountViewController new];
    [self.navigationController pushViewController:account animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.tabBarController.tabBar.hidden = NO;
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
