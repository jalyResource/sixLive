//
//  SIXSoundViewController.m
//  sixLive
//
//  Created by li’Pro on 2017/6/29.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXSoundViewController.h"
#import "SIXSoundHeaderSupplementaryView.h"

@interface SIXSoundViewController ()

@end

@implementation SIXSoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma -mark 
#pragma -mark 设置 collectionView Supplementary
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    SIXSoundHeaderSupplementaryView *view = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[SIXSoundHeaderSupplementaryView viewReuseIdentifier] forIndexPath:indexPath];
        view.dicParams = self.dicParams;
    }
    
    return view;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return [SIXSoundHeaderSupplementaryView viewSize];
}
/**
 注册 cell
 */
- (void)registerCollectionViewCellWithCollection:(__kindof UICollectionView *)collectionView {
    [super registerCollectionViewCellWithCollection:collectionView];
    
    [collectionView registerClass:[SIXSoundHeaderSupplementaryView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[SIXSoundHeaderSupplementaryView viewReuseIdentifier]];
}






@end
