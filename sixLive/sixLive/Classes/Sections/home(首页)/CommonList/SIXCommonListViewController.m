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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpHeaderBar];
    [self addSubviews];
    [self loadData];
    
    DLog(@"---- 开始刷新  --");
}

- (void)setUpHeaderBar {
    self.headerBar.hidden = YES;
}

- (void)addSubviews {
    [self.view addSubview:self.collectionView];
    self.collectionView.frame = self.view.bounds;
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.collectionView.backgroundColor = [UIColor orangeColor];
}

- (void)loadData {
    NSDictionary *dicParams = @{
                                @"av" : @(2.1),
                                @"p"  : @(0),
                                @"rate": @1,
                                @"size" : @0,
                                @"type" : @"mlive",
                                @"padapi" : @"coop-mobile-getlivelistnew.php"
                                };
    /*
     av:2.1
     p : 0
     rate : 1
     size ： 0
     type : ""
     // 说明 type： 热门 ："", 手机红人：mlive
     */
    [self.commonListModel fetchUserListWithParam:dicParams completedCallBack:^(EnumTttpCode code, NSString *infoString) {
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



















