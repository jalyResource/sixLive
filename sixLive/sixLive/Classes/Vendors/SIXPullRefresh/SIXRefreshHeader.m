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
    SIXRefreshHeader *header = [[self alloc] initWithFrame:CGRectMake(0, -64, REFRESH_SC_WIDTH, 64)];
    header.refreshBlock = refreshBlock;
    return header;
}


- (void)setState:(EnumRefreshState)state {
    if (_state == state) {
        return;
    }
    EnumRefreshState oldState = _state;
    [super setState:state];
    
    
}


/**
 处理刷新事件
 */
- (void)handleRefreshEvent {
    [super handleRefreshEvent];
    
    if (self.refreshBlock) {
        self.refreshBlock();
    }
}


@end









