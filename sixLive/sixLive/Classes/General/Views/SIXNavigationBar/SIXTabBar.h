//
//  SIXTabBar.h
//  sixLive
//
//  Created by li’Pro on 2017/7/3.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SIXTabBarModel;


@interface SIXTabBar : UIView

@property (copy, nonatomic) NSArray<SIXTabBarModel *> *arrTabBarModel;

+ (instancetype)homeTabBar ;

@end




@interface SIXTabBarModel : NSObject

@property (copy, nonatomic) NSString *image;

@property (copy, nonatomic) NSString *imageSelected;


/**
 获取主页 tabBar 的模型数组
 */
+ (NSArray<SIXTabBarModel *> *)defaultTabBarModelArray ;

@end
