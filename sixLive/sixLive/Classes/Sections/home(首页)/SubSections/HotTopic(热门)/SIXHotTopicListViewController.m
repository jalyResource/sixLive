//
//  SIXHopTopicListViewController.m
//  sixLive
//
//  Created by li’Pro on 2017/6/28.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXHotTopicListViewController.h"
#import "SIXRecomendSupplementaryView.h"


@interface SIXHotTopicListViewController ()

@end

@implementation SIXHotTopicListViewController

@dynamic listModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor orangeColor];
//    self.collectionView.backgroundColor = [UIColor cyanColor];
}

- (void)loadData {
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    [self.listModel fetchUserListWithParam:self.params completedCallBack:^(EnumHttpCode code, NSString *infoString) {
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    [self.listModel fetchEventListWithParam:nil completedCallBack:^(EnumHttpCode code, NSString *infoString) {
        dispatch_group_leave(group);
    }];
    
//    dispatch_time_t time = dispat
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
        DLog(@"加载 结束");
    });
}


#pragma -mark 
#pragma -mark 设置 collectionView Supplementary
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    SIXRecomendSupplementaryView *view = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[SIXRecomendSupplementaryView viewReuseIdentifier] forIndexPath:indexPath];
    }
    
    return view;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return [SIXRecomendSupplementaryView viewSize];
}


/**
 注册 cell
 */
- (void)registerCollectionViewCellWithCollection:(__kindof UICollectionView *)collectionView {
    [super registerCollectionViewCellWithCollection:collectionView];
   
    [collectionView registerClass:[SIXRecomendSupplementaryView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[SIXRecomendSupplementaryView viewReuseIdentifier]];
}

#pragma -mark 
#pragma -mark getters
- (SIXHotListModel *)listModel {
    if (!_listModel) {
        _listModel = [[SIXHotListModel alloc] init];
    }
    return (SIXHotListModel *)_listModel;
}

@end





















