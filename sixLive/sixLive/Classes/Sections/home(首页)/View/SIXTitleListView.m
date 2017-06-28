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

@property (assign, nonatomic) NSUInteger currentIndex;

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
    
    [self addSubview:self.viewIndicator];
    
    self.backgroundColor = [UIColor clearColor];
}


- (CGFloat)viewIndicatorHeight {
    return 3.;
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
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.scrollView.frame = CGRectMake(0, 0, self.width, self.height - self.viewIndicatorHeight);
    
    CGFloat x = 0, btnHeight = self.height - self.viewIndicatorHeight;
    for (NSUInteger i = 0; i<self.arrBtnTitle.count; i++) {
        UIButton *btn = self.arrBtnTitle[i];
        
        CGFloat textWidth = [btn.currentTitle textWidthWithFont:btn.titleLabel.font height:btnHeight];
        btn.frame = CGRectMake(x, 0, textWidth, btnHeight);
        
        if (i == self.currentIndex) {
            self.viewIndicator.frame = CGRectMake(x, btnHeight, textWidth, self.viewIndicatorHeight);
        }
        
        x += textWidth  + 28;
    }
    
    self.scrollView.contentSize = CGSizeMake(x, btnHeight);
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





