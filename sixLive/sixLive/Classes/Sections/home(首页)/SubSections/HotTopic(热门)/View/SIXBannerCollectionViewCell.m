//
//  SIXBannerCollectionViewCell.m
//  sixLive
//
//  Created by li’Pro on 2017/6/28.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXBannerCollectionViewCell.h"

@interface SIXBannerCollectionViewCell ()



@end

// 750 * 372
@implementation SIXBannerCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor redColor];
    }
    return self;
}

/** 注册 cell 的 id  */
+ (NSString *)cellReuseIdentifier {
    return NSStringFromClass([self class]);
}

+ (CGSize)cellSize {
//    750 / 372 = SC_Width / height
    return CGSizeMake(SIX_SCREEN_WIDTH, 372 * SIX_SCREEN_WIDTH / 750.0);
}


@end
