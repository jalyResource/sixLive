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
#import "SIXThreeLineAnimationButton.h"


@interface SIXSelectTypeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) SIXSelectTypeModel *selectTypeModel;
/** 默认背景色 */
@property (strong, nonatomic) UIColor *defaultBgColor;

@end

@implementation SIXSelectTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.defaultBgColor = [[UIColor blackColor] colorWithAlphaComponent:0.25];
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.collectionView];
    [self setUpHeaderBar];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.collectionView reloadData];
}

- (void)setUpHeaderBar {
    self.customStatusBar.hidden = YES;
    [self.view bringSubviewToFront:self.headerBar];
    self.headerBar.btnLeft.hidden = YES;
    
    // right button
    SIXThreeLineAnimationButton *btnAnimation = [[SIXThreeLineAnimationButton alloc] initWithFrame:self.headerBar.btnRight.frame];
    [self setHeaderRightButtonWith:btnAnimation];
    self.btnRightHeader = btnAnimation;
}


#pragma -mark 
#pragma -mark  SIXNavigationBarDelegate methods
- (void)headerRightButtonClicked {
//    DLog(@"%s", __func__);
    
    [self.btnRightHeader startAnimation];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.collectionView.height = 0;
        self.collectionView.alpha = 0.7;
        self.view.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self notificationDelegateDidRemoveFromSuperView];
    }];
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
        SIXSelectTypeBtnModel *model = [self.selectTypeModel selectTypeBtnModelAtIndexPath:indexPath];
        model.selected = indexPath.item == self.currentIndex; 
        cell.model = model;
    } else {
        SIXSelectLevelBtnModel *model = [self.selectTypeModel selectLevelBtnModelAtIndexPath:indexPath];
        model.selected = [self.typeOfSound isEqualToString:model.type];
        cell.model = [self.selectTypeModel selectLevelBtnModelAtIndexPath:indexPath];
    }
    
    
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.selectTypeModel numberOfSections];
}

#pragma -mark 
#pragma -mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate) {
        if (0 == indexPath.section) {
            if ([self.delegate respondsToSelector:@selector(selectTypeViewController:didSelectLiveListType:)]) {
                [self.delegate selectTypeViewController:self didSelectLiveListType:indexPath.item];
            }
        } else {
            if ([self.delegate respondsToSelector:@selector(selectTypeViewController:didSelectSoundType:)]) {
                SIXSelectLevelBtnModel *model = [self.selectTypeModel selectLevelBtnModelAtIndexPath:indexPath];
                [self.delegate selectTypeViewController:self didSelectSoundType:model.type];
            }
        }
    }
    
//    [self dismissViewControllerAnimated:NO completion:nil];
    [self.view removeFromSuperview];
    [self notificationDelegateDidRemoveFromSuperView];
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
#pragma -mark private
/**
 * 通知代理，已从父控件移除
 */
- (void)notificationDelegateDidRemoveFromSuperView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectTypeViewControllerDidRemoveFromSuperView)]) {
        [self.delegate selectTypeViewControllerDidRemoveFromSuperView];
    }
}


#pragma -mark 
#pragma -mark getters

- (SIXSelectTypeModel *)selectTypeModel {
    if (!_selectTypeModel) {
        _selectTypeModel = [[SIXSelectTypeModel alloc] init];
    }
    return _selectTypeModel;
}

- (SIXCollectionView *)collectionView {
    if (!_collectionView) {
        SIXSelectTypeLayout *layout = [[SIXSelectTypeLayout alloc] init];
        
        CGRect frame = self.view.bounds;
        frame.origin.y = CGRectGetMaxY(self.headerBar.frame);
        frame.size.height = self.collectionViewHeight;

        
        _collectionView = [[SIXCollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
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













