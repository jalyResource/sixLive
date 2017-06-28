//
//  SIXBannerCollectionViewCell.h
//  sixLive
//
//  Created by li’Pro on 2017/6/28.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIXEvent.h"

// banner cell
@interface SIXBannerCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) NSArray<SIXEvent *> *arrEvent;

/** 注册 cell 的 id  */
+ (NSString *)cellReuseIdentifier ;

+ (CGSize)cellSize ;

@end
