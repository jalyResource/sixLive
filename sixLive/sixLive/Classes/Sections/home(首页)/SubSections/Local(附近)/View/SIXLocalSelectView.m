//
//  SIXLocalSelectView.m
//  sixLive
//
//  Created by li’Pro on 2017/6/29.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXLocalSelectView.h"

@interface SIXLocalSelectView ()

@property (strong, nonatomic) UIImageView *imgViewLeftIcon;

@property (strong, nonatomic) UILabel *lblPlace;

@property (strong, nonatomic) UIImageView *imgViewArrow;

@end

@implementation SIXLocalSelectView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.imgViewLeftIcon];
    
    [self addSubview:self.lblPlace];
    
    [self addSubview:self.imgViewArrow];
    
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickedAction)];
    [self addGestureRecognizer:ges];
}

- (void)clickedAction {
    [UIView animateWithDuration:0.2 animations:^{
        self.imgViewArrow.transform = CGAffineTransformRotate(self.imgViewArrow.transform, M_PI);
    }];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(localSelectViewDidClicked)]) {
        [self.delegate localSelectViewDidClicked];
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    self.imgViewLeftIcon.frame = CGRectMake(10, 19, 13, 17);
    self.lblPlace.frame = CGRectMake(33, 19, SIX_SCREEN_WIDTH - 33 * 2, 17);
    self.imgViewArrow.frame = CGRectMake(SIX_SCREEN_WIDTH - 30, 20, 20, 11);
    
    [CATransaction commit];
}

- (void)setPlaceName:(NSString *)placeName {
    self.lblPlace.text = placeName;
}


#pragma -mark 
#pragma -mark getters
- (UIImageView *)imgViewLeftIcon {
    if (!_imgViewLeftIcon) { //  26 * 34
        _imgViewLeftIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"live_list_icon_local"]];
    }
    return _imgViewLeftIcon;
}

- (UILabel *)lblPlace {
    if (!_lblPlace) {
        _lblPlace = [[UILabel alloc] init];
        _lblPlace.textColor = [UIColor colorWithHex:0xdd0000];
        _lblPlace.font = [UIFont systemFontOfSize:16];
        _lblPlace.textAlignment = NSTextAlignmentLeft;
        _lblPlace.text = @"正在定位...";
    }
    return _lblPlace;
}

- (UIImageView *)imgViewArrow {
    if (!_imgViewArrow) {
        _imgViewArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"live_list_icon_local_menu_arrow"]];
        _imgViewArrow.transform = CGAffineTransformMakeRotation(M_PI);
    }
    return _imgViewArrow;
}


@end


















