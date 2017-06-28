//
//  SIXHotListModel.m
//  sixLive
//
//  Created by li’Pro on 2017/6/28.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXHotListModel.h"

@interface SIXHotListModel ()

@property (strong, nonatomic) NSArray<SIXEvent *> *arrOfEvent;
@property (strong, nonatomic) NSMutableArray<SIXEvent *> *arrOfEventType_1;
@property (strong, nonatomic) NSMutableArray<SIXEvent *> *arrOfEventType_2; // 2,轮播图

@end

@implementation SIXHotListModel


//   请求参数写死 logiuid	1899999999
- (void)fetchEventListWithParam:(NSDictionary *)dicParams completedCallBack:(RequestCallBackBlock)callBack {
    NSDictionary *dic = @{
                          @"logiuid" : @"1899999999",
                          @"av"      : @2.1,
                          @"encpass" : [NSNull null],
                          @"padapi"  : @"coop-mobile-getEventList.php"
                          };
    
    [[SIXHttpRequest shareHttpRequest] POST:@"/coop/mobile/index.php" paramaters:dic success:^(NSDictionary *responseObject) {
        //   arr :  content : []
        NSArray<NSDictionary *> *array = responseObject[@"content"];
        self.arrOfEvent = [SIXEvent eventArrayWithJSONArray:array];
        
        self.arrOfEventType_1 = @[].mutableCopy;
        self.arrOfEventType_2 = @[].mutableCopy;
        for (SIXEvent *event in self.arrOfEvent) {
            if (event.type == 1) {
                [self.arrOfEventType_1 addObject:event];
            } else if (event.type == 2) {
                [self.arrOfEventType_2 addObject:event];
            }
        }
        
        callBack(EnumTttpCodeSuccess, nil);
        
    } failure:^(NSError *error) {
        callBack(EnumTttpCodeFaile, error.localizedDescription);
    }];
}

#pragma -mark 
#pragma -mark private

/**
 计算 banner 的数量
 */
- (NSUInteger)bannerNumber {
    __block int hasType1 = 0, hasType2 = 0;
    
    if (self.arrOfEventType_1.count) {
        hasType1 = 1;
    }
    if (self.arrOfEventType_2.count) {
        hasType2 = 1;
    }
    
    return hasType1 + hasType2;
}

#pragma -mark 
#pragma -mark public ，为 collectionView dataSource 提供数据
- (EnumListCellType)cellTypeAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger bannerNum = [self bannerNumber];
    if (indexPath.item < bannerNum) {
        if (indexPath.item == 0) {
            return EnumListCellTypeBanner;
        } else {
            return EnumListCellTypeRecomand;
        }
    }
    
    return EnumListCellTypeNormal;
}

- (NSArray<SIXEvent *> *)eventArrayForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == 0) {
        return self.arrOfEventType_2;
    } else if (indexPath.item == 0) {
        return self.arrOfEventType_1;
    } 
    return nil;
}

- (SIXUser *)userForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.arrOfUser.count > indexPath.item) {
        return self.arrOfUser[indexPath.item];
    }
    return nil;
}

- (NSUInteger)numberOfItemsInSection:(NSInteger)section {
    NSUInteger count = self.arrOfUser.count + [self bannerNumber];
    return count;
}


@end











