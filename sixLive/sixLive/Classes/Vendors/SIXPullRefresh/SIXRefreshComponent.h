//
//  SIXRefreshComponent.h
//  sixLive
//
//  Created by li’Pro on 2017/7/3.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, EnumRefreshState) {
    EnumRefreshStateNormal         = 0, // 正常
    EnumRefreshStateRefreshPulling = 1, // 放手即可刷新
    EnumRefreshStateRefreshing     = 2, // 刷新中。。。
    EnumRefreshStateRefreshEnd     = 3  // 刷新结束
};

@interface SIXRefreshComponent : UIView {
    /** 父控件， ScrollView*/
    __weak UIScrollView *_superScrollView;
    @protected
    EnumRefreshState _state;
}
/** 父控件， ScrollView*/
@property (weak, nonatomic) UIScrollView *superScrollView;

/**
 父控件 原始 contentInset
 */
@property (assign, nonatomic) UIEdgeInsets superScrollViewOriginInsets;

@property (assign, nonatomic) EnumRefreshState state;

/**
 contentOffset 改变调用
 */
- (void)refreshHeaderContentOffsetDidChange:(CGPoint)newContentOffset NS_REQUIRES_SUPER;

/**
 处理刷新事件
 */
- (void)handleRefreshEvent NS_REQUIRES_SUPER;

/**
 刷新结束调用
 */
- (void)endRefresh ;

@end
































