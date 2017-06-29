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
                          @"av"      : @"2.1",
                          @"encpass" : @""
//                          @"padapi"  : @"coop-mobile-getEventList.php"
                          };
    [[SIXHttpRequest shareHttpRequest] POST:@"/coop/mobile/index.php?padapi=coop-mobile-getEventList.php" paramaters:dic success:^(NSDictionary *responseObject) {
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
    // 接口只返回 type=1 的数据，返回值写死
    return 1;
//    __block int hasType1 = 0, hasType2 = 0;
//    
//    if (self.arrOfEventType_1.count) {
//        hasType1 = 1;
//    }
//    if (self.arrOfEventType_2.count) {
//        hasType2 = 1;
//    }
//    
//    return hasType1 + hasType2;
}

#pragma -mark 
#pragma -mark public ，为 collectionView dataSource 提供数据

- (NSArray<SIXEvent *> *)eventArrayForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == 0) {
        return self.arrOfEventType_2;
    } else if (indexPath.item == 0) {
        return self.arrOfEventType_1;
    } 
    return nil;
}



@end











