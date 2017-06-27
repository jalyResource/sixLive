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
    WS
    [_customStatusBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.view);
        make.top.equalTo(ws.view);
        make.width.equalTo(ws.view);
        make.height.mas_equalTo(SIX_STATUSBAR_HEIGHT);
    }];
    
    self.view.backgroundColor = SIX_BACKGROUND_COLOR;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//对应旋转
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return  NO;
}

// 是否支持屏幕旋转
- (BOOL)shouldAutorotate
{
    return NO;
}

// 支持的旋转方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}


@end














