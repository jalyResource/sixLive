//
//  SIXProvinceListViewController.h
//  sixLive
//
//  Created by li’Pro on 2017/6/29.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXViewController.h"
@class SIXProvince;

typedef void(^ProvinceListClickedBlock)(SIXProvince *province);

@interface SIXProvinceListViewController : SIXViewController

/** 选中的省份 id */
@property (copy, nonatomic) NSString *currentPId;
/** 点击 cell 的回调 block */
@property (copy, nonatomic) ProvinceListClickedBlock blockRowClicked;

- (instancetype)initWithProvinceArray:(NSArray<SIXProvince *> *)arrProvince ;

@property (copy, nonatomic) NSArray<SIXProvince *> *arrProvince;

@end
