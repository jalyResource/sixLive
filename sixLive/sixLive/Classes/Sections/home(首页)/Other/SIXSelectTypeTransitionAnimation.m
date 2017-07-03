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
//        SIXSelectTypeViewController *selectTypeVC = (SIXSelectTypeViewController *)fromVC;
        
        // 将控件添加到 collectionView
        UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        fromView.frame = [UIScreen mainScreen].bounds;
        [containerView addSubview:fromView];
        
        UIColor *fromViewOriginColor = fromView.backgroundColor;
        containerView.backgroundColor = fromViewOriginColor;
        
        
        // 修改 fromView 
        fromView.layer.anchorPoint = CGPointMake(0, 64.f / SIX_SCREEN_HEIGHT);
        fromView.layer.position = CGPointMake(0, 64);
        fromView.backgroundColor = [UIColor clearColor];
        
        NSTimeInterval interval = [self transitionDuration:transitionContext];
        [UIView animateWithDuration:interval animations:^{
            fromView.transform = CGAffineTransformMakeScale(1., 0.01);
            containerView.backgroundColor = [UIColor clearColor];
        } completion:^(BOOL finished) {
            fromView.transform = CGAffineTransformIdentity;
            fromView.backgroundColor = fromViewOriginColor;
            [transitionContext completeTransition: !transitionContext.transitionWasCancelled];
        }];
        
    } else {
        [transitionContext completeTransition: !transitionContext.transitionWasCancelled];
    }
}

@end




























