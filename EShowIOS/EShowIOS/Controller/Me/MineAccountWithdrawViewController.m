//
//  MineAccountWithdrawViewController.m
//  YiShiBang
//
//  Created by 王迎军 on 2017/5/23.
//  Copyright © 2017年 王迎军. All rights reserved.
//

#import "MineAccountWithdrawViewController.h"
#import "MineAlipayViewController.h"
#import "MineWeiXinViewController.h"
#import "MineBankCardViewController.h"
#import "WithdrawTableViewCell.h"
#import "TPKeyboardAvoidingTableView.h"
@interface MineAccountWithdrawViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    UITextField *monryTextField;
    NSArray *imgArr,*nameArr,*contentArr;
    
    NSString *chooseStr;
    NSString *palyType;
    BOOL isEdit;
    NSString *aliPayStr;//支付宝账号
    NSString *weixinStr;//微信账号
    NSString *bankStr;//银行账号
}
@property (strong, nonatomic) TPKeyboardAvoidingTableView *myTableView;
@end

@implementation MineAccountWithdrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"提现";
    
    imgArr = @[@"ic_my_pay01",@"ic_my_pay02",@"ic_my_pay03"];
    nameArr = @[@"支付宝提现",@"微信提现",@"银行卡提现"];
    contentArr = @[@"添加支付宝账号",@"添加微信账号",@"添加银行卡"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtn)];
    _myTableView = ({
        TPKeyboardAvoidingTableView *tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.backgroundColor = KTabBackgroundColor;
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.tableFooterView = [self customFooterView];
        tableView.tableHeaderView = [self customHeaderView];
        [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make){
            make.edges.equalTo(self.view);
        }];
        tableView;
    });
    
    monryTextField = [[UITextField alloc]init];
    monryTextField.delegate = self;
    monryTextField.keyboardType = UIKeyboardTypeNumberPad;
    monryTextField.clearButtonMode = UITextFieldViewModeAlways;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==3) {
        if (indexPath.row==0) {
            return 220;
        }
    }
    return 70;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifier = @"indentifier";
    WithdrawTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[WithdrawTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indentifier];
    }
    cell.rightBtn.hidden = YES;
    cell.backgroundColor = [UIColor whiteColor];
    if(indexPath.section==3){
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 10*ScaleSize, ScreenWidth, 25*ScaleSize)];
        titleLab.text = @"提现金额";
        titleLab.font = [UIFont systemFontOfSize:14];
        [cell.contentView addSubview:titleLab];
        
        UILabel *monayImg = [[UILabel alloc]init];
        monayImg.text = @"￥";
        monayImg.font = [UIFont systemFontOfSize:20];
        monayImg.textColor = [UIColor blackColor];
        monayImg.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:monayImg];
        [monayImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView.mas_left).offset(15);
            make.top.equalTo(titleLab.mas_bottom).offset(2);
            make.height.mas_equalTo(40*ScaleSize);
            make.width.mas_equalTo(20);
            
        }];
    
        [cell.contentView addSubview:monryTextField];
        [monryTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView.mas_left).offset(35);
            make.top.equalTo(titleLab.mas_bottom).offset(2);
            make.height.mas_equalTo(40*ScaleSize);
            make.width.mas_equalTo(ScreenWidth-30);
            
        }];
        UIView *lineV = [[UIView alloc]init];
        lineV.backgroundColor = [UIColor colorWithRed:0.93 green:0.94 blue:0.95 alpha:1];
        [cell.contentView addSubview:lineV];
        [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView.mas_left).offset(15);
            make.top.equalTo(monryTextField.mas_bottom).offset(0);
            make.height.mas_equalTo(1);
            make.width.mas_equalTo(ScreenWidth-15);
        }];
        
        UILabel *nowMonryLab = [[UILabel alloc]init];
        nowMonryLab.text = [NSString stringWithFormat:@"当前余额%.2f元",[_moneyStr floatValue]];
        nowMonryLab.textColor = [UIColor grayColor];
        nowMonryLab.font = [UIFont systemFontOfSize:12];
        [cell.contentView addSubview:nowMonryLab];
        [nowMonryLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView.mas_left).offset(15);
            make.top.equalTo(lineV.mas_bottom).offset(0);
            make.height.mas_equalTo(44*ScaleSize);
            make.width.mas_equalTo(ScreenWidth-15);
        }];
        
        UIButton *allwithdramBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        // allwithdramBtn.backgroundColor = [UIColor colorWithRed:0.33 green:0.72 blue:0.87 alpha:1];
        allwithdramBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        allwithdramBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 35, 0, 0);
        [allwithdramBtn setTitle:@"全部提现" forState:UIControlStateNormal];
        [allwithdramBtn setTitleColor:[UIColor colorWithRed:0.29 green:0.73 blue:0.89 alpha:1] forState:UIControlStateNormal];
        allwithdramBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [allwithdramBtn addTarget:self action:@selector(allwithdramBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:allwithdramBtn];
        [allwithdramBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cell.contentView.mas_right).offset(-15);
            make.top.equalTo(lineV.mas_bottom).offset(0);
            make.height.mas_equalTo(44*ScaleSize);
            make.width.mas_equalTo(100);
        }];
        
        UIView *backv = [[UIView alloc]init];
        backv.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
        [cell.contentView addSubview:backv];
        [backv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(cell.contentView.mas_bottom).offset(0);
            make.top.equalTo(nowMonryLab.mas_bottom).offset(0);
            make.width.mas_equalTo(ScreenWidth);
        }];
        
        UILabel *twoWorkdayLab = [[UILabel alloc]init];
        twoWorkdayLab.text = @"两个工作日到账";
        twoWorkdayLab.textColor = [UIColor orangeColor];
        twoWorkdayLab.font = [UIFont systemFontOfSize:12];
        [cell.contentView addSubview:twoWorkdayLab];
        [twoWorkdayLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView.mas_left).offset(14*ScaleSize+20);
            make.top.equalTo(nowMonryLab.mas_bottom).offset(0);
            make.bottom.equalTo(cell.contentView.mas_bottom).offset(-44*ScaleSize);
            make.width.mas_equalTo(150);
        }];
        //说明
        UIButton *explainBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        // allwithdramBtn.backgroundColor = [UIColor colorWithRed:0.33 green:0.72 blue:0.87 alpha:1];
        explainBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        explainBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 35, 0, 0);
        [explainBtn setTitle:@"提现说明" forState:UIControlStateNormal];
        [explainBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        explainBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [explainBtn addTarget:self action:@selector(explainBtnBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *xiaoBq = [[UIImageView alloc]init];
        xiaoBq.image = [UIImage imageNamed:@"ic_my_alarm"];
        [backv addSubview:xiaoBq];
        [xiaoBq mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView.mas_left).offset(15);
            make.centerY.equalTo(twoWorkdayLab);
            make.width.mas_equalTo(14*ScaleSize);
            make.height.mas_equalTo(14*ScaleSize);
        }];
        UIButton *withdramBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        withdramBtn.backgroundColor = [UIColor colorWithRed:0.33 green:0.72 blue:0.87 alpha:1];
        [withdramBtn setTitle:@"确认提现" forState:UIControlStateNormal];
        [withdramBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        withdramBtn.layer.cornerRadius = 4;
        withdramBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [withdramBtn addTarget:self action:@selector(affirmWithdramBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:withdramBtn];
        [withdramBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView.mas_left).offset(15);
            make.bottom.equalTo(cell.contentView.mas_bottom).offset(0);
            make.width.mas_equalTo(ScreenWidth-30);
            make.height.mas_equalTo(44*ScaleSize);
        }];
    }else{
        cell.icon.image = [UIImage imageNamed:imgArr[indexPath.section]];
        cell.titleLabel.text = nameArr[indexPath.section];
        if (isEdit) {//是否编辑
            cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithColor:RGBColor(241, 251, 255)]];
            if (indexPath.section==0) {
//                if ([NSString stringWithFormat:@"%@",[YUserDefaults objectForKey:@"alipayName"]].length==0 || [[YUserDefaults objectForKey:@"alipayName"] isKindOfClass:[NSNull class]] ) {
                    cell.contentLabel.text = contentArr[indexPath.section];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//                }else{
//                    cell.contentLabel.text = [NSString stringWithFormat:@"支付宝账号:%@",[YUserDefaults objectForKey:@"alipayName"]];
//                    aliPayStr = [YUserDefaults objectForKey:@"alipayName"];
//                }
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }else if (indexPath.section==1) {
//                if ([NSString stringWithFormat:@"%@",[YUserDefaults objectForKey:@"weixinName"]].length==0 || [[YUserDefaults objectForKey:@"weixinName"] isKindOfClass:[NSNull class]]) {
                    cell.contentLabel.text = contentArr[indexPath.section];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//                }else{
//                    cell.contentLabel.text = [NSString stringWithFormat:@"微信账号:%@",[YUserDefaults objectForKey:@"weixinName"]];
//                    weixinStr = [YUserDefaults objectForKey:@"weixinName"];
//                }
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }else if (indexPath.section==2) {
//                if ([NSString stringWithFormat:@"%@",[YUserDefaults objectForKey:@"bank.cardNo"]].length==6) {
                    cell.contentLabel.text = contentArr[indexPath.section];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//                }else{
//                    cell.contentLabel.text = [NSString stringWithFormat:@"银行账号:%@",[YUserDefaults objectForKey:@"bank.cardNo"]];
//                    bankStr = [YUserDefaults objectForKey:@"bank.cardNo"];
//                }
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
        }else{
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (indexPath.section==0) {
//                if ([NSString stringWithFormat:@"%@",[YUserDefaults objectForKey:@"alipayName"]].length==0 || [[YUserDefaults objectForKey:@"alipayName"] isKindOfClass:[NSNull class]] ) {
                    cell.contentLabel.text = contentArr[indexPath.section];
//                }else{
//                    cell.contentLabel.text = [NSString stringWithFormat:@"支付宝账号:%@",[YUserDefaults objectForKey:@"alipayName"]];
//                    aliPayStr = [YUserDefaults objectForKey:@"alipayName"];
//                }
//                if([NSString stringWithFormat:@"%@",[YUserDefaults objectForKey:@"alipayName"]].length==0 || [[YUserDefaults objectForKey:@"alipayName"] isKindOfClass:[NSNull class]] ){
//                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//                }else{
                    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
                    rightBtn.tag = indexPath.section;
                    [rightBtn addTarget:self action:@selector(rightChooseBtn:) forControlEvents:UIControlEventTouchUpInside];
                    if([[NSString stringWithFormat:@"%ld",(long)indexPath.section] isEqualToString:chooseStr]){
                        [rightBtn setBackgroundImage:[UIImage imageNamed:@"box_choiced"] forState:UIControlStateNormal];
                    }else{
                        [rightBtn setBackgroundImage:[UIImage imageNamed:@"box_unchoice"] forState:UIControlStateNormal];
                    }
                    [cell.contentView addSubview:rightBtn];
                    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.right.equalTo(cell.contentView.mas_right).offset(-15);
                        make.centerY.equalTo(cell.contentView.mas_centerY);
                        make.height.mas_equalTo(20*ScaleSize);
                        make.width.mas_equalTo(20*ScaleSize);
                        
                    }];
//                }
                
            }else if (indexPath.section==1) {
//                if ([NSString stringWithFormat:@"%@",[YUserDefaults objectForKey:@"weixinName"]].length==0 || [[YUserDefaults objectForKey:@"weixinName"] isKindOfClass:[NSNull class]]) {
                    cell.contentLabel.text = contentArr[indexPath.section];
//                }else{
//                    cell.contentLabel.text = [NSString stringWithFormat:@"微信账号:%@",[YUserDefaults objectForKey:@"weixinName"]];
//                    weixinStr = [YUserDefaults objectForKey:@"weixinName"];
//                }
//                if ([NSString stringWithFormat:@"%@",[YUserDefaults objectForKey:@"weixinName"]].length==0 || [[YUserDefaults objectForKey:@"weixinName"] isKindOfClass:[NSNull class]]) {
//                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//                }else{
                    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
                    rightBtn.tag = indexPath.section;
                    [rightBtn addTarget:self action:@selector(rightChooseBtn:) forControlEvents:UIControlEventTouchUpInside];
                    if([[NSString stringWithFormat:@"%ld",(long)indexPath.section] isEqualToString:chooseStr]){
                        [rightBtn setBackgroundImage:[UIImage imageNamed:@"box_choiced"] forState:UIControlStateNormal];
                    }else{
                        [rightBtn setBackgroundImage:[UIImage imageNamed:@"box_unchoice"] forState:UIControlStateNormal];
                    }
                    [cell.contentView addSubview:rightBtn];
                    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.right.equalTo(cell.contentView.mas_right).offset(-15);
                        make.centerY.equalTo(cell.contentView.mas_centerY);
                        make.height.mas_equalTo(20*ScaleSize);
                        make.width.mas_equalTo(20*ScaleSize);
                        
                    }];
//                }
                
            }else if (indexPath.section==2) {
//                if ([NSString stringWithFormat:@"%@",[YUserDefaults objectForKey:@"bank.cardNo"]].length==6) {
                    cell.contentLabel.text = contentArr[indexPath.section];
//                }else{
//                    cell.contentLabel.text = [NSString stringWithFormat:@"银行账号:%@",[YUserDefaults objectForKey:@"bank.cardNo"]];
//                    bankStr = [YUserDefaults objectForKey:@"bank.cardNo"];
//                }
//                if ([NSString stringWithFormat:@"%@",[YUserDefaults objectForKey:@"bank.cardNo"]].length==6) {
//                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//                }else{
                    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
                    rightBtn.tag = indexPath.section;
                    [rightBtn addTarget:self action:@selector(rightChooseBtn:) forControlEvents:UIControlEventTouchUpInside];
                    if([[NSString stringWithFormat:@"%ld",(long)indexPath.section] isEqualToString:chooseStr]){
                        [rightBtn setBackgroundImage:[UIImage imageNamed:@"box_choiced"] forState:UIControlStateNormal];
                    }else{
                        [rightBtn setBackgroundImage:[UIImage imageNamed:@"box_unchoice"] forState:UIControlStateNormal];
                    }
                    [cell.contentView addSubview:rightBtn];
                    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.right.equalTo(cell.contentView.mas_right).offset(-15);
                        make.centerY.equalTo(cell.contentView.mas_centerY);
                        make.height.mas_equalTo(20*ScaleSize);
                        make.width.mas_equalTo(20*ScaleSize);
                        
                    }];
//                }
            }
        }
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(isEdit){
        if (indexPath.section == 0) {
            MineAlipayViewController *vc = [[MineAlipayViewController alloc]init];
            vc.backAlipayBlock = ^(NSString *str){
                [_myTableView reloadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.section == 1){
            MineWeiXinViewController *vc = [[MineWeiXinViewController alloc]init];
            vc.backWeiXinBlock = ^(NSString *str){
                [_myTableView reloadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.section == 2){
            MineBankCardViewController *vc = [[MineBankCardViewController alloc]init];
            vc.backBankBlock =  ^(NSString *str){
                [_myTableView reloadData];
            };
            
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else{
        
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
//选择支付方式
- (void)rightChooseBtn:(UIButton *)sender{
    chooseStr = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    if (sender.tag==0) {
        palyType = @"支付宝";
    }else if (sender.tag==1) {
        palyType = @"微信";
    }else if (sender.tag==2) {
        palyType = @"银行";
    }
    [_myTableView reloadData];
}
- (void)affirmWithdramBtnClick{
    if(palyType.length==0){
        [self.view makeToast:@"请选择提现方式" duration:1 position:@"center"];
    }else if([palyType isEqualToString:@"支付宝"] && aliPayStr.length==0){
        [self.view makeToast:@"请先添加支付宝账号" duration:1 position:@"center"];
    }else if( [palyType isEqualToString:@"微信"] && weixinStr.length==0){
        [self.view makeToast:@"请先添加微信账号" duration:1 position:@"center"];
    }else if([palyType isEqualToString:@"银行"] && bankStr.length==0){
        [self.view makeToast:@"请先添加银行卡" duration:1 position:@"center"];
    }else if(monryTextField.text.length==0){
        [self.view makeToast:@"请输入提现金额" duration:1 position:@"center"];
    }else{
        
    }
}
- (void)allwithdramBtnClick{
    monryTextField.text = [NSString stringWithFormat:@"%d",[_moneyStr intValue]];
}
- (void)rightBtn{
    if (isEdit==NO) {
        [self.navigationItem.rightBarButtonItem setTitle:@"取消编辑"];
        isEdit = YES;
    }else{
        isEdit = NO;
        [self.navigationItem.rightBarButtonItem setTitle:@"编辑"];
    }
    [_myTableView reloadData];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
//提现说明
-(void)explainBtnBtnClick{
//    InfoHtmlViewController *vc = [[InfoHtmlViewController alloc]init];
//    vc.title = @"提现说明";
//    vc.urlString = [NSString stringWithFormat:@"%@withdraw/rule.jsp",BaseUrl];
//    [self.navigationController pushViewController:vc animated:YES];
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
