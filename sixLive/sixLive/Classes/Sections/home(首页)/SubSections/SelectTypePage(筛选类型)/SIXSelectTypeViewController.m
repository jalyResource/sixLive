//
//  SIXSelectTypeViewController.m
//  sixLive
//
//  Created by li’Pro on 2017/6/30.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXSelectTypeViewController.h"
#import "SIXSelectTypeLayout.h"
#import "SIXSelectTypeCollectionViewCell.h"
#import "SIXSelectTypeModel.h"
#import "SIXSelecTypeSupplementaryView.h"
#import "SIXSelectTypeTransition.h"


@interface SIXSelectTypeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

/** 自定义 present 动画 */
@property (strong, nonatomic) SIXSelectTypeTransition *myTransition;

@property (strong, nonatomic) SIXCollectionView *collectionView;

@property (strong, nonatomic) SIXSelectTypeModel *selectTypeModel;

@end

@implementation SIXSelectTypeViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self.myTransition;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.25];
    [self.view addSubview:self.collectionView];
    [self setUpHeaderBar];
}

- (void)setUpHeaderBar {
    self.customStatusBar.hidden = YES;
    [self.view bringSubviewToFront:self.headerBar];
    self.headerBar.btnLeft.hidden = YES;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGRect frame = self.view.bounds;
    frame.origin.y = CGRectGetMaxY(self.headerBar.frame);
    frame.size.height = self.collectionViewHeight;
    self.collectionView.frame = frame; // bottom 140
}

#pragma -mark 
#pragma -mark  SIXNavigationBarDelegate methods
- (void)headerRightButtonClicked {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self headerRightButtonClicked];
}

#pragma -mark 
#pragma -mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.selectTypeModel numberOfItemsInSection:section];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SIXSelectTypeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[SIXSelectTypeCollectionViewCell cellReuseIdentifier] forIndexPath:indexPath];
    
    if (0 == indexPath.section) {
        cell.model = [self.selectTypeModel selectTypeBtnModelAtIndexPath:indexPath];
    } else {
        cell.model = [self.selectTypeModel selectLevelBtnModelAtIndexPath:indexPath];
    }
    
    
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.selectTypeModel numberOfSections];
}

#pragma -mark 
#pragma -mark 设置 collectionView Supplementary
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    SIXSelecTypeSupplementaryView *view = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[SIXSelecTypeSupplementaryView viewReuseIdentifier] forIndexPath:indexPath];
        if (indexPath.section == 1) {
            view.lblTitle.text = @"按表演类型分类";
        } else {
            view.lblTitle.text = @"按主播等级分类";
        }
    }
    
    return view;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return [SIXSelecTypeSupplementaryView viewSize];
}
#pragma -mark 
#pragma -mark public
- (CGFloat)collectionViewHeight {
    return SIX_SCREEN_HEIGHT - 140 - SIX_STATUSBAR_HEIGHT - SIX_NAVIGATIONBAR_HEIGHT;
}


#pragma -mark 
#pragma -mark getters
- (SIXSelectTypeTransition *)myTransition {
    if (!_myTransition) {
        _myTransition = [[SIXSelectTypeTransition alloc] init];
    }
    return _myTransition;
}

- (SIXSelectTypeModel *)selectTypeModel {
    if (!_selectTypeModel) {
        _selectTypeModel = [[SIXSelectTypeModel alloc] init];
    }
    return _selectTypeModel;
}

- (SIXCollectionView *)collectionView {
    if (!_collectionView) {
        SIXSelectTypeLayout *layout = [[SIXSelectTypeLayout alloc] init];
        
        _collectionView = [[SIXCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = SIX_BACKGROUND_COLOR;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
//        _collectionView.contentInset = UIEdgeInsetsMake(SIX_STATUSBAR_HEIGHT + SIX_NAVIGATIONBAR_HEIGHT, 0, SIX_TABBAR_HEIGHT, 0);
        
        [_collectionView registerClass:[SIXSelectTypeCollectionViewCell class] forCellWithReuseIdentifier:[SIXSelectTypeCollectionViewCell cellReuseIdentifier]];
        [_collectionView registerClass:[SIXSelecTypeSupplementaryView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[SIXSelecTypeSupplementaryView viewReuseIdentifier]];
    }
    return _collectionView;
}

@end













