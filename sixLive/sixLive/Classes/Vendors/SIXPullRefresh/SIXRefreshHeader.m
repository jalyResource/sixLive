//
//  SIXRefreshHeader.m
//  sixLive
//
//  Created by li’Pro on 2017/7/4.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXRefreshHeader.h"
#import "SIXPullRefreshMacro.h"

@implementation SIXRefreshHeader


+ (instancetype)refreshHeaderWithBlock:(SIXRefreshBlock)refreshBlock {
    SIXRefreshHeader *header = [[self alloc] initWithFrame:CGRectMake(0, -55, REFRESH_SC_WIDTH, 55)];
    header.refreshBlock = refreshBlock;
    return header;
}


- (void)setState:(EnumRefreshState)state {
    [super setState:state];
    
    if (EnumRefreshStateRefreshing == state) {
        [self handleRefreshEvent];
    }
}


/**
 处理刷新事件
 */
- (void)handleRefreshEvent {
    if (self.refreshBlock) {
        self.refreshBlock();
    }
}


@end









