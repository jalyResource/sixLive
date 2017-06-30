//
//  SIXTitleListView.m
//  sixLive
//
//  Created by li’Pro on 2017/6/28.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXTitleListView.h"


@interface SIXTitleListView ()<UIScrollViewDelegate>
/**
 用于放 标题按钮
 */
@property (strong, nonatomic) NSMutableArray<UIButton *> *arrBtnTitle;

@property (strong, nonatomic) UIView *viewIndicator;

@property (strong, nonatomic) UIScrollView *scrollView;


@end

@implementation SIXTitleListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    [self addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.viewIndicator];
    
    self.backgroundColor = [UIColor clearColor];
}


- (CGFloat)viewIndicatorHeight {
    return 3.;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.scrollView.frame = self.bounds;
    
    CGFloat x = 0, btnHeight = self.height - self.viewIndicatorHeight;
    for (NSUInteger i = 0; i<self.arrBtnTitle.count; i++) {
        UIButton *btn = self.arrBtnTitle[i];
        
        CGFloat textWidth = [btn.currentTitle textWidthWithFont:btn.titleLabel.font height:btnHeight];
        btn.frame = CGRectMake(x, 0, textWidth, btnHeight);
        
//        if (i == self.currentIndex) {
//            self.viewIndicator.frame = CGRectMake(x, btnHeight, textWidth, self.viewIndicatorHeight);
//        }
        
        x += textWidth  + 28;
    }
    
    self.scrollView.contentSize = CGSizeMake(x, btnHeight);
}

#pragma -mark 
#pragma -mark setters
- (void)setContentOffset:(CGPoint)contentOffset {
    if (contentOffset.x < 0 || contentOffset.x > self.arrTitle.count * SIX_SCREEN_WIDTH) {
        return;
    }
    CGFloat currentPageX = SIX_SCREEN_WIDTH * self.currentIndex;
    // 界面滑动偏移 比率：[-1, 1],负数：左滑   整数：右滑
    CGFloat slideRate = (contentOffset.x - currentPageX) / SIX_SCREEN_WIDTH;
    
    // 找到当前 title 的宽度
    NSString *currentTitle = self.arrTitle[self.currentIndex];
    NSUInteger nextIndex = 0;
    if (slideRate > 0) {
        nextIndex = self.currentIndex + 1;
    } else if (slideRate == 0) {
        nextIndex = self.currentIndex;
    } else {
        nextIndex = self.currentIndex - 1;
        slideRate = -slideRate;
    }
    NSString *nextTitle = self.arrTitle[nextIndex];
    DLog(@"current:%@   next:%@", currentTitle, nextTitle);
    UIButton *btnCurrent = self.arrBtnTitle[self.currentIndex];
    UIButton *btnNext = self.arrBtnTitle[nextIndex];
    
    CGFloat viewXOffset = (btnNext.x - btnCurrent.x) * slideRate;
    CGFloat viewWOffset = (btnNext.width - btnCurrent.width) * slideRate;
    CGRect viewIndicatorFrame = self.viewIndicator.frame;
    viewIndicatorFrame.origin.x = btnCurrent.x + viewXOffset;
    viewIndicatorFrame.size.width = btnCurrent.width + viewWOffset;
    
    [UIView animateWithDuration:0.1 animations:^{
        self.viewIndicator.frame = viewIndicatorFrame;
    }];
    
    _contentOffset = contentOffset;
}

- (void)setCurrentIndex:(NSUInteger)currentIndex {
    _currentIndex = currentIndex;
    UIButton *btn = self.arrBtnTitle[currentIndex];
    self.viewIndicator.x = btn.x;
    self.viewIndicator.width = btn.width;
    // 将当前选中按钮滚动到中间
    CGFloat visibleX = self.viewIndicator.x - (self.width - self.viewIndicator.width) / 2.0;
    CGRect rectVisible = CGRectMake(visibleX, 0, self.width, self.height);
    [self.scrollView scrollRectToVisible:rectVisible animated:YES];
}

- (void)setArrTitle:(NSArray<NSString *> *)arrTitle {
    _arrTitle = arrTitle;
    [self.arrBtnTitle makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.arrBtnTitle = @[].mutableCopy;
    // 根据 arrTitle 创建按钮
    for (NSUInteger i = 0; i<arrTitle.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor clearColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle:arrTitle[i] forState:UIControlStateNormal];
        btn.tag = i + 100;
        
        [self.scrollView addSubview:btn];
        [self.arrBtnTitle addObject:btn];
    }
    
    UIButton *btnFirst = [self.arrBtnTitle firstObject];
    CGFloat textWidth = [btnFirst.currentTitle textWidthWithFont:btnFirst.titleLabel.font height:self.height - self.viewIndicatorHeight];
    self.viewIndicator.frame = CGRectMake(0, self.height - self.viewIndicatorHeight, textWidth, self.viewIndicatorHeight);
}


#pragma -mark 
#pragma -mark getters

- (UIView *)viewIndicator {
    if (!_viewIndicator) {
        _viewIndicator = [[UIView alloc] init];
        _viewIndicator.backgroundColor = [UIColor whiteColor];
    }
    return _viewIndicator;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}
@end



















