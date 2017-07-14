//
//  SIXRefreshComponent.m
//  sixLive
//
//  Created by li’Pro on 2017/7/3.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXRefreshComponent.h"
#import "UIView+SIXRefresh.h"

@interface SIXRefreshComponent()
@property (assign, nonatomic) CGFloat insetTDelta;
@end

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
    
    UIScrollView *scrollView = nil;
    // 刷新控件添加到 UICollectionView 或 UITalbeView 的 backgroundView
    if (SIX_UICollectionView_backgroundView_Tag == newSuperview.tag) {
        scrollView = (UIScrollView *)newSuperview.superview;
    } else // 刷新控件添加到  UISCrollView 
    if ([newSuperview isKindOfClass:[UIScrollView class]]) {
        scrollView = (UIScrollView *)newSuperview;
    }
    
    if (scrollView) {
        _superScrollView = scrollView;
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
        if (self.window == nil) return;
        
        CGFloat insetT = - self.superScrollView.contentOffset.y > self.superScrollViewOriginInsets.top ? - self.superScrollView.contentOffset.y : self.superScrollViewOriginInsets.top;
        insetT = insetT > self.six_height + self.superScrollViewOriginInsets.top ? self.six_height + self.superScrollViewOriginInsets.top : insetT;
        self.superScrollView.six_insetTop = insetT;
        
        self.insetTDelta = self.superScrollViewOriginInsets.top - insetT;
        return;
    }
    
    // 当前的contentOffset
    CGFloat offsetY = self.superScrollView.contentOffset.y;
    // 头部控件刚好出现的offsetY
    CGFloat happenOffsetY = - self.superScrollViewOriginInsets.top;
    if (offsetY > happenOffsetY) return;
    
    if (EnumRefreshStateRefreshEnd != self.state) {
        self.hidden = -newContentOffset.y < self.superScrollViewOriginInsets.top + self.six_height * 0.3;
    }
    
    
    if (_superScrollView.isDragging) {
        if ( (newContentOffset.y < normal2RefreshContentOffsetY)) { // 刷新
            if (EnumRefreshStateRefreshPulling != self.state) {
                self.state = EnumRefreshStateRefreshPulling;
            }
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
    self.state = EnumRefreshStateRefreshing;
}

- (void)setState:(EnumRefreshState)state {
    if (_state == state) {
        return;
    }
    EnumRefreshState oldState = _state;
    _state = state;
    
    if (EnumRefreshStateRefreshing == state) {
        CGFloat top = self.superScrollViewOriginInsets.top + self.six_height;
        
        [UIView animateWithDuration:0.25 animations:^{
            // 增加滚动区域top        
            _superScrollView.six_insetTop = top;
            // 设置滚动位置
            [_superScrollView setContentOffset:CGPointMake(0, -top) animated:NO];
            
        } completion:^(BOOL finished) {
            [self handleRefreshEvent];
        }];
    } else if (EnumRefreshStateRefreshEnd == state) {
        if (EnumRefreshStateRefreshing != oldState) return;
        
        // 恢复inset
        [UIView animateWithDuration:0.25 animations:^{
            self.superScrollView.six_insetTop += self.insetTDelta;
//            self.alpha = 0;
        } completion:^(BOOL finished) {
            self.state = EnumRefreshStateNormal;
            self.hidden = YES;
        }];
    }
    
    [self setNeedsLayout];
}

/**
 处理刷新事件
 */
- (void)handleRefreshEvent {
    
}


/**
 刷新结束调用
 */
- (void)endRefresh {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.state = EnumRefreshStateRefreshEnd;
    });
}

@end
































