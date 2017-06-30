//
//  SIXSelectTypeLayout.m
//  sixLive
//
//  Created by li’Pro on 2017/6/30.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXSelectTypeLayout.h"

@implementation SIXSelectTypeLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.minimumLineSpacing = 0;
        self.minimumInteritemSpacing = 0;
        
        CGFloat width = SIX_SCREEN_WIDTH / 3.0;
        self.itemSize = CGSizeMake(width, width);
        
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return self;
}

@end
