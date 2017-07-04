//
//  UIScrollView+SIXRefresh.m
//  sixLive
//
//  Created by li’Pro on 2017/7/3.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "UIScrollView+SIXRefresh.h"
#import "SIXPullRefreshMacro.h"
#import "SIXRefreshComponent.h"

#import <objc/runtime.h>

/** 顶部刷新控件 key */
static char KeySixHeader;

@implementation UIScrollView (SIXRefresh)




- (void)setSix_header:(SIXRefreshComponent *)six_header {
    objc_setAssociatedObject(self, &KeySixHeader, six_header, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addSubview:six_header];
    
    CGFloat height = six_header.frame.size.height;
    six_header.frame = CGRectMake(0, - height, REFRESH_SC_WIDTH, height);
}

- (SIXRefreshComponent *)six_header {
    SIXRefreshComponent *header = objc_getAssociatedObject(self, &KeySixHeader);
    return header;
}

@end


















