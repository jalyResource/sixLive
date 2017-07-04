//
//  SIXSelectTypeTransitionAnimation.m
//  sixLive
//
//  Created by li’Pro on 2017/7/3.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXSelectTypeTransitionAnimation.h"
#import "SIXSelectTypeViewController.h"

// dismiss 动画
@implementation SIXSelectTypeTransitionAnimation


- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.2;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    if ([fromVC isKindOfClass:[SIXSelectTypeViewController class]]) {
        SIXSelectTypeViewController *selectTypeVC = (SIXSelectTypeViewController *)fromVC;
        // 将控件添加到 collectionView
        UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        UICollectionView *collectionView = [selectTypeVC valueForKey:@"collectionView"];
        
        CGRect frameCollectionViewOrigin = collectionView.frame;
        
        
        UIColor *fromViewOriginColor = fromView.backgroundColor;
        containerView.backgroundColor = fromViewOriginColor;
        
        
        [containerView addSubview:collectionView];
      
        
        NSTimeInterval interval = [self transitionDuration:transitionContext];
        [UIView animateWithDuration:interval animations:^{
            collectionView.height = 1;
            containerView.backgroundColor = [UIColor clearColor];
        } completion:^(BOOL finished) {
            
            collectionView.frame = frameCollectionViewOrigin;
            [fromView addSubview:collectionView];
            [transitionContext completeTransition: !transitionContext.transitionWasCancelled];
        }];
        
    } else {
        [transitionContext completeTransition: !transitionContext.transitionWasCancelled];
    }
}

@end




























