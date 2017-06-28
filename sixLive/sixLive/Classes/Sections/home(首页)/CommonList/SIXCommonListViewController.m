//
//  SIXCommonListViewController.m
//  sixLive
//
//  Created by li’Pro on 2017/6/28.
//  Copyright © 2017年 li’Pro. All rights reserved.
//  先做手机红人

#import "SIXCommonListViewController.h"
#import "SIXCommonListModel.h"


@interface SIXCommonListViewController ()

/** UI */
@property (strong, nonatomic) SIXCollectionView *collectionView;

@property (strong, nonatomic) SIXCommonListModel *commonListModel;

@end

@implementation SIXCommonListViewController

- (instancetype)initWithParams:(NSDictionary *)params {
    if (self = [super init]) {
        self.params = params;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addSubviews];
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
    [self.commonListModel fetchUserListWithParam:self.params completedCallBack:^(EnumTttpCode code, NSString *infoString) {
        DLog(@"---- 结束 刷新  --");
        
        [self.collectionView reloadData];
    }];
}

#pragma -mark 
#pragma -mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.commonListModel numberOfItemsInSection:section];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SIXListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[SIXListCollectionViewCell cellReuseIdentifier] forIndexPath:indexPath];
    
    cell.user = [self.commonListModel userForItemAtIndexPath:indexPath];
    
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.commonListModel numberOfSections];
}


#pragma -mark 
#pragma -mark getters
- (SIXCollectionView *)collectionView {
    if (!_collectionView) {
        SIXCollectionViewListLayout *layout = [[SIXCollectionViewListLayout alloc] init];
        
        _collectionView = [[SIXCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView registerClass:[SIXListCollectionViewCell class] forCellWithReuseIdentifier:[SIXListCollectionViewCell cellReuseIdentifier]];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.contentInset = UIEdgeInsetsMake(SIX_STATUSBAR_HEIGHT + SIX_NAVIGATIONBAR_HEIGHT, 0, SIX_TABBAR_HEIGHT, 0);
    }
    return _collectionView;
}

- (SIXCommonListModel *)commonListModel {
    if (!_commonListModel) {
        _commonListModel = [[SIXCommonListModel alloc] init];
    }
    return _commonListModel;
}

@end



















