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
#import "SIXProvinceListViewController.h"

static CGFloat const HeaderViewHeight = 55.;

@interface SIXLocalListViewController ()<SIXLocalSelectViewDelegate>
/** UI */
/** 顶部 显示当前地区 */
@property (strong, nonatomic) SIXLocalSelectView *viewLocalSelect;
/** 添加到 collectionView header 上，做为 SIXLocalSelectView 的父控件 */
@property (strong, nonatomic) UIView *viewHeader;
/** 展示 省份列表 控制器 */
@property (strong, nonatomic) SIXProvinceListViewController *provinceListVC;

@end

@implementation SIXLocalListViewController
@synthesize listModel;


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
    [self.listModel fetchUserListWithParam:self.dicParams completedCallBack:^(EnumHttpCode code, NSString *infoString) {
        [self hiddenLoading];
        [self.viewLocalSelect setPlaceName:[self.listModel currentProvinceName]];
        [self.collectionView reloadData];
        [self.collectionView.six_header endRefresh];
    }];
}

#pragma -mark 
#pragma -mark KVO : 检测滑动状态，调整 viewlocalSelect 的位置
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (NO == [keyPath isEqualToString:@"contentOffset"]) {
        return;
    }
//    DLog(@"%f", self.collectionView.contentOffset.y);
    // - 65
    if (self.collectionView.contentOffset.y > -self.collectionView.contentInset.top) {
        self.viewLocalSelect.y = self.collectionView.contentInset.top;
        [self.view addSubview:self.viewLocalSelect];
    } else {
        self.viewLocalSelect.frame = CGRectMake(0, 0, SIX_SCREEN_WIDTH, HeaderViewHeight);
        [self.viewHeader addSubview:self.viewLocalSelect];
    }
}

#pragma -mark 
#pragma -mark  SIXLocalSelectViewDelegate 
/**
 展示、隐藏 省份列表
 */
- (void)localSelectViewDidClicked {
//    SIX_SCREEN_HEIGHT - frame.origin.y - SIX_TABBAR_HEIGHT
    
    
    if (self.provinceListVC.view.superview) {
        [UIView animateWithDuration:0.25 animations:^{
            self.provinceListVC.view.height = 0;
        } completion:^(BOOL finished) {
            [self.provinceListVC.view removeFromSuperview];
        }];
    } else {
        self.provinceListVC.currentPId = self.listModel.currentProvinceId;
        self.provinceListVC.arrProvince = self.listModel.provinceArray;
        
        CGRect frame = self.viewLocalSelect.frame;
        frame.origin.y = self.collectionView.contentInset.top + HeaderViewHeight;
        frame.size.height = 1;
        
        self.provinceListVC.view.frame = frame;
        [self.view addSubview:self.provinceListVC.view];
        
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = self.provinceListVC.view.frame;
            frame.size.height = SIX_SCREEN_HEIGHT - frame.origin.y - SIX_TABBAR_HEIGHT;
            self.provinceListVC.view.frame = frame;
        } completion:^(BOOL finished) {
            
        }];
    }
}

#pragma -mark 
#pragma -mark 设置 collectionView Supplementary
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    SIXCollectionSupplementaryView *view = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[SIXCollectionSupplementaryView viewReuseIdentifier] forIndexPath:indexPath];
        
        self.viewHeader.frame = CGRectMake(0, 0, SIX_SCREEN_WIDTH, HeaderViewHeight);
        [view addSubview:self.viewHeader];
        
        self.viewLocalSelect.frame = CGRectMake(0, 0, SIX_SCREEN_WIDTH, HeaderViewHeight);
        [self.viewHeader addSubview:self.viewLocalSelect];
    }
    
    return view;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(SIX_SCREEN_WIDTH, HeaderViewHeight);
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
- (SIXProvinceListViewController *)provinceListVC {
    if (!_provinceListVC) {
        _provinceListVC = [[SIXProvinceListViewController alloc] initWithProvinceArray:self.listModel.provinceArray];
        WS
        _provinceListVC.blockRowClicked = ^(SIXProvince *province) {
            [ws.listModel setCurrentProvince:province];
            [ws.viewLocalSelect setPlaceName:province.title];
            
            ws.dicParams[@"pid"] = province.pid;
            [ws.viewLocalSelect clickedAction];
            [ws loadData];
        };
    }
    return _provinceListVC;
}

- (SIXLocalListModel *)listModel {
    if (!_listModel) {
        _listModel = [[SIXLocalListModel alloc] init];
    }
    return (SIXLocalListModel *)_listModel;
}

- (UIView *)viewHeader {
    if (!_viewHeader) {
        _viewHeader = [[UIView alloc] init];
        _viewHeader.backgroundColor = [UIColor orangeColor];
    }
    return _viewHeader;
}

- (SIXLocalSelectView *)viewLocalSelect {
    if (!_viewLocalSelect) {
        _viewLocalSelect = [[SIXLocalSelectView alloc] initWithFrame:CGRectMake(0, 0, SIX_SCREEN_WIDTH, HeaderViewHeight)];
        _viewLocalSelect.delegate = self;
    }
    return _viewLocalSelect;
}

@end














