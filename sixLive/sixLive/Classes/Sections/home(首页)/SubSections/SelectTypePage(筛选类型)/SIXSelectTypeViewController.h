//
//  SIXSelectTypeViewController.h
//  sixLive
//
//  Created by li’Pro on 2017/6/30.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXViewController.h"
#import "SIXHomeViewController.h"
@class SIXSelectTypeViewController;
@class SIXAnimationButton;

@protocol SIXSelectTypeViewControllerDelegate <NSObject>
@optional
/**
 * 点击 section 0，选择 某个 分类类型
 */
- (void)selectTypeViewController:(SIXSelectTypeViewController *)viewController didSelectLiveListType:(EnumLiveListType)type ;
/**
 * 点击 section 1，选中好声音的 某个具体类型
 */
- (void)selectTypeViewController:(SIXSelectTypeViewController *)viewController didSelectSoundType:(NSString *)type ;

/**
 * 从父控件移除
 */
- (void)selectTypeViewControllerDidRemoveFromSuperView ;

@end



@interface SIXSelectTypeViewController : SIXViewController

@property (weak, nonatomic) id<SIXSelectTypeViewControllerDelegate> delegate;

@property (strong, nonatomic) SIXCollectionView *collectionView;

@property (weak, nonatomic) SIXAnimationButton *btnRightHeader;

/**
 home 页，当前显示列表的 index
 */
@property (assign, nonatomic) NSUInteger currentIndex ;


/**
 好声音，的具体子选项
 */
@property (copy, nonatomic) NSString *typeOfSound;

/**
 * 获取 collectionView 的高度
 */
- (CGFloat)collectionViewHeight ;

@end


















