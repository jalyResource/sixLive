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
    [self.view addSubview:self.navigationBar];
    WS
    [self.navigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.customStatusBar.mas_bottom);
        make.left.right.equalTo(ws.view);
        make.height.equalTo(@([SIXNavigationBar navigatonBarHeight]));
    }];
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
- (SIXNavigationBar *)navigationBar {
    if (!_navigationBar) {
        _navigationBar = [[SIXNavigationBar alloc] init];
        _navigationBar.delegate = self;
    }
    return _navigationBar;
}

@end



















