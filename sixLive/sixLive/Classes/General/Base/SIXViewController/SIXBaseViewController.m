//
//  SIXBaseViewController.m
//  sixLive
//
//  Created by li’Pro on 2017/6/27.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXBaseViewController.h"

@interface SIXBaseViewController ()

@end

@implementation SIXBaseViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.edgesForExtendedLayout = UIRectEdgeAll;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加状态栏
    _customStatusBar = [[UIView alloc] init];
    _customStatusBar.backgroundColor = SIX_BACKGROUND_COLOR;
    [self.view addSubview:_customStatusBar];
   
    
    self.view.backgroundColor = SIX_BACKGROUND_COLOR;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (self.customStatusBar) {
        self.customStatusBar.frame = CGRectMake(0, 0, SIX_SCREEN_WIDTH, SIX_STATUSBAR_HEIGHT);
    }
}

@end














