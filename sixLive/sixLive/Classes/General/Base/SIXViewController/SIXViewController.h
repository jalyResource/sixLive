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

@property (strong, nonatomic) SIXNavigationBar *navigationBar;


- (void)back ;

@end
