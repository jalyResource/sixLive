//
//  SIXSelectTypeCollectionViewCell.m
//  sixLive
//
//  Created by li’Pro on 2017/6/30.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXSelectTypeCollectionViewCell.h"


@interface SIXSelectTypeCollectionViewCell ()

@property (strong, nonatomic) UIButton *btnContent;

@property (strong, nonatomic) UIImageView *imgViewIcon;

@property (strong, nonatomic) UILabel *lblTitle;

@end


@implementation SIXSelectTypeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor randomColor];
        // content 68 * 69
        [self setUp];
    }
    return self;
}

- (void)setUp {
    [self addSubview:self.btnContent];
    [self.btnContent addSubview:self.imgViewIcon];
    [self.btnContent addSubview:self.lblTitle];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
//    68 * 69
    CGFloat x = 0, y = 0, w = 68, h = 69;
    x = (self.width - w) / 2.0;
    y = (self.height - h) / 2.0;
    self.btnContent.frame = CGRectMake(x, y, w, h);
    
    // lbl
    y = h - 20;
    h = 20;
    x = 0;
    self.lblTitle.frame = CGRectMake(x, y, w, h);
    
    // imgView
    w = h = 44;
    x = (self.btnContent.width - w) / 2.0;
    y = 0;
    self.imgViewIcon.frame = CGRectMake(x, y, w, h);
}

- (void)setModel:(SIXSelectTypeBtnModel *)model {
    _model = model;
    
    self.lblTitle.text = model.title;
    self.imgViewIcon.image = [UIImage imageNamed:model.imageName];
    self.btnContent.backgroundColor = [UIColor clearColor];
    
    if (model.isSelected) {
        self.btnContent.backgroundColor = [UIColor colorWithRed:252/255.f green:13/255.f blue:27/255.f alpha:1.];
    }
}

#pragma -mark 
#pragma -mark getters
- (UIButton *)btnContent {
    if (!_btnContent) {
        _btnContent = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnContent.layer.cornerRadius = 5;
        _btnContent.layer.masksToBounds = YES;
    }
    return _btnContent;
}

- (UIImageView *)imgViewIcon {
    if (!_imgViewIcon) {
        _imgViewIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        _imgViewIcon.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgViewIcon;
}

- (UILabel *)lblTitle {
    if (!_lblTitle) {
        _lblTitle = [[UILabel alloc] init];
        _lblTitle.textColor = [UIColor colorWithHex:0x666666]; // 929292
        _lblTitle.textAlignment = NSTextAlignmentCenter;
        _lblTitle.font = [UIFont systemFontOfSize:13];
    }
    return _lblTitle;
}

@end






















