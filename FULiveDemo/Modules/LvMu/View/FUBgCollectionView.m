//
//  FUBgCollectionView.m
//  FULiveDemo
//
//  Created by 孙慕 on 2020/8/18.
//  Copyright © 2020 FaceUnity. All rights reserved.
//

#import "FUBgCollectionView.h"

static NSString *bgCellId = @"FUBgCollectionView";

@interface FUBgCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation FUBgCollectionView


-(instancetype)init{
    if (self = [super init]) {
        [self setupView];
    }
    return self;
}

-(void)setupView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 30;
    layout.itemSize = CGSizeMake(54, 74);
    layout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 80);
    _mBgCollectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    _mBgCollectionView.backgroundColor = [UIColor clearColor];
    _mBgCollectionView.delegate = self;
    _mBgCollectionView.dataSource = self;
    [self addSubview:_mBgCollectionView];
    [_mBgCollectionView registerClass:[FUBgFilterCell class] forCellWithReuseIdentifier:bgCellId];
    
    _selectedIndex = -1;
}


-(void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex ;
    [_mBgCollectionView reloadData];
    
    FUBeautyParam *model = _filters[_selectedIndex];
    if (self.mDelegate && [self.mDelegate respondsToSelector:@selector(bgCollectionViewDidSelectedFilter:)]) {
        [self.mDelegate bgCollectionViewDidSelectedFilter:model];
    }
}





#pragma mark ---- UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.filters.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FUBgFilterCell *cell = (FUBgFilterCell *)[collectionView dequeueReusableCellWithReuseIdentifier:bgCellId forIndexPath:indexPath];
    
    FUBeautyParam *model = _filters[indexPath.row];
    
    cell.titleLabel.text = NSLocalizedString(model.mTitle,nil);
    cell.titleLabel.textColor = [UIColor whiteColor];
    cell.imageView.image = [UIImage imageNamed:model.mImageStr];
    
    cell.imageView.layer.borderWidth = 0.0 ;
    cell.imageView.layer.borderColor = [UIColor clearColor].CGColor;
    
    if (_selectedIndex == indexPath.row) {
        
        cell.imageView.layer.borderWidth = 2.0 ;
        cell.imageView.layer.borderColor = [UIColor fu_colorWithHexColorString:@"5EC7FE"].CGColor;
        cell.titleLabel.textColor = [UIColor fu_colorWithHexColorString:@"5EC7FE"];
    }
    
    return cell ;
}

#pragma mark ---- UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    _selectedIndex = indexPath.row ;
    [self.mBgCollectionView reloadData];
    
    FUBeautyParam *model = _filters[indexPath.row];
    
    if (self.mDelegate && [self.mDelegate respondsToSelector:@selector(bgCollectionViewDidSelectedFilter:)]) {
        [self.mDelegate bgCollectionViewDidSelectedFilter:model];
    }
}

#pragma mark ---- UICollectionViewDelegateFlowLayout


@end


@implementation FUBgFilterCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 54, 54)];
        self.imageView.layer.masksToBounds = YES ;
        self.imageView.layer.cornerRadius = 3.0 ;
        self.imageView.layer.borderWidth = 0.0 ;
        self.imageView.layer.borderColor = [UIColor clearColor].CGColor ;
        [self addSubview:self.imageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(-8, 54, 70, frame.size.height - 54)];
        self.titleLabel.textAlignment = NSTextAlignmentCenter ;
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        [self addSubview:self.titleLabel];
    }
    return self ;
}
@end
