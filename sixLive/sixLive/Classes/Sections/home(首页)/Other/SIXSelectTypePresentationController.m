//
//  SIXSelectTypePresentationController.m
//  sixLive
//
//  Created by li’Pro on 2017/7/3.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXSelectTypePresentationController.h"
#import "SIXSelectTypeViewController.h"

@implementation SIXSelectTypePresentationController

- (void)presentationTransitionWillBegin {
    SIXSelectTypeViewController *presentedVC = (SIXSelectTypeViewController *)self.presentedViewController;
    UICollectionView *collectionView = [presentedVC valueForKey:@"collectionView"];
    
    collectionView.height = 1;
    [UIView animateWithDuration:0.25 animations:^{
        collectionView.height = [presentedVC collectionViewHeight];
    }];
}
- (void)presentationTransitionDidEnd:(BOOL)completed {
    
}

//- (void)dismissalTransitionWillBegin {
//    SIXSelectTypeViewController *presentedVC = (SIXSelectTypeViewController *)self.presentedViewController;
//    UICollectionView *collectionView = [presentedVC valueForKey:@"collectionView"];
//    
//    [UIView animateWithDuration:0.25 animations:^{
//        collectionView.height = 1;
//    }];
//}
//- (void)dismissalTransitionDidEnd:(BOOL)completed {
//    SIXSelectTypeViewController *presentedVC = (SIXSelectTypeViewController *)self.presentedViewController;
//    UICollectionView *collectionView = [presentedVC valueForKey:@"collectionView"];
//    
//    
//}


@end
















