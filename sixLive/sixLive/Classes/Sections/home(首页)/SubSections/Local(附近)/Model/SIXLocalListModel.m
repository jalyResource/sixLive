//
//  SIXLocalListModel.m
//  sixLive
//
//  Created by li’Pro on 2017/6/29.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXLocalListModel.h"

@interface SIXLocalListModel ()

@property (strong, nonatomic) SIXLocalContent *localContent;

@end

@implementation SIXLocalListModel


// http://v.6.cn/coop/mobile/index.php?padapi=coop-mobile-getlivelistlocation.php
- (void)fetchUserListWithParam:(NSDictionary *)dicParams completedCallBack:(RequestCallBackBlock)callBack {
    [[SIXHttpRequest shareHttpRequest] POST:@"/coop/mobile/index.php" paramaters:dicParams success:^(NSDictionary *responseObject) {
        // 手机红人  content.mlive
        NSDictionary *dicContent = responseObject[@"content"];
        
        self.localContent = [SIXLocalContent instanceWithDictionary:dicContent];
        self.arrOfUser = self.localContent.arrRoomList;
        
        callBack(EnumHttpCodeSuccess, nil);
        
    } failure:^(NSError *error) {
        NSDictionary *errInfo = error.userInfo;
        NSString *errStr = @"";
        if ([[errInfo allKeys] containsObject:@"content"]) {
            errStr = errInfo[@"content"];
        }
        DLog(@"%@", errStr);
        callBack(EnumHttpCodeFaile, errStr);
    }];
}

#pragma -mark 
#pragma -mark public ，为 collectionView dataSource 提供数据
- (NSString *)currentProvinceName {
    return self.localContent.ptitle;
}
- (NSString *)currentProvinceId {
    return self.localContent.pid;
}
- (NSArray<SIXProvince *> *)provinceArray {
    return self.localContent.arrProvince;
}

@end






























