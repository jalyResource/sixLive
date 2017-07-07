//
//  SIXRefreshNormalHeader.m
//  sixLive
//
//  Created by li’Pro on 2017/7/4.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXRefreshNormalHeader.h"
#import "UIView+SIXRefresh.h"

NSString *TipTextNormal = @"下拉刷新";
NSString *TipTextRefreshPulling = @"释放更新";
NSString *TipTextRefreshing = @"加载中...";
NSString *TipTextRefreshEnd = @"加载完成";

@interface SIXRefreshNormalHeader ()

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicatorView;
@property (strong, nonatomic) UILabel *lblTitle;
@property (strong, nonatomic) UIImageView *imgViewArrow;

@end

@implementation SIXRefreshNormalHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    [self addSubview:self.imgViewArrow];
    [self addSubview:self.lblTitle];
    [self addSubview:self.activityIndicatorView];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:NO];
    
    CGFloat centerX = self.six_width / 2.0;
    CGFloat centerY = self.six_height / 2.0;
    self.imgViewArrow.center = self.activityIndicatorView.center = CGPointMake(centerX -  40, centerY);
    
    self.lblTitle.frame = CGRectMake(centerX - 10, 0, centerX, centerY * 2);
    
    [CATransaction commit];
}


- (void)setState:(EnumRefreshState)state {
    if (_state == state) {
        return;
    }
//    EnumRefreshState oldState = _state;
    [super setState:state];
    
    
    [self.activityIndicatorView stopAnimating];
    self.imgViewArrow.hidden = NO;
    
    switch (state) {
        case EnumRefreshStateNormal: {
            {
                self.lblTitle.text = TipTextNormal;
            }
            break;
        }
        case EnumRefreshStateRefreshPulling: {
            self.lblTitle.text = TipTextRefreshPulling;
            break;
        }
        case EnumRefreshStateRefreshing: {
            self.lblTitle.text = TipTextRefreshing;
            [self.activityIndicatorView startAnimating];
            self.imgViewArrow.hidden = YES;
            break;
        }
        case EnumRefreshStateRefreshEnd: {
            self.lblTitle.text = TipTextRefreshEnd;
            self.imgViewArrow.hidden = YES;
            break;
        }
    }
}

/**
 contentOffset 改变调用
 */
- (void)refreshHeaderContentOffsetDidChange:(CGPoint)newContentOffset {
    [super refreshHeaderContentOffsetDidChange:newContentOffset];
    
    if (EnumRefreshStateRefreshing != self.state) {
        if (-newContentOffset.y  > self.superScrollViewOriginInsets.top) {
            CGFloat visibleHeaderHeight = -newContentOffset.y - self.superScrollViewOriginInsets.top;
            CGFloat visibleRate = visibleHeaderHeight / self.six_height;
            visibleRate = visibleRate > 1 ? 1 : visibleRate;
            
//            NSLog(@"%lf", visibleRate);
            double angle = -M_PI * visibleRate;
            
//            self.imgViewArrow.transform = CGAffineTransformRotate(self.imgViewArrow.transform, angle);
            self.imgViewArrow.transform = CGAffineTransformMakeRotation(angle);
        }
    }
    
//    CGFloat normal2RefreshContentOffsetY = -self.superScrollViewOriginInsets.top - self.six_height;
    
}

#pragma -mark 
#pragma -mark getters
- (UIActivityIndicatorView *)activityIndicatorView { // 20 * 20
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityIndicatorView.hidesWhenStopped = YES;
    }
    return _activityIndicatorView;
}


- (UILabel *)lblTitle {
    if (!_lblTitle) {
        _lblTitle = [[UILabel alloc] init];
        _lblTitle.font = [UIFont systemFontOfSize:13];
        double rate = 102/255.0f;
        _lblTitle.textColor = [UIColor colorWithRed:rate green:rate blue:rate alpha:1.];
        _lblTitle.textAlignment = NSTextAlignmentLeft;
        _lblTitle.text = TipTextNormal;
    }
    return _lblTitle;
}

- (UIImageView *)imgViewArrow {
    if (!_imgViewArrow) {
        UIImage *image = [UIImage imageNamed:@"six_refresh_arrow_down@2x"];
        _imgViewArrow = [[UIImageView alloc] initWithImage:image];
        _imgViewArrow.contentMode = UIViewContentModeCenter;
        _imgViewArrow.frame = CGRectMake(0, 0, 26, 33);
    }
    return _imgViewArrow;
}

@end




