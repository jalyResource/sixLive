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
/** 添加到 collectionView header 上，做为 SIXLocalSelectView 的父控件 */
@property (strong, nonatomic) UIView *viewHeader;

@end

@implementation SIXLocalListViewController
@dynamic listModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.collectionView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}
- (void)dealloc {
    @try {
        [self.collectionView removeObserver:self forKeyPath:@"contentOffset"];
    } @catch (NSException *exception) {
        ;
    }
}

- (void)loadData {
    [self.listModel fetchUserListWithParam:self.params completedCallBack:^(EnumHttpCode code, NSString *infoString) {
        DLog(@"---- 结束 刷新  --");
        [self.viewlocalSelect setPlaceName:[self.listModel currentProvinceName]];
        [self.collectionView reloadData];
    }];
}

#pragma -mark 
#pragma -mark 检测滑动状态，调整 viewlocalSelect 的位置
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (NO == [keyPath isEqualToString:@"contentOffset"]) {
        return;
    }
    // - 65
    if (self.collectionView.contentOffset.y > -self.collectionView.contentInset.top) {
        self.viewlocalSelect.y = self.collectionView.contentInset.top;
        [self.view addSubview:self.viewlocalSelect];
    } else {
        self.viewlocalSelect.y = 0;
        [self.viewHeader addSubview:self.viewlocalSelect];
    }
}

#pragma -mark 
#pragma -mark 设置 collectionView Supplementary
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    SIXCollectionSupplementaryView *view = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[SIXCollectionSupplementaryView viewReuseIdentifier] forIndexPath:indexPath];
        
        self.viewHeader.frame = CGRectMake(0, 0, SIX_SCREEN_WIDTH, 55);
        [view addSubview:self.viewHeader];
        
        self.viewlocalSelect.y = 0;
        [self.viewHeader addSubview:self.viewlocalSelect];
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

- (UIView *)viewHeader {
    if (!_viewHeader) {
        _viewHeader = [[UIView alloc] init];
    }
    return _viewHeader;
}

- (SIXLocalSelectView *)viewlocalSelect {
    if (!_viewlocalSelect) {
        _viewlocalSelect = [[SIXLocalSelectView alloc] initWithFrame:CGRectMake(0, 0, SIX_SCREEN_WIDTH, 55)];
    }
    return _viewlocalSelect;
}

@end














