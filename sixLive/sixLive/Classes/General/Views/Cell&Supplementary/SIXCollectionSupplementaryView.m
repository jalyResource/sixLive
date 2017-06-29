//
//  SIXCollectionSupplementaryView.m
//  sixLive
//
//  Created by li’Pro on 2017/6/29.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXCollectionSupplementaryView.h"

@implementation SIXCollectionSupplementaryView

/** 注册 view 的 id  */
+ (NSString *)viewReuseIdentifier {
    return NSStringFromClass([self class]);
}



+ (CGSize)viewSize {
    return CGSizeZero;
}

@end
