//
//  SIXNavigationBar.m
//  sixLive
//
//  Created by li’Pro on 2017/6/27.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXNavigationBar.h"

@implementation SIXNavigationBar

#pragma mark - life cycle
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = NO;
        self.backgroundColor = [UIColor clearColor];
        [self setUp];
    }
    return self;
}

- (void)setUp {
    CGFloat barHeight = [[self class] navigatonBarHeight];
    
    [self addSubview:self.btnLeft];
    self.btnLeft.frame = CGRectMake(0, 0, barHeight, barHeight);
   
    
    [self addSubview:self.btnRight];
    self.btnRight.frame = CGRectMake(SIX_SCREEN_WIDTH - barHeight, 0, barHeight, barHeight);
    
    
    [self addSubview:self.lblLine];
    self.lblLine.frame = CGRectMake(0, barHeight-1, SIX_SCREEN_WIDTH, 1);
    
}

+ (CGFloat)navigatonBarHeight {
    return SIX_NAVIGATIONBAR_HEIGHT;
}

#pragma -mark 
#pragma -mark private method
- (void)btnLeftClicked:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(headerLeftButtonClicked)]) {
        [self.delegate headerLeftButtonClicked];
    }
}
- (void)btnRightClicked:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(headerRightButtonClicked)]) {
        [self.delegate headerRightButtonClicked];
    }
}


#pragma -mark 
#pragma -mark getters
- (UIButton *)btnLeft {
    if (!_btnLeft) {
        if (_btnLeft == nil) {
            _btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
            _btnLeft.adjustsImageWhenHighlighted = NO;
            _btnLeft.backgroundColor = [UIColor clearColor];
            [_btnLeft setImage:[UIImage imageNamed:@"live_song_class_all_normal"] forState:UIControlStateNormal];
            _btnLeft.exclusiveTouch = YES;
            [_btnLeft addTarget:self action:@selector(btnLeftClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return _btnLeft;
}

- (UIButton *)btnRight {
    if (!_btnRight) {
        if (_btnRight == nil) {
            _btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
            _btnRight.adjustsImageWhenHighlighted = NO;
            _btnRight.backgroundColor = [UIColor clearColor];
            [_btnRight setImage:[UIImage imageNamed:@"live_song_class_all_normal"] forState:UIControlStateNormal];
            _btnRight.exclusiveTouch = YES;
            [_btnRight addTarget:self action:@selector(btnRightClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return _btnRight;
}

- (UILabel *)lblLine {
    if (!_lblLine) {
        _lblLine = [[UILabel alloc] init];
        _lblLine.backgroundColor = [UIColor clearColor];
    }
    return _lblLine;
}



@end






























