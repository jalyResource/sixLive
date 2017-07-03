//
//  SIXMainViewController.m
//  sixLive
//
//  Created by li’Pro on 2017/6/27.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXMainViewController.h"
#import "SIXHomeViewController.h"
#import "SIXBaseViewController.h"
#import "SIXTabBar.h"


@interface SIXMainViewController ()
@property (strong, nonatomic) NSMutableArray<SIXNavigationController *> *arrSubControllers;

@property (strong, nonatomic) SIXNavigationController *navControllerCurrent;

@property (strong, nonatomic) SIXTabBar *viewTabBar;

@end

@implementation SIXMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addChildControllers];
    
    [self addSubViews];
}

- (void)addSubViews {
    [self.view addSubview:self.viewTabBar];
}


/**
 添加子控制器
 */
- (void)addChildControllers {
    self.arrSubControllers = @[].mutableCopy;
    
    SIXHomeViewController *liveViewController = [[SIXHomeViewController alloc] init];
    SIXNavigationController *navController = [[SIXNavigationController alloc] initWithRootViewController:liveViewController];
    
    [self.arrSubControllers addObject:navController];
    [self addChildViewController:navController];
    [self.view addSubview:navController.view];
    
    self.navControllerCurrent = navController;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGRect rect = CGRectMake(0, 0, SIX_SCREEN_WIDTH, SIX_SCREEN_HEIGHT);
    self.navControllerCurrent.view.frame = rect;
    
    // tabBar
    self.viewTabBar.frame = CGRectMake(0, self.view.height - SIX_TABBAR_HEIGHT, self.view.width, SIX_TABBAR_HEIGHT);
}



#pragma -mark 
#pragma -mark getters
- (SIXTabBar *)viewTabBar {
    if (!_viewTabBar) {
        _viewTabBar = [SIXTabBar homeTabBar];
    }
    return _viewTabBar;
}

@end























