//
//  SIXSelectTypeModel.h
//  sixLive
//
//  Created by li’Pro on 2017/6/30.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SIXSelectTypeBtnModel.h"

@interface SIXSelectTypeModel : NSObject

+(instancetype)shareTypeModel ;

- (SIXSelectTypeBtnModel *)selectTypeBtnModelAtIndexPath:(NSIndexPath *)indexPath ;
- (SIXSelectLevelBtnModel *)selectLevelBtnModelAtIndexPath:(NSIndexPath *)indexPath ;

- (NSUInteger)numberOfItemsInSection:(NSInteger)section ;

- (NSUInteger)numberOfSections ;


@end
