//
//  SIXLocalSelectView.h
//  sixLive
//
//  Created by li’Pro on 2017/6/29.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SIXLocalSelectView;

@protocol SIXLocalSelectViewDelegate <NSObject>

@optional
- (void)localSelectViewDidClicked ;

@end

@interface SIXLocalSelectView : UIView

@property (weak, nonatomic) id<SIXLocalSelectViewDelegate> delegate;

- (void)setPlaceName:(NSString *)placeName ;


/**
 view 的点击事件处理方法
 */
- (void)clickedAction ;

@end
