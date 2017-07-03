//
//  SIXSelectTypeTransition.m
//  sixLive
//
//  Created by li’Pro on 2017/7/3.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXSelectTypeTransition.h"
#import "SIXSelectTypePresentationController.h"
#import "SIXSelectTypeTransitionAnimation.h"

@implementation SIXSelectTypeTransition

#pragma -mark 
#pragma -mark UIViewControllerTransitioningDelegate
//- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source;
//
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[SIXSelectTypeTransitionAnimation alloc] init];
}

- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source NS_AVAILABLE_IOS(8_0) {
    return [[SIXSelectTypePresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}


@end
