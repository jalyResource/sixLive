//
//  SIXCommonListModel.h
//  sixLive
//
//  Created by li’Pro on 2017/6/28.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SIXHttpRequest.h"
#import "SIXEvent.h"




/**
 列表中 cell 的类型
 */
typedef NS_ENUM(NSUInteger, EnumListCellType) {
    EnumListCellTypeNormal = 0,    // 普通用户
    EnumListCellTypeBanner = 1,    // 热门顶部轮播
    EnumListCellTypeRecomand = 2,  // 热门顶部推荐用户
};


typedef void(^RequestCallBackBlock)(EnumHttpCode code, NSString *infoString);



@interface SIXCommonListModel : NSObject

@property (strong, nonatomic) NSArray<SIXUser *> *arrOfUser;

/**
 获取 主播列表

 @param dicParams 参数
 @param callBack 请求回调
 */
- (void)fetchUserListWithParam:(NSDictionary *)dicParams completedCallBack:(RequestCallBackBlock)callBack ;


/**
 public ，为 collectionView dataSource 提供数据
 */
- (SIXUser *)userForItemAtIndexPath:(NSIndexPath *)indexPath ;

- (NSUInteger)numberOfItemsInSection:(NSInteger)section ;

- (NSUInteger)numberOfSections ;

@end


















