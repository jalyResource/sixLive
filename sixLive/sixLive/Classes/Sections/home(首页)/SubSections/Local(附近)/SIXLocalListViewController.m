//
//  SIXLocalListViewController.m
//  sixLive
//
//  Created by li’Pro on 2017/6/29.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXLocalListViewController.h"
#import "SIXLocalListModel.h"
#import "SIXCollectionSupplementaryView.h"
#import "SIXLocalSelectView.h"

@interface SIXLocalListViewController ()
/** UI */
/** 顶部 显示当前地区 */
@property (strong, nonatomic) SIXLocalSelectView *viewlocalSelect;

@end

@implementation SIXLocalListViewController
@dynamic listModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)loadData {
    [self.listModel fetchUserListWithParam:self.params completedCallBack:^(EnumHttpCode code, NSString *infoString) {
        DLog(@"---- 结束 刷新  --");
        [self.viewlocalSelect setPlaceName:[self.listModel currentProvinceName]];
        [self.collectionView reloadData];
    }];
}


#pragma -mark 
#pragma -mark 设置 collectionView Supplementary
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    SIXCollectionSupplementaryView *view = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[SIXCollectionSupplementaryView viewReuseIdentifier] forIndexPath:indexPath];
        
        [view addSubview:self.viewlocalSelect];
    }
    
    return view;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(SIX_SCREEN_WIDTH, 55);
}

/**
 注册 header
 */
- (void)registerCollectionViewCellWithCollection:(__kindof UICollectionView *)collectionView {
    [super registerCollectionViewCellWithCollection:collectionView];
    
    [collectionView registerClass:[SIXCollectionSupplementaryView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[SIXCollectionSupplementaryView viewReuseIdentifier]];
}

#pragma -mark 
#pragma -mark getters
- (SIXLocalListModel *)listModel {
    if (!_listModel) {
        _listModel = [[SIXLocalListModel alloc] init];
    }
    return (SIXLocalListModel *)_listModel;
}

- (SIXLocalSelectView *)viewlocalSelect {
    if (!_viewlocalSelect) {
        _viewlocalSelect = [[SIXLocalSelectView alloc] initWithFrame:CGRectMake(0, 0, SIX_SCREEN_WIDTH, 55)];
    }
    return _viewlocalSelect;
}

@end














