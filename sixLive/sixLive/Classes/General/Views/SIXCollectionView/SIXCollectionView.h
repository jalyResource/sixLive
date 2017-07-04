//
//  SIXCollectionView.h
//  sixLive
//
//  Created by li’Pro on 2017/6/28.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SIXCollectionView : UICollectionView

/**
 显示 : 请下拉刷新试试
 */
- (void)showRefreshTip ;

/**
 显示出错信息

 @param text 展示信息
 */
- (void)showTipText:(NSString *)text ;

/**
 去掉错误提示
 */
- (void)removeTipText ;

@end
