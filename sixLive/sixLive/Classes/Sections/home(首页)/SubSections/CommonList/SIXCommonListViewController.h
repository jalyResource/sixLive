//
//  SIXCommonListViewController.h
//  sixLive
//
//  Created by li’Pro on 2017/6/28.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXViewController.h"
#import "SIXCollectionViewListLayout.h"
#import "SIXListCollectionViewCell.h"
#import "SIXBannerCollectionViewCell.h"
#import "SIXRecCollectionViewCell.h"
#import "SIXCommonListModel.h"


/// 默认 URL 为 /coop/mobile/index.php，外界只需传入 params
@interface SIXCommonListViewController : SIXViewController<UICollectionViewDelegate, UICollectionViewDataSource> {
    @protected
    id _listModel;
}

/** UI */
@property (strong, nonatomic) SIXCollectionView *collectionView;

//@property (strong, nonatomic) SIXCommonListModel *listModel;

@property (strong, nonatomic) NSMutableDictionary *dicParams;

- (instancetype)initWithParams:(NSDictionary *)dicParams ;


/**
 调用接口，获取数据
 */
- (void)loadData ;
/**
 注册 collectionView 的cell，子类重写时必须调用父类方法
 */
- (void)registerCollectionViewCellWithCollection:(__kindof UICollectionView *)collectionView NS_REQUIRES_SUPER;

@end
