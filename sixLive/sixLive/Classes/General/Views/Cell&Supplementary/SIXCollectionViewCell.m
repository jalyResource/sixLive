//
//  SIXCollectionViewCell.m
//  sixLive
//
//  Created by li’Pro on 2017/6/29.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXCollectionViewCell.h"

@implementation SIXCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = SIX_BACKGROUND_COLOR;
    }
    return self;
}

/** 注册 cell 的 id  */
+ (NSString *)cellReuseIdentifier {
    return NSStringFromClass([self class]);
}

@end
