//
//  SIXRefreshComponent.m
//  sixLive
//
//  Created by li’Pro on 2017/7/3.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXRefreshComponent.h"
#import "UIView+SIXRefresh.h"

@implementation SIXRefreshComponent

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.state = EnumRefreshStateNormal;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    [self removeObserver];
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        _superScrollView = (UIScrollView *)self.superview;
        _superScrollView.alwaysBounceVertical = YES;
        self.superScrollViewOriginInsets = _superScrollView.contentInset;
        
        [self addObserver];
    }
}

#pragma -mark 
#pragma -mark KVO
- (void)addObserver {
    [_superScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}
- (void)removeObserver {
    if ( _superScrollView ) {
        [_superScrollView removeObserver:self forKeyPath:@"contentOffset"];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint newPoint =  [[change valueForKey:@"new"] CGPointValue];
        [self refreshHeaderContentOffsetDidChange:newPoint];
    }
    /*
     {
     kind = 1;
     new = "NSPoint: {0, -65}";
     old = "NSPoint: {0, -65.5}";
     }
     */
}

#pragma -mark 
#pragma -mark public
- (void)refreshHeaderContentOffsetDidChange:(CGPoint)newContentOffset {
//    DLog(@"contentInset.top: %lf   self.height:%lf", _superScrollView.contentInset.top, self.six_height);
    CGFloat normal2RefreshContentOffsetY = -self.superScrollViewOriginInsets.top - self.six_height;
    
    if (self.state == EnumRefreshStateRefreshing) {
        // 设置 contentOffset 显示刷新控件
        UIEdgeInsets insets = self.superScrollViewOriginInsets;
        insets.top = - normal2RefreshContentOffsetY;
        _superScrollView.contentInset = insets;
        
        return;
    }
    
    if (_superScrollView.isDragging) {
        if (newContentOffset.y < normal2RefreshContentOffsetY) { // 刷新
            self.state = EnumRefreshStateRefreshPulling;
        } else { // 不刷新
            if (self.state != EnumRefreshStateNormal) {
                self.state = EnumRefreshStateNormal;
            }
        }
    } else {
        // 放手时
        //   刷新控件完全显示   --刷新
        //   刷新控件不完全显示 --不刷新
        if (EnumRefreshStateRefreshPulling ==  self.state) {
            if (newContentOffset.y < normal2RefreshContentOffsetY) { // 刷新
                [self beganRefresh];
            } else { // 不刷新
                
            }
        }
        
    }
}

- (void)beganRefresh {
    DLog(@"开始刷新");
    self.state = EnumRefreshStateRefreshing;
}

- (void)setState:(EnumRefreshState)state {
    _state = state;
    
    if (EnumRefreshStateRefreshEnd == state) { // 刷新 ---> 刷新结束
         [UIView animateWithDuration:0.25 animations:^{
             _superScrollView.contentInset = self.superScrollViewOriginInsets;
         }];
    }
    
    
}

/**
 刷新结束调用
 */
- (void)endRefresh {
    self.state = EnumRefreshStateRefreshEnd;
}

@end
































