//
//  SIXBaseViewController.m
//  sixLive
//
//  Created by li’Pro on 2017/6/27.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXBaseViewController.h"

@interface SIXBaseViewController ()
/** 等待指示器 */
@property (strong, nonatomic) UIActivityIndicatorView *viewLoading;

@end

@implementation SIXBaseViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.edgesForExtendedLayout = UIRectEdgeAll;
        
        if (@available(iOS 11.0, *)) {
            
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加状态栏
    _customStatusBar = [[UIView alloc] init];
    _customStatusBar.backgroundColor = SIX_BACKGROUND_COLOR;
    _customStatusBar.frame = CGRectMake(0, 0, SIX_SCREEN_WIDTH, SIX_STATUSBAR_HEIGHT);
    [self.view addSubview:_customStatusBar];
    
    self.view.backgroundColor = SIX_BACKGROUND_COLOR;
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    // viewLoading
    CGFloat width = 20;
    CGFloat x = (self.view.width - width) / 2.0;
    CGFloat y = (self.view.height - width) / 2.0;
    self.viewLoading.frame = CGRectMake(x, y, 20, 20);
}

- (UIStatusBarStyle)preferredStatusBarStyle {
//    [self setNeedsStatusBarAppearanceUpdate];
    return UIStatusBarStyleLightContent;
}

#pragma -mark 
#pragma -mark public
- (void)showLoading {
    [self.view addSubview:self.viewLoading];
    [self.view bringSubviewToFront:self.viewLoading];
    
    
    [self.viewLoading startAnimating];
}
- (void)hiddenLoading {
    [self.viewLoading stopAnimating];
}

#pragma -mark 
#pragma -mark getters
- (UIActivityIndicatorView *)viewLoading {
    if (!_viewLoading) {
        _viewLoading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _viewLoading.hidesWhenStopped = YES;
    }
    return _viewLoading;
}

@end
























