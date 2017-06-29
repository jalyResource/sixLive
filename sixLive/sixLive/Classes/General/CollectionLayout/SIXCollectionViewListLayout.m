//
//  SIXCollectionViewListLayout.m
//  sixLive
//
//  Created by li’Pro on 2017/6/27.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXCollectionViewListLayout.h"

@implementation SIXCollectionViewListLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        CGFloat margin = 3;
        self.minimumLineSpacing = margin;
        self.minimumInteritemSpacing = margin;
        
        
        self.headerReferenceSize = CGSizeMake(100, 100);
        CGFloat itemWidth = (SIX_SCREEN_WIDTH - margin) / 2.0 ;
        self.itemSize = CGSizeMake(itemWidth, itemWidth);
    }
    return self;
}



@end
