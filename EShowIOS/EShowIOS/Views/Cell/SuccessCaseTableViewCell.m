//
//  SuccessCaseTableViewCell.m
//  EShowIOS
//
//  Created by 王迎军 on 2017/6/5.
//  Copyright © 2017年 王迎军. All rights reserved.
//

#import "SuccessCaseTableViewCell.h"
@interface SuccessCaseTableViewCell ()

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation SuccessCaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)CellWithTableView:(UITableView *)tableView reuseIdentify:(NSString *)identify {
    
    SuccessCaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell == nil) {
        
        cell = [[SuccessCaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        self.imgView = [[UIImageView alloc] init];
        self.imgView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.imgView];
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.mas_equalTo(self.contentView).offset(15);
            make.trailing.mas_equalTo(self.contentView).offset(-15);
            make.height.mas_equalTo(self.imgView.mas_width).multipliedBy(0.524);
        }];
        
        self.contentLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.contentLabel];
        self.contentLabel.font = SystemFont(15);
        self.contentLabel.textColor = KTabBlackTextColor;
        self.contentLabel.numberOfLines = 0;
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.contentView).offset(15);
            make.top.mas_equalTo(self.imgView.mas_bottom).offset(10);
            make.trailing.mas_equalTo(self.contentView).offset(-15);
            make.bottom.mas_equalTo(self.contentView).offset(-12);
        }];
        
    }
    
    return self;
    
}


- (void)setImgName:(NSString *)imgName {
    _imgName = imgName;
    
    self.imgView.image = [UIImage imageNamed:imgName];
    
    self.contentLabel.text = @"2016智慧校园项目";
}

@end
