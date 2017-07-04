//
//  SIXCommonListViewController.m
//  sixLive
//
//  Created by li’Pro on 2017/6/28.
//  Copyright © 2017年 li’Pro. All rights reserved.
//  先做手机红人

#import "SIXCommonListViewController.h"


@interface SIXCommonListViewController ()


@end

@implementation SIXCommonListViewController

- (instancetype)initWithParams:(NSDictionary *)dicParams {
    if (self = [super init]) {
        self.dicParams = dicParams.mutableCopy;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addSubviews];
    
    [self showLoading];
    [self loadData];
    
    [self setUpHeaderBar];
    DLog(@"---- 开始刷新  --");
}

- (void)setUpHeaderBar {
    self.headerBar.hidden = YES;
}

- (void)addSubviews {
    [self.view addSubview:self.collectionView];
    self.collectionView.frame = self.view.bounds;
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.collectionView.backgroundColor = [UIColor clearColor];
}

- (void)loadData {
    [self.listModel fetchUserListWithParam:self.dicParams completedCallBack:^(EnumHttpCode code, NSString *infoString) {
        if (EnumHttpCodeSuccess == code) {
            [self.collectionView reloadData];
            [self.collectionView removeTipText];
        } else if (EnumHttpCodeFaile == code) {
            [self.collectionView showRefreshTip];
        }
        [self hiddenLoading];
        [self.collectionView.six_header endRefresh];
    }];
}

#pragma -mark 
#pragma -mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger num = [self.listModel numberOfItemsInSection:section];
    DLog(@"numberOfItemsInSection: %ld", num);
    return num;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SIXListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[SIXListCollectionViewCell cellReuseIdentifier] forIndexPath:indexPath];
    
    cell.user = [self.listModel userForItemAtIndexPath:indexPath];
    
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSInteger num = [self.listModel numberOfSections];
    DLog(@"numberOfSectionsInCollectionView: %ld", num);
    return num;
}

#pragma -mark 
#pragma -mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SIXUser *user = [self.listModel userForItemAtIndexPath:indexPath];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"你点击了" message:user.username preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ;
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

//#pragma -mark 
//#pragma -mark UICollectionViewDelegateFlowLayout - collectionView:layout:sizeForItemAtIndexPath:
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    CGFloat itemWidth = (SIX_SCREEN_WIDTH - 3) / 2.0 ;
//    return CGSizeMake(itemWidth, itemWidth);
//}


#pragma -mark 
#pragma -mark getters
- (SIXCollectionView *)collectionView {
    if (!_collectionView) {
        SIXCollectionViewListLayout *layout = [[SIXCollectionViewListLayout alloc] init];
        
        _collectionView = [[SIXCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.contentInset = UIEdgeInsetsMake(SIX_STATUSBAR_HEIGHT + SIX_NAVIGATIONBAR_HEIGHT, 0, SIX_TABBAR_HEIGHT, 0);
        
        [self registerCollectionViewCellWithCollection:_collectionView];
        
        WS
        SIXRefreshNormalHeader *header = [SIXRefreshNormalHeader refreshHeaderWithBlock:^{
            [ws loadData];
        }];
        _collectionView.six_header = header;
    }
    return _collectionView;
}

- (void)registerCollectionViewCellWithCollection:(__kindof UICollectionView *)collectionView {
    [collectionView registerClass:[SIXListCollectionViewCell class] forCellWithReuseIdentifier:[SIXListCollectionViewCell cellReuseIdentifier]];
}

- (SIXCommonListModel *)listModel {
    if (!_listModel) {
        _listModel = [[SIXCommonListModel alloc] init];
    }
    return _listModel;
}

@end



















