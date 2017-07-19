//
//  SIXTitleListView.m
//  sixLive
//
//  Created by li’Pro on 2017/6/28.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXTitleListView.h"

#define TitleFontMax [UIFont systemFontOfSize:18]

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
    return 2.;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.scrollView.frame = self.bounds;
    // 90 - >152
    CGFloat x = 30, btnHeight = self.height - self.viewIndicatorHeight;
    for (NSUInteger i = 0; i<self.arrBtnTitle.count; i++) {
        UIButton *btn = self.arrBtnTitle[i];
        
        CGFloat textWidth = [btn.currentTitle textWidthWithFont:TitleFontMax height:btnHeight];
        btn.frame = CGRectMake(x, 0, textWidth, btnHeight);
        
//        if (i == self.currentIndex) {
//            self.viewIndicator.frame = CGRectMake(x, btnHeight, textWidth, self.viewIndicatorHeight);
//        }
        // 55  -> 66
        x += textWidth  + 27;
    }
    
    self.scrollView.contentSize = CGSizeMake(x, btnHeight);
}


/**
 标题按钮点击事件

 @param sender  点击的按钮
 */
- (void)titleButtonClicked:(UIButton *)sender {
    NSUInteger index = sender.tag % 100;
    if (self.delegate && [self.delegate respondsToSelector:@selector(titleListView:didClickedAtIndex:)]) {
        [self.delegate titleListView:self didClickedAtIndex:index];
    }
}

#pragma -mark 
#pragma -mark setters
- (void)setContentOffset:(CGPoint)contentOffset {
    if (contentOffset.x < 0 || contentOffset.x > (self.arrTitle.count - 1) * LOBBY_SCROLLVIEW_WIDTH) {
        return;
    }
    // 白色指示条，在 indexLeft indexRight 之间 
    NSUInteger indexLeft = contentOffset.x / LOBBY_SCROLLVIEW_WIDTH;
    NSUInteger indexRight = MIN(indexLeft + 1, self.arrTitle.count - 1);
    // 界面滑动偏移 比率
    CGFloat slideRate = (contentOffset.x - (indexLeft * LOBBY_SCROLLVIEW_WIDTH)) / LOBBY_SCROLLVIEW_WIDTH;


    UIButton *btnCurrent = self.arrBtnTitle[indexLeft];
    UIButton *btnNext = self.arrBtnTitle[indexRight];
    
    CGFloat viewXOffset = (btnNext.x - btnCurrent.x) * slideRate;
    CGFloat viewWOffset = (btnNext.width - btnCurrent.width) * slideRate;
    CGRect viewIndicatorFrame = self.viewIndicator.frame;
    viewIndicatorFrame.origin.x = btnCurrent.x + viewXOffset;
    viewIndicatorFrame.size.width = btnCurrent.width + viewWOffset;
    
    [self.viewIndicator.layer removeAllAnimations];
    [UIView animateWithDuration:0.1 animations:^{
        self.viewIndicator.frame = viewIndicatorFrame;
    }];
    
    _contentOffset = contentOffset;
}

- (void)setCurrentIndex:(NSUInteger)currentIndex {
    UIButton *btn = self.arrBtnTitle[_currentIndex];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    btn.selected = NO;
    
    _currentIndex = currentIndex;
    btn = self.arrBtnTitle[currentIndex];
    btn.titleLabel.font = TitleFontMax;
    btn.selected = YES;
    
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
        [btn setTitleColor:[UIColor colorWithHex:0xefb2b2] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHex:0xffffff] forState:UIControlStateSelected];
        [btn setTitle:arrTitle[i] forState:UIControlStateNormal];
        btn.tag = i + 100;
        [btn addTarget:self action:@selector(titleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.scrollView addSubview:btn];
        [self.arrBtnTitle addObject:btn];
    }
    
    UIButton *btnFirst = [self.arrBtnTitle firstObject];
    btnFirst.titleLabel.font = TitleFontMax;
    btnFirst.selected = YES;
    CGFloat textWidth = [btnFirst.currentTitle textWidthWithFont:TitleFontMax height:self.height - self.viewIndicatorHeight];
    self.viewIndicator.frame = CGRectMake(30, self.height - self.viewIndicatorHeight, textWidth, self.viewIndicatorHeight);
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



















