//
//  SixLive.h
//  sixLive
//
//  Created by li’Pro on 2017/6/27.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#ifndef SixLive_h
#define SixLive_h


/** 公共基类 */
#import "SIXBaseViewController.h"
#import "SIXNavigationController.h"











/** 自定义 log */
#ifdef DEBUG
    #define DLog(...) NSLog(__VA_ARGS__);
#else
    #define DLog(...);
#endif



#endif /* SixLive_h */
