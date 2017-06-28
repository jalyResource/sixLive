//
//  SIXCommonListModel.m
//  sixLive
//
//  Created by li’Pro on 2017/6/28.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXCommonListModel.h"


@interface SIXCommonListModel ()



@end

@implementation SIXCommonListModel




- (void)fetchUserListWithParam:(NSDictionary *)dicParams completedCallBack:(RequestCallBackBlock)callBack {
    [[SIXHttpRequest shareHttpRequest] POST:@"/coop/mobile/index.php" paramaters:dicParams success:^(NSDictionary *responseObject) {
        // 手机红人  content.mlive
        NSDictionary *dicContent = responseObject[@"content"];
        
        NSString *keyOfDicArray = dicParams[@"type"];
        if (keyOfDicArray.length == 0) { // 热门
            keyOfDicArray = @"roomList";
        }
        //roomList
        NSArray<NSDictionary *> *array = [dicContent objectForKey:keyOfDicArray];
        self.arrOfUser = [SIXUser userArrayWithJSONArray:array];
        
        callBack(EnumTttpCodeSuccess, nil);
        
    } failure:^(NSError *error) {
        callBack(EnumTttpCodeFaile, error.localizedDescription);
    }];
}



#pragma -mark 
#pragma -mark public ，为 collectionView dataSource 提供数据
- (SIXUser *)userForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.arrOfUser.count > indexPath.item) {
        return self.arrOfUser[indexPath.item];
    }
    return nil;
}

- (NSUInteger)numberOfItemsInSection:(NSInteger)section {
    return self.arrOfUser.count;
}

- (NSUInteger)numberOfSections {
    return self.arrOfUser.count ? 1 : 0;
}

@end












