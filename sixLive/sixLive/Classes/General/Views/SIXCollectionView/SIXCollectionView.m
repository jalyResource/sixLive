//
//  SIXCollectionView.m
//  sixLive
//
//  Created by li’Pro on 2017/6/28.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXCollectionView.h"

@interface SIXCollectionView ()


/**
 提示 label
 */
@property (strong, nonatomic) UILabel *lblTip;

@end

@implementation SIXCollectionView

- (void)showTipText:(NSString *)text {
    if (self.lblTip.superview) {
        [self.lblTip removeFromSuperview];
        self.lblTip = nil;
    }
    
    self.lblTip = [[UILabel alloc] init];
    self.lblTip.textColor = [UIColor colorWithHex:0x333333];
    self.lblTip.font = [UIFont systemFontOfSize:14];
    self.lblTip.textAlignment = NSTextAlignmentCenter;
    self.lblTip.text = text;
    
    [self addSubview:self.lblTip];

    self.lblTip.frame = self.bounds;
    
}


- (void)removeTipText {
    if (self.lblTip.superview) {
        [self.lblTip removeFromSuperview];
        self.lblTip = nil;
    }
}

@end






















