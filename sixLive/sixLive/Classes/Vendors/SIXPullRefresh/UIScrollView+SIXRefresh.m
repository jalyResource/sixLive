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
#import "NSObject+DLIntrospection.h"

#import <objc/runtime.h>


const NSUInteger SIX_UICollectionView_backgroundView_Tag = 601616;

/** 顶部刷新控件 key */
static char KeySixHeader;

@implementation UIScrollView (SIXRefresh)


#pragma -mark 
#pragma -mark getter setter
- (void)setSix_header:(SIXRefreshComponent *)six_header {
    // 1 、先删除旧 view
    SIXRefreshComponent *oldHeader = objc_getAssociatedObject(self, &KeySixHeader);
    if (oldHeader) {
        [oldHeader removeFromSuperview];
    }
    
    // 2、添加新 view
    objc_setAssociatedObject(self, &KeySixHeader, six_header, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (nil == six_header) {
        return;
    }
    
    if ([self isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self;
        if (nil == collectionView.backgroundView) {
            collectionView.backgroundView = ({
                UIView *viewBg = [[UIView alloc] init];
                viewBg.backgroundColor = [UIColor clearColor];
                viewBg.tag = SIX_UICollectionView_backgroundView_Tag;
                viewBg;
            });
        }
        
//        NSLog(@"%@  %@", collectionView, collectionView.backgroundView.superview);
        
        [collectionView.backgroundView addSubview:six_header];
    } else if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        tableView.backgroundView.tag = SIX_UICollectionView_backgroundView_Tag;
        [tableView.backgroundView addSubview:six_header];
    } else {
        [self addSubview:six_header];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        CGFloat height = six_header.frame.size.height;
        CGRect frameHeader = CGRectMake(0, self.six_realInsetTop, REFRESH_SC_WIDTH, height);
        six_header.frame = frameHeader;
    });
}

- (SIXRefreshComponent *)six_header {
    SIXRefreshComponent *header = objc_getAssociatedObject(self, &KeySixHeader);
    return header;
}


- (CGFloat)six_insetTop {
    return self.contentInset.top;
}
- (void)setSix_insetTop:(CGFloat)six_insetTop {
    UIEdgeInsets inset = self.contentInset;
    inset.top = six_insetTop;
    self.contentInset = inset;
}

- (CGFloat)six_realInsetTop {
    CGFloat top = self.six_insetTop;
    
    if (@available(iOS 11.0, *)) {        
        switch (self.contentInsetAdjustmentBehavior) {
            case UIScrollViewContentInsetAdjustmentNever: {
                break;
            }
            default: {
                top += self.safeAreaInsets.top;
                break;
            }
        }
        
    }
    return top;
}

- (void)setSix_realInsetTop:(CGFloat)six_realInsetTop {
    if (@available(iOS 11.0, *)) {
        switch (self.contentInsetAdjustmentBehavior) {
            case UIScrollViewContentInsetAdjustmentNever: {
                self.six_insetTop = six_realInsetTop;
                break;
            }
            default: {
                self.six_insetTop = six_realInsetTop - self.safeAreaInsets.top;
                break;
            }
        }
    } else {
        self.six_insetTop = six_realInsetTop;
    }
}

@end


















