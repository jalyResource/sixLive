//
//  SIXRecomendSupplementaryView.m
//  sixLive
//
//  Created by li’Pro on 2017/6/29.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXRecomendSupplementaryView.h"

@interface SIXRecomendSupplementaryView ()



@end

@implementation SIXRecomendSupplementaryView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    self.backgroundColor = [UIColor yellowColor];
   
}

- (void)layoutSubviews {
    [super layoutSubviews];
   
}


+ (CGSize)viewSize {
    return CGSizeMake(SIX_SCREEN_WIDTH, 78);
}

@end

















