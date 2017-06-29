//
//  SIXProvinceCell.h
//  sixLive
//
//  Created by li’Pro on 2017/6/29.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SIXProvince;

@interface SIXProvinceCell : UITableViewCell

@property (strong, nonatomic) SIXProvince *province;

@property (assign, nonatomic, getter=isCurrent) BOOL current;

@end
