//
//  SIXTitleListView.h
//  sixLive
//
//  Created by li’Pro on 2017/6/28.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SIXTitleListView : UIView

@property (strong, nonatomic) NSArray<NSString *> *arrTitle;

@property (assign, nonatomic) CGPoint contentOffset;

@property (assign, nonatomic) NSUInteger currentIndex;

/**
 指示条的高度

 @return 指示条的高度
 */
- (CGFloat)viewIndicatorHeight ;

@end
