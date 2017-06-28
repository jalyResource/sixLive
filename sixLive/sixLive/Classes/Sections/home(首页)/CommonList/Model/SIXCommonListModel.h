//
//  SIXCommonListModel.h
//  sixLive
//
//  Created by li’Pro on 2017/6/28.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, EnumTttpCode) {
    EnumTttpCodeSuccess = 200,
    EnumTttpCodeFaile = 404
};

typedef void(^RequestCallBackBlock)(EnumTttpCode code, NSString *infoString);

@interface SIXCommonListModel : NSObject


- (void)fetchUserListWithParam:(NSDictionary *)dicParams completedCallBack:(RequestCallBackBlock)callBack ;


/**
 
 */
- (SIXUser *)userForItemAtIndexPath:(NSIndexPath *)indexPath ;

- (NSUInteger)numberOfItemsInSection:(NSInteger)section ;

- (NSUInteger)numberOfSections ;

@end


