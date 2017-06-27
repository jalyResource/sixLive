//
//  SIXNavigationBar.h
//  sixLive
//
//  Created by li’Pro on 2017/6/27.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SIXNavigationBar;

@protocol SIXNavigationBarDelegate <NSObject>

@optional
- (void)headerLeftButtonClicked ;
- (void)headerRightButtonClicked ;

@end


@interface SIXNavigationBar : UIView

@property (weak, nonatomic) id<SIXNavigationBarDelegate> delegate;

@property (strong, nonatomic) UIButton *btnLeft;

@property (strong, nonatomic) UIButton *btnRight;

@property (strong, nonatomic) UILabel *lblLine;

+ (CGFloat)navigatonBarHeight ;

@end
