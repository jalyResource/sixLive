//
//  SIXRecomendView.m
//  sixLive
//
//  Created by li’Pro on 2017/6/29.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXRecomendView.h"
#import "SIXEvent.h"

@interface SIXRecomendView ()

@property (strong, nonatomic) UIImageView *imgViewIcon;

@property (strong, nonatomic) UILabel *lblName;

@property (strong, nonatomic) UILabel *lblCount;
/** 直播中   提示 lbl */
@property (strong, nonatomic) UILabel *lblTag;

@end

@implementation SIXRecomendView

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
    
    [self addSubview:self.imgViewIcon];
    
    [self addSubview:self.lblName];
    
    [self addSubview:self.lblCount];
    
    [self addSubview:self.lblTag];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imgViewIcon.frame = CGRectMake(8, 11, 74, 55);
    
    CGFloat x = 0, y = 0, w = 0, h = 0;
    x = CGRectGetMaxX(self.imgViewIcon.frame) + 11;
    y = 20;
    w = SIX_SCREEN_WIDTH - 69 - x;
    h = 16;
    self.lblName.frame = CGRectMake(x, y, w, h);
    
    
    y = CGRectGetMaxY(self.lblName.frame);
    h = 14;
    self.lblCount.frame = CGRectMake(x, y, w, h);
    
    
    x = SIX_SCREEN_WIDTH - 65;
    y = 28;
    w = 56;
    h = 24;
    self.lblTag.frame = CGRectMake(x, y, w, h);
}


#pragma -mark 
#pragma -mark getters
- (UIImageView *)imgViewIcon {
    if (!_imgViewIcon) {
        _imgViewIcon = [[UIImageView alloc] init];
        _imgViewIcon.backgroundColor = [UIColor clearColor];
        _imgViewIcon.contentMode = UIViewContentModeScaleAspectFill;
        _imgViewIcon.layer.cornerRadius = 5.;
        _imgViewIcon.layer.masksToBounds = YES;
    }
    return _imgViewIcon;;
}



- (UILabel *)lblName {
    if (!_lblName) {
        _lblName = [[UILabel alloc] init];
        _lblName.backgroundColor = [UIColor clearColor];
        _lblName.font = [UIFont systemFontOfSize:16];
        _lblName.textColor = [UIColor blackColor];
        _lblTag.textAlignment = NSTextAlignmentLeft;
    }
    return _lblName;
}


- (UILabel *)lblCount {
    if (!_lblCount) {
        _lblCount = [[UILabel alloc] init];
        _lblCount.backgroundColor = [UIColor clearColor];
        _lblCount.font = [UIFont systemFontOfSize:13];
        _lblCount.textColor = [UIColor colorWithHex:0xa5a5a5];
        _lblTag.textAlignment = NSTextAlignmentLeft;
    }
    return _lblCount;
}

- (UILabel *)lblTag {
    if (!_lblTag) {
        _lblTag = [[UILabel alloc] init];
        _lblTag.backgroundColor = [UIColor clearColor];
        _lblTag.font = [UIFont systemFontOfSize:13];
        _lblTag.textColor = [UIColor colorWithHex:0xdd0000];
        _lblTag.textAlignment = NSTextAlignmentCenter;
        
        _lblTag.layer.borderColor = [UIColor colorWithHex:0xdd0000].CGColor;
        _lblTag.layer.borderWidth = 1.;
        // height 24
        _lblTag.layer.cornerRadius = 12.;
        _lblTag.layer.masksToBounds = YES;
    }
    return _lblCount;
}
@end
