//
//  UIScrollView+SIXRefresh.m
//  sixLive
//
//  Created by li’Pro on 2017/7/3.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "UIScrollView+SIXRefresh.h"
#import "SIXPullRefreshMacro.h"

#import <objc/runtime.h>


static char KeySixHeader;

@implementation UIScrollView (SIXRefresh)




- (void)setSix_header:(UIView *)six_header {
    objc_setAssociatedObject(self, &KeySixHeader, six_header, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addSubview:six_header];
    
    CGFloat height = 49;
    
    six_header.frame = CGRectMake(0, -49, REFRESH_SC_WIDTH, height);
}

- (UIView *)six_header {
    UIView *header = objc_getAssociatedObject(self, &KeySixHeader);
    return header;
}

@end


















