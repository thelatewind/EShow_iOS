//
//  WithdrawTableViewCell.m
//  YiShiBang
//
//  Created by 王迎军 on 2017/5/23.
//  Copyright © 2017年 王迎军. All rights reserved.
//

#import "WithdrawTableViewCell.h"

@implementation WithdrawTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.icon = [[UIImageView alloc] init];
        [self.contentView addSubview:self.icon];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = SystemFont(15);
        self.titleLabel.textColor = [JKUtil getColor:@"333333"];
        [self.contentView addSubview:self.titleLabel];
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.font = SystemFont(14);
        self.contentLabel.textColor = [JKUtil getColor:@"999999"];
        [self.contentView addSubview:self.contentLabel];
        
        self.rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        //self.rightBtn.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:self.rightBtn];
        
        [self setSubViewConstraints];
    }
    return self;
}
- (void)setSubViewConstraints{
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(40*ScaleSize);
        make.height.mas_equalTo(40*ScaleSize);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(10);
        make.bottom.equalTo(self.icon.mas_centerY).offset(-5);
        make.height.mas_equalTo(20*ScaleSize);
    }];
    
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.centerY.equalTo(self.icon.mas_centerY);
        make.height.mas_equalTo(20*ScaleSize);
        make.width.mas_equalTo(20*ScaleSize);
        
    }];
    
    //里面的界面不需要显示 titleLabel
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.right.equalTo(self.rightBtn.mas_left).offset(20);
        make.top.equalTo(self.icon.mas_centerY).offset(5);
        make.height.mas_equalTo(20*ScaleSize);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
