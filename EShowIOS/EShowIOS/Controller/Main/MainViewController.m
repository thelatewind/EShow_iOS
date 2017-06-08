//
//  MainViewController.m
//  EShowIOS
//
//  Created by 王迎军 on 2016/11/22.
//  Copyright © 2016年 王迎军. All rights reserved.
//

#import "MainViewController.h"
#import "SolutionTableViewCell.h"
#import "SuccessCaseTableViewCell.h"
#import "AddressPickerViewController.h"
@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (strong, nonatomic) UITableView *myTableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIButton *locationBtn;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"首页";

    [self setupView];
}
- (void)setupView{
    [self.view addSubview:self.myTableView];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.myTableView.tableHeaderView = self.headerView;
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.locationBtn];
    [self changeTitleImageLocation];
    self.navigationItem.leftBarButtonItem = leftItem;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    
    if (indexPath.row == 0) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"titleCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"titleCell"];
            cell.separatorInset = UIEdgeInsetsMake(0, ScreenWidth, 0, 0);
            
            UILabel *contentLabel = [[UILabel alloc] init];
            contentLabel.font = SystemFont(15);
            contentLabel.textColor = KTabBlackTextColor;
            [cell.contentView addSubview:contentLabel];
            [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.mas_equalTo(cell.contentView).offset(15);
                make.top.mas_equalTo(cell.contentView).offset(10);
                make.bottom.mas_equalTo(cell.contentView);
            }];
            contentLabel.tag = 10;
        }
        
        UILabel *label = [cell.contentView viewWithTag:10];
        if (indexPath.section == 0) {
            label.text = @"解决方案";
        } else {
            label.text = @"成功案例";
        }
    } else {
        if (indexPath.section == 0) {
            SolutionTableViewCell *solutionCell = [SolutionTableViewCell CellWithTableView:tableView reuseIdentify:@"SolutionCell"];
            cell = solutionCell;
        } else {
            SuccessCaseTableViewCell *caseCell = [SuccessCaseTableViewCell CellWithTableView:tableView reuseIdentify:@"SuccessCaseCell"];
            caseCell.imgName = @"tmpImage";
            cell = caseCell;
        }
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 0.1f;
    }
    return 15;
}
#pragma mark - 跳转到城市选择
- (void)chooseCities {
    AddressPickerViewController *addressPicker_vc = [[AddressPickerViewController alloc] init];
    addressPicker_vc.hidesBottomBarWhenPushed = YES;
    addressPicker_vc.choseCityBlock = ^(NSString *city) {
        
        [self.locationBtn setTitle:city forState:UIControlStateNormal];
        [self changeTitleImageLocation];
    };
    [self.navigationController pushViewController:addressPicker_vc animated:YES];
}

#pragma mark - 调整按钮文字图片位置
- (void)changeTitleImageLocation {
    
    // 还可增设间距
    CGFloat spacing = 3.0;
    // 图片右移
    CGSize imageSize = self.locationBtn.imageView.frame.size;
    self.locationBtn.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width - spacing, 0.0, imageSize.width);
    // 文字左移
    CGSize titleSize = self.locationBtn.titleLabel.frame.size;
    self.locationBtn.imageEdgeInsets = UIEdgeInsetsMake(0.0, titleSize.width, 0.0, - titleSize.width - spacing);
}

#pragma mark - 懒加载
- (UITableView *)myTableView {
    
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.rowHeight = UITableViewAutomaticDimension;
        _myTableView.estimatedRowHeight = 130;
        _myTableView.sectionFooterHeight = 0.1f;
    }
    return _myTableView;
}

- (UIView *)headerView {
    if (!_headerView) {
        
        _headerView = [[UIView alloc] initWithFrame:CGRectZero];
        _headerView.backgroundColor = [UIColor whiteColor];
        _headerView.translatesAutoresizingMaskIntoConstraints = NO;
        
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"titleImage"]];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        [_headerView addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_headerView);
            make.leading.trailing.mas_equalTo(_headerView);
            make.width.mas_equalTo(ScreenWidth);
            make.height.mas_equalTo(imgView.mas_width).multipliedBy(0.44);
        }];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_headerView addSubview:btn];
        [btn setBackgroundImage:[UIImage imageNamed:@"titleBtnBg"] forState:UIControlStateNormal];
        [btn setTitle:@"马上预约" forState:UIControlStateNormal];
        [btn setTitleColor:RGBColor(255, 124, 43) forState:UIControlStateNormal];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(imgView.mas_bottom);
            make.leading.mas_equalTo(_headerView).offset(28);
            make.trailing.mas_equalTo(_headerView).offset(-28);
            make.height.mas_equalTo(44);
            make.bottom.mas_equalTo(_headerView.mas_bottom).offset(-3);
        }];
        
        [_headerView layoutIfNeeded];
    }
    return _headerView;
}

- (UIButton *)locationBtn {
    
    if (!_locationBtn) {
        
        _locationBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
        _locationBtn.frame = CGRectMake(0, 0, 100, 30);
        UIImage *image = [UIImage imageNamed:@"downArrow"];
        [_locationBtn setImage:image forState:UIControlStateNormal];
        
        NSString *btnTitle;
        if ([[NSUserDefaults standardUserDefaults] stringForKey:@"cityLocation"]) {
            btnTitle = [[NSUserDefaults standardUserDefaults] stringForKey:@"cityLocation"];
        } else {
            btnTitle = @"定位";
        }
        [_locationBtn setTitle:btnTitle forState:UIControlStateNormal];
        [_locationBtn setTitleColor:KTabbarNormalColor forState:UIControlStateNormal];
        _locationBtn.titleLabel.font = SystemFont(15);
        _locationBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_locationBtn addTarget:self action:@selector(chooseCities) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _locationBtn;
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
