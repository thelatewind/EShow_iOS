//
//  SuccessCaseTableViewCell.h
//  EShowIOS
//
//  Created by 王迎军 on 2017/6/5.
//  Copyright © 2017年 王迎军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuccessCaseTableViewCell : UITableViewCell


+ (instancetype)CellWithTableView:(UITableView *)tableView reuseIdentify:(NSString *)identify;

@property (nonatomic, copy) NSString *imgName;
@end
