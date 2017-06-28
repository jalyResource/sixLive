//
//  SIXRecCollectionViewCell.m
//  sixLive
//
//  Created by li’Pro on 2017/6/28.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXRecCollectionViewCell.h"

@implementation SIXRecCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor orangeColor];
    }
    return self;
}



/** 注册 cell 的 id  */
+ (NSString *)cellReuseIdentifier {
    return NSStringFromClass([self class]);
}

+ (CGSize)cellSize {
    //156
    return CGSizeMake(SIX_SCREEN_WIDTH, 78);
}

@end
