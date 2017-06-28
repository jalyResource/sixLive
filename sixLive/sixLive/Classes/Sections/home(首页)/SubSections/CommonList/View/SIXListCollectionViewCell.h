//
//  SIXListCollectionViewCell.h
//  sixLive
//
//  Created by li’Pro on 2017/6/28.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SIXListCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) SIXUser *user;

/** 注册 cell 的 id  */
+ (NSString *)cellReuseIdentifier ;
@end
