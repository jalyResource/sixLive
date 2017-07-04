//
//  SIXRefreshHeader.h
//  sixLive
//
//  Created by li’Pro on 2017/7/4.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXRefreshComponent.h"


/** 刷新时调用的方法 */
typedef void(^SIXRefreshBlock)();

@interface SIXRefreshHeader : SIXRefreshComponent

+ (instancetype)refreshHeaderWithBlock:(SIXRefreshBlock)refreshBlock ;

@property (copy, nonatomic) SIXRefreshBlock refreshBlock ;

/**
 处理刷新事件
 */
- (void)handleRefreshEvent NS_REQUIRES_SUPER ;

@end
