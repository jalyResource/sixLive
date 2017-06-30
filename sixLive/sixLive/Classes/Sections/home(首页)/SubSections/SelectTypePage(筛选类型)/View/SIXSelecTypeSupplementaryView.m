//
//  SIXSelecTypeSupplementaryView.m
//  sixLive
//
//  Created by li’Pro on 2017/6/30.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXSelecTypeSupplementaryView.h"

@interface SIXSelecTypeSupplementaryView ()

@property (strong, nonatomic) UIView *viewLine;

@end

@implementation SIXSelecTypeSupplementaryView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    [self addSubview:self.lblTitle];
    [self addSubview:self.viewLine];
}

+ (CGSize)viewSize {
    return CGSizeMake(SIX_SCREEN_WIDTH, 45);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x = 10, y = 0, w = self.width, h = self.height;
    self.lblTitle.frame = CGRectMake(x, y, w, h);
    
    x = 0;
    h = 0.5;
    y = self.height - h;
    self.viewLine.frame = CGRectMake(x, y, w, h);
}

#pragma -mark 
#pragma -mark getters
- (UIView *)viewLine {
    if (!_viewLine) {
        _viewLine = [[UIView alloc] init];
        _viewLine.backgroundColor = [UIColor colorWithHex:0xcccccc];
    }
    return _viewLine;
}

- (UILabel *)lblTitle {
    if (!_lblTitle) {
        _lblTitle = [[UILabel alloc] init];
        _lblTitle.textColor = [UIColor colorWithHex:0x929292]; // 
        _lblTitle.textAlignment = NSTextAlignmentLeft;
        _lblTitle.font = [UIFont systemFontOfSize:13];
    }
    return _lblTitle;
}

@end


















