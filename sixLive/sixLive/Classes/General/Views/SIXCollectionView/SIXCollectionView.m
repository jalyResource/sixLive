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

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

/**
 显示 : 请下拉刷新试试
 */
- (void)showRefreshTip {
    [self showTipText:@"请下拉刷新试试"];
}

- (void)showTipText:(NSString *)text {
    if (self.lblTip.superview) {
        [self.lblTip removeFromSuperview];
        self.lblTip = nil;
    }
    
    self.lblTip = [[UILabel alloc] init];
    self.lblTip.textColor = [UIColor colorWithHex:0x666666];
    self.lblTip.font = [UIFont systemFontOfSize:18];
    self.lblTip.textAlignment = NSTextAlignmentCenter;
    self.lblTip.text = text;
//    self.lblTip.userInteractionEnabled = NO;

    [self insertSubview:self.lblTip atIndex:0];

    CGRect frame = self.bounds;
    
    self.lblTip.frame = frame;
}


- (void)removeTipText {
    if (self.lblTip.superview) {
        [self.lblTip removeFromSuperview];
        self.lblTip = nil;
    }
}

@end






















