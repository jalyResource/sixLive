//
//  SIXLocalListModel.h
//  sixLive
//
//  Created by li’Pro on 2017/6/29.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXCommonListModel.h"
#import "SIXLocalContent.h"

@interface SIXLocalListModel : SIXCommonListModel



/**
 * public ，为 collectionView dataSource 提供数据
 */
- (NSString *)currentProvinceName ;
- (NSString *)currentProvinceId ;
- (NSArray<SIXProvince *> *)provinceArray ;


@end
