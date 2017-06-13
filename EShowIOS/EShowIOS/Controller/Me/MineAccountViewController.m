//
//  MineAccountViewController.m
//  YiShiBang
//
//  Created by 王迎军 on 2017/5/23.
//  Copyright © 2017年 王迎军. All rights reserved.
//

#import "MineAccountViewController.h"
#import "MineAccountInfoViewController.h"
#import "MineAccountWithdrawViewController.h"
@interface MineAccountViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray *titleArr;
    UILabel *moneyLabel;
}


@property (strong, nonatomic) UITableView *myTableView;
@property (strong, nonatomic) UIImageView *headerImage;

@end

@implementation MineAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的账户";
    titleArr = @[@[@"pic_fuwu_moren",@"提现"],@[@"pic_fuwu_moren",@"账单明细"]];
    _headerImage = [UIImageView new];
    _headerImage.image = [UIImage imageWithColor:KTabbarNormalColor];
    _headerImage.contentMode = UIViewContentModeScaleAspectFill;
    _headerImage.clipsToBounds = YES;
    _headerImage.userInteractionEnabled = YES;
    
    _myTableView = [UITableView new];
    _myTableView.backgroundColor = KTabBackgroundColor;
    _myTableView.tableFooterView = [self customFooterView];
    _myTableView.tableHeaderView = [self customHeaderView];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    
    [self.view sd_addSubviews:@[_headerImage,_myTableView]];
    _headerImage.sd_layout.topSpaceToView(self.view, 0).leftEqualToView(self.view).rightEqualToView(self.view).heightIs(200);
    _myTableView.sd_layout.topSpaceToView(_headerImage, 0).leftEqualToView(self.view).rightEqualToView(self.view).bottomEqualToView(self.view);
    [self setHeaderViewContaints];
}
- (void)setHeaderViewContaints{
    UILabel *label = [self setCellFineLabel];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"医师帮收益 (元) ";
    moneyLabel = [self setCellFineLabel];
    moneyLabel.font = [UIFont boldSystemFontOfSize:25];
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    moneyLabel.textColor = [UIColor whiteColor];
    moneyLabel.text = @"12344.22";
    [_headerImage sd_addSubviews:@[label,moneyLabel]];
    label.sd_layout.topSpaceToView(_headerImage, 60).leftEqualToView(_headerImage).rightEqualToView(_headerImage).heightIs(15);
    moneyLabel.sd_layout.topSpaceToView(label, 10).leftEqualToView(_headerImage).rightEqualToView(_headerImage).heightIs(30);
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithColor:RGBColor(241, 251, 255)]];
        UIImageView *titleImage = [UIImageView new];
        titleImage.tag = 102;
        UILabel *typeLabel = [self setCellFineLabel];
        typeLabel.tag = 101;
        UIImageView *imageView = [UIImageView new];
        imageView.image = [UIImage imageNamed:@"ic_home_right"];
        [cell.contentView sd_addSubviews:@[typeLabel,imageView,titleImage]];
        titleImage.sd_layout.leftSpaceToView(cell.contentView, 15).centerYEqualToView(cell.contentView).widthIs(20).heightIs(20);
        typeLabel.sd_layout.leftSpaceToView(titleImage,15).topEqualToView(cell.contentView).rightEqualToView(cell.contentView).bottomEqualToView(cell.contentView);
        imageView.sd_layout.rightSpaceToView(cell.contentView,15).widthIs(16).heightIs(16).topSpaceToView(cell.contentView,16);
    }
    UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:102];
    imageView.image = [UIImage imageNamed:titleArr[indexPath.section][0]];
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:101];
    label.text = titleArr[indexPath.section][1];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        MineAccountWithdrawViewController *withdraw = [[MineAccountWithdrawViewController alloc] init];
        [self.navigationController pushViewController:withdraw animated:YES];
    }else{
        MineAccountInfoViewController *info = [[MineAccountInfoViewController alloc] init];
        [self.navigationController pushViewController:info animated:YES];
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = NO;
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
