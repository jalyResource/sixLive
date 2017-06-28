//
//  SIXLiveViewController.m
//  sixLive
//
//  Created by li’Pro on 2017/6/27.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXHomeViewController.h"
#import "SIXCommonListViewController.h"

@interface SIXHomeViewController ()
/** UI */
@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) SIXCommonListViewController *commonListViewController;

@end

@implementation SIXHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.commonListViewController = [[SIXCommonListViewController alloc] init];
    [self addChildViewController:self.commonListViewController];
    [self.view addSubview:self.commonListViewController.view];\
    
    self.view.backgroundColor = [UIColor lightGrayColor];
}



- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGFloat y = CGRectGetMaxY(self.headerBar.frame);
    self.commonListViewController.view.frame = CGRectMake(0, y, self.view.width, self.view.height - y);
}





#pragma -mark 
#pragma -mark  SIXNavigationBarDelegate methods
- (void)headerLeftButtonClicked {
    DLog(@"点击搜索");
}
- (void)headerRightButtonClicked {
    DLog(@"%s", __func__);
}


@end



















