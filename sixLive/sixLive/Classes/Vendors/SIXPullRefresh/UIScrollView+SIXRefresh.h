//
//  UIScrollView+SIXRefresh.h
//  sixLive
//
//  Created by li’Pro on 2017/7/3.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SIXRefreshComponent;

FOUNDATION_EXPORT const NSUInteger SIX_UICollectionView_backgroundView_Tag;

@interface UIScrollView (SIXRefresh)

@property (strong, nonatomic) SIXRefreshComponent *six_header;

@property (assign, nonatomic) CGFloat six_insetTop;

/** 
 实际顶部 inset
 */
@property (assign, nonatomic) CGFloat six_realInsetTop;

@end
