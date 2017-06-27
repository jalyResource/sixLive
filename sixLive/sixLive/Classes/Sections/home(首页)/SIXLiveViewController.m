//
//  SIXLiveViewController.m
//  sixLive
//
//  Created by li’Pro on 2017/6/27.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXLiveViewController.h"

@interface SIXLiveViewController ()

@end

@implementation SIXLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
}





#pragma -mark 
#pragma -mark  SIXNavigationBarDelegate 
- (void)headerLeftButtonClicked {
    DLog(@"点击搜索");
}
- (void)headerRightButtonClicked {
    DLog(@"%s", __func__);
}


@end
