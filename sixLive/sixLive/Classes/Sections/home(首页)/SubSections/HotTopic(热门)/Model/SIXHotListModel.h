//
//  SIXHotListModel.h
//  sixLive
//
//  Created by li’Pro on 2017/6/28.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXCommonListModel.h"

@interface SIXHotListModel : SIXCommonListModel

/**
 获取 “热门” 顶部轮播图信息
 
 @param dicParams 参数
 @param callBack 请求回调
 */
- (void)fetchEventListWithParam:(NSDictionary *)dicParams completedCallBack:(RequestCallBackBlock)callBack ;



- (EnumListCellType)cellTypeAtIndexPath:(NSIndexPath *)indexPath ;

- (NSArray<SIXEvent *> *)eventArrayForItemAtIndexPath:(NSIndexPath *)indexPath ;

@end
