//
//  MineBankOpenAccountChooseViewController.m
//  YiShiBang
//
//  Created by 王迎军 on 2017/6/12.
//  Copyright © 2017年 王迎军. All rights reserved.
//

#import "MineBankOpenAccountChooseViewController.h"

@interface MineBankOpenAccountChooseViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *tableV;
    NSMutableArray *leftTitleArr;
    NSString *num;
    NSInteger _page;
    UIView *footer;
}

@end

@implementation MineBankOpenAccountChooseViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self accountRequest];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"请选择银行卡";
    [self createDate];
    [self createUI];

}
-(void)createDate{
    leftTitleArr = [NSMutableArray array];
}
-(void)accountRequest{
    [[NetworkEngine sharedManager] request_BankCardList_WithParams:@{} andBlock:^(id data, NSError *error) {
        
    }];
//    NSDictionary *dict = @{
//                           @"accessToken":[YUserDefaults objectForKey:@"accessTokenLogin"]
//                           };
//    NSString *url = [NSString stringWithFormat:@"%@system/bank.json?",BaseUrl];
//    [[NetworkEngine sharedManager] getParameter:dict url:url successBlock:^(id responseBody) {
//        NSDictionary *dic = (NSDictionary *)responseBody;
//        
//        if([dic[@"status"] integerValue]==1){
//            for (NSDictionary *diction in dic[@"banks"]) {
//                [leftTitleArr addObject:diction];
//            }
//            [tableV reloadData];
//        }else{
//            [self setfooterView];
//            //[self.view makeToast:dic[@"msg"] duration:1 position:@"center"];
//        }
//    } failureBlock:^(NSString *error) {
//        [self setfooterView];
//        [self.view makeToast:@"网络连接失败" duration:1 position:@"center"];
//    }];
}
- (void)setfooterView{
    footer = [UIView new];
    footer.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    footer.backgroundColor = [JKUtil getColor:@"eeeeee"];
    [self.view addSubview:footer];
    
    //没有内容的文字
    UILabel *label = [[UILabel alloc]init];
    label.text = @"您还没有任何银行卡，请添加...";
    label.textColor = [UIColor darkGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    [footer addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(footer);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(44);
    }];
    //图片
    UIImageView *imageV = [[UIImageView alloc]init];
    imageV.image = [UIImage imageNamed:@"ic_bisai_ready"];
    [footer addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(label.mas_top).offset(10);
        make.centerX.equalTo(footer);
        make.height.mas_equalTo(150*ScaleSize);
        make.width.mas_equalTo(150*ScaleSize);
    }];
    
    // [self.view addSubview:footer];
}

-(void)createUI{
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
    tableV.delegate = self;
    tableV.backgroundColor = KTabBackgroundColor;
    tableV.dataSource = self;
    tableV.showsVerticalScrollIndicator = NO;
    tableV.tableFooterView = [[UIView alloc]init];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 15)];
    view.backgroundColor = KTabBackgroundColor;
    tableV.tableHeaderView = view;
    [self.view addSubview:tableV];
}

-(void)presentBtnClick{
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return leftTitleArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44*ScaleSize;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifier = @"indentifier";
    UITableViewCell *cell = [tableV cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indentifier];
    }
    if (leftTitleArr.count==0) {
        
    }else{
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.text = leftTitleArr[indexPath.row][@"bankName"];
        cell.textLabel.textColor =  RGBColor(51, 51, 51);
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-40*ScaleSize, 12*ScaleSize, 20*ScaleSize, 20*ScaleSize)];
        if ([[NSString stringWithFormat:@"%ld",indexPath.row] isEqualToString:num]) {
            img.image = [UIImage imageNamed:@"box_choiced"];
        }else{
            img.image = [UIImage imageNamed:@"box_unchoice"];
        }
        [cell.contentView addSubview:img];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    num = [NSString stringWithFormat:@"%ld",indexPath.row];
    [tableView reloadData];
    if (self.backVonseBlock) {
        self.backVonseBlock(leftTitleArr[indexPath.row][@"bankName"],leftTitleArr[indexPath.row][@"bankIcon"]);
    }
    [self performSelector:@selector(back) withObject:nil afterDelay:0.5];
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
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
