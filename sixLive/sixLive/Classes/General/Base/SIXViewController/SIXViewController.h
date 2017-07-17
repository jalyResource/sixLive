//
//  SIXViewController.h
//  sixLive
//
//  Created by li’Pro on 2017/6/27.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXBaseViewController.h"
#import "SIXNavigationBar.h"

@interface SIXViewController : SIXBaseViewController<SIXNavigationBarDelegate>

@property (strong, nonatomic) SIXNavigationBar *headerBar;

/**
 * 定制导航栏右侧按钮
 */
- (void)setHeaderRightButtonWith:(__kindof UIButton *)btn ;


- (void)back ;

@end
