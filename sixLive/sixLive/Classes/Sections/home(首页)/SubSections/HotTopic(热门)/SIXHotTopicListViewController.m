//
//  SIXHopTopicListViewController.m
//  sixLive
//
//  Created by li’Pro on 2017/6/28.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXHotTopicListViewController.h"

@interface SIXHotTopicListViewController ()

@end

@implementation SIXHotTopicListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor orangeColor];
//    self.collectionView.backgroundColor = [UIColor cyanColor];
}

- (void)loadData {
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    [self.listModel fetchUserListWithParam:self.params completedCallBack:^(EnumTttpCode code, NSString *infoString) {
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    [self.listModel fetchEventListWithParam:nil completedCallBack:^(EnumTttpCode code, NSString *infoString) {
        dispatch_group_leave(group);
    }];
    
//    dispatch_time_t time = dispat
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
        DLog(@"加载 结束");
    });
}


#pragma -mark 
#pragma -mark UICollectionViewDataSource
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = nil;
    switch ([self.listModel cellTypeAtIndexPath:indexPath]) {
        case EnumListCellTypeBanner: {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:[SIXBannerCollectionViewCell cellReuseIdentifier] forIndexPath:indexPath];
            NSArray<SIXEvent *> *arrEvent = [self.listModel eventArrayForItemAtIndexPath:indexPath];
            ((SIXBannerCollectionViewCell *)cell).arrEvent = arrEvent;
            break;
        }
        case EnumListCellTypeRecomand: {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:[SIXRecCollectionViewCell cellReuseIdentifier] forIndexPath:indexPath];
            NSArray<SIXEvent *> *arrEvent = [self.listModel eventArrayForItemAtIndexPath:indexPath];
            ((SIXRecCollectionViewCell *)cell).arrEvent = arrEvent;
            break;
        }
        case EnumListCellTypeNormal: {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:[SIXListCollectionViewCell cellReuseIdentifier] forIndexPath:indexPath];
            
            ((SIXListCollectionViewCell *)cell).user = [self.listModel userForItemAtIndexPath:indexPath];
            break;
        }
    }
    
    return cell;
}

#pragma -mark 
#pragma -mark UICollectionViewDelegateFlowLayout - collectionView:layout:sizeForItemAtIndexPath:
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    switch ([self.listModel cellTypeAtIndexPath:indexPath]) {
        case EnumListCellTypeBanner: {
            return [SIXBannerCollectionViewCell cellSize];
            break;
        }
        case EnumListCellTypeRecomand: {
            return [SIXRecCollectionViewCell cellSize];
            break;
        }
        case EnumListCellTypeNormal: {
            CGFloat itemWidth = (SIX_SCREEN_WIDTH - 3) / 2.0 ;
            return CGSizeMake(itemWidth, itemWidth);
            break;
        }
    }
    return CGSizeZero;
}

- (SIXHotListModel *)listModel {
    if (!_listModel) {
        _listModel = [[SIXHotListModel alloc] init];
    }
    return (SIXHotListModel *)_listModel;
}

@end





















