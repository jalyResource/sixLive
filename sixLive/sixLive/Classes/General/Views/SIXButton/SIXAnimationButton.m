//
//  SIXAnimationButton.m
//  test
//
//  Created by li’Pro on 2017/7/16.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXAnimationButton.h"

// height 1.5 width 20    vMargin 5
static CGFloat const kVerticalMargin = 7.;

@interface SIXAnimationButton ()

@property (strong, nonatomic) UIView *viewTop;
@property (strong, nonatomic) UIView *viewCenter;
@property (strong, nonatomic) UIView *viewBottom;

@property (assign, nonatomic) CGRect frameOriginTop;
@property (assign, nonatomic) CGRect frameOriginBottom;

@end


@implementation SIXAnimationButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    self.backgroundColor = [UIColor clearColor];
    self.exclusiveTouch = YES; 
    
    [self addSubview:self.viewBottom];
    [self addSubview:self.viewCenter];
    [self addSubview:self.viewTop];
    
    
    CGFloat verticalMargin = kVerticalMargin;
    CGSize selfSize = self.bounds.size;
    CGFloat h = 1.5;
    CGFloat w = 22;
    CGFloat x = (selfSize.width - w) / 2.0 - 3;
    CGFloat y = (selfSize.height - h * 3 - verticalMargin * 2) / 2.0 + 2;
    
    CGRect frame = CGRectMake(x, y, w, h);
    self.frameOriginTop = self.viewTop.frame = frame;
    
    frame.origin.y += verticalMargin;
    self.viewCenter.frame = frame;
    
    frame.origin.y += verticalMargin;
    self.frameOriginBottom = self.viewBottom.frame = frame;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
}

#pragma -mark 
#pragma -mark public
- (void)startAnimation {
    self.tag = (self.tag + 1) % 2;

    NSTimeInterval interval = 0.1;
    
    self.userInteractionEnabled = NO;
//    NSLog(@"tag: %ld", self.tag);
    if (self.tag) {  // 三 -->  一
        CGRect frameTop = self.frameOriginTop;
        frameTop.origin.y += kVerticalMargin;
        CGRect frameBottom = self.frameOriginBottom;
        frameBottom.origin.y -= kVerticalMargin;
        
        
        [UIView animateWithDuration:interval delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.viewTop.frame = frameTop;
            self.viewBottom.frame = frameBottom;
            self.viewCenter.alpha = 0;
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:interval delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                 self.viewTop.transform = CGAffineTransformMakeRotation(M_PI_4);
                 self.viewBottom.transform = CGAffineTransformMakeRotation(-M_PI_4);
            } completion:^(BOOL finished) {
                self.userInteractionEnabled = YES;
            }];
            
        }];
        
    } else {         // 一 -->  三
        CGRect frameTop = self.frameOriginTop;
        frameTop.origin.y += kVerticalMargin;
        
        [UIView animateWithDuration:interval delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.viewTop.transform = CGAffineTransformIdentity;
            self.viewBottom.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:interval delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                self.viewTop.frame = self.frameOriginTop;
                self.viewBottom.frame = self.frameOriginBottom;
                self.viewCenter.alpha = 1;
            } completion:^(BOOL finished) {
                self.userInteractionEnabled = YES;
            }];
            
        }];
    }
}


#pragma -mark 
#pragma -mark private method
- (UIView *)getViewLine {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 1.5)];
    view.backgroundColor = [UIColor whiteColor];
    
    view.userInteractionEnabled = NO;
    return view;
}

#pragma -mark 
#pragma -mark getter
- (UIView *)viewTop {
    if (!_viewTop) {
        _viewTop = [self getViewLine];
    }
    return _viewTop;
}

- (UIView *)viewCenter {
    if (!_viewCenter) {
        _viewCenter = [self getViewLine];
    }
    return _viewCenter;
}

- (UIView *)viewBottom {
    if (!_viewBottom) {
        _viewBottom = [self getViewLine];
    }
    return _viewBottom;
}

@end


























