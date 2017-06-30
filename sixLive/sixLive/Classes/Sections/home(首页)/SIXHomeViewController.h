//
//  SIXLiveViewController.h
//  sixLive
//
//  Created by li’Pro on 2017/6/27.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXViewController.h"
#import "SIXHotListModel.h"

typedef NS_ENUM(NSUInteger, EnumLiveListType) {
    EnumLiveListTypeHot   = 0, // 热门
    EnumLiveListTypeRed   = 1, // 手机红人
    EnumLiveListTypeLocal = 2, // 附近
    EnumLiveListTypeSound = 3, // 好声音
    EnumLiveListTypeDance = 4, // 舞蹈
    EnumLiveListTypeFunny = 5, // 搞笑
    EnumLiveListTypeChat  = 6, // 唠嗑
    EnumLiveListTypeMale  = 7  // 男神
};


@interface SIXHomeViewController : SIXViewController

@property (strong, nonatomic) SIXHotListModel *listModel;

@end
