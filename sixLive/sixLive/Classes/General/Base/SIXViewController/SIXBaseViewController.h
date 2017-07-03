//
//  SIXBaseViewController.h
//  sixLive
//
//  Created by li’Pro on 2017/6/27.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SIXBaseViewController : UIViewController

/**
 状态栏
 */
@property (strong, nonatomic) UIView *customStatusBar;

- (void)showLoading ;
- (void)hiddenLoading ;

@end
