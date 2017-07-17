//
//  SIXViewController.m
//  sixLive
//
//  Created by li’Pro on 2017/6/27.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXViewController.h"

@interface SIXViewController ()

@end

@implementation SIXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}

- (void)setUp {
    [self.view addSubview:self.headerBar];
    self.headerBar.frame = CGRectMake(0, SIX_STATUSBAR_HEIGHT, SIX_SCREEN_WIDTH, SIX_NAVIGATIONBAR_HEIGHT);
}


#pragma -mark 
#pragma -mark public 
/**
 * 定制导航栏右侧按钮
 */
- (void)setHeaderRightButtonWith:(__kindof UIButton *)btn {
    SEL sel = @selector(btnRightClicked:);
    [btn addTarget:self.headerBar action:sel forControlEvents:UIControlEventTouchUpInside];
    
//    btn.frame = self.headerBar.btnRight.frame;
    [self.headerBar addSubview:btn];
    [self.headerBar.btnRight removeFromSuperview];
    self.headerBar.btnRight = btn;
}


#pragma -mark 
#pragma -mark  SIXNavigationBarDelegate 
- (void)headerLeftButtonClicked {
    [self back];
}
- (void)headerRightButtonClicked {
    DLog(@"%s", __func__);
}


- (void)back {
    if (self.navigationController.visibleViewController == [self.navigationController.viewControllers firstObject]) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma -mark 
#pragma -mark getters
- (SIXNavigationBar *)headerBar {
    if (!_headerBar) {
        _headerBar = [[SIXNavigationBar alloc] init];
        _headerBar.delegate = self;
    }
    return _headerBar;
}

@end



















