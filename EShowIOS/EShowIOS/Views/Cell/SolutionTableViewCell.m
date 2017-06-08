//
//  SolutionTableViewCell.m
//  EShowIOS
//
//  Created by 王迎军 on 2017/6/2.
//  Copyright © 2017年 王迎军. All rights reserved.
//

#import "SolutionTableViewCell.h"
#import "SolutionCollectionCell.h"


@interface SolutionTableViewCell ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end
@implementation SolutionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (instancetype)CellWithTableView:(UITableView *)tableView reuseIdentify:(NSString *)identify {
    
    SolutionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell == nil) {
        
        cell = [[SolutionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UICollectionViewFlowLayout *collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
        collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;
        collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:collectionViewLayout];
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        self.collectionView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.collectionView];
        [self.collectionView registerNib:[UINib nibWithNibName:@"SolutionCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"SolutionCollectionCell"];
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.bottom.mas_equalTo(self.contentView);
            make.height.mas_equalTo(125).priority(750);
        }];
        
        self.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    }
    return self;
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *solutionCollectionCell = @"SolutionCollectionCell";
    
    SolutionCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:solutionCollectionCell forIndexPath:indexPath];
    
    cell.bgBtn.backgroundColor = RGBColor(125, 186, 24);
    
    
    
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 15, 0, 35);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 15;
}

@end
