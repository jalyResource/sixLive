//
//  SIXMainViewController.m
//  sixLive
//
//  Created by li’Pro on 2017/6/27.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXMainViewController.h"
#import "SIXLiveViewController.h"
#import "SIXBaseViewController.h"


@interface SIXMainViewController ()
@property (strong, nonatomic) NSMutableArray<SIXNavigationController *> *arrSubControllers;

@property (strong, nonatomic) SIXNavigationController *navControllerCurrent;
@end

@implementation SIXMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addChildControllers];
}


/**
 添加子控制器
 */
- (void)addChildControllers {
    self.arrSubControllers = @[].mutableCopy;
    
    SIXLiveViewController *liveViewController = [[SIXLiveViewController alloc] init];
    SIXNavigationController *navController = [[SIXNavigationController alloc] initWithRootViewController:liveViewController];
    
    [self.arrSubControllers addObject:navController];
    [self addChildViewController:navController];
    [self.view addSubview:navController.view];
    
    self.navControllerCurrent = navController;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGRect rect = CGRectMake(0, 0, SIX_SCREEN_WIDTH, SIX_SCREEN_HEIGHT - 45);
    self.navControllerCurrent.view.frame = rect;
}





@end























