//
//  SIXSoundViewController.h
//  sixLive
//
//  Created by li’Pro on 2017/6/29.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXCommonListViewController.h"
@class SIXSoundHeaderSupplementaryView;

@interface SIXSoundViewController : SIXCommonListViewController

/**
 点击 好声音 顶部分类按钮的回调方法
 
 @param headerView 顶部分类工具条
 @param type 新选择的 type 类型
 */
- (void)soundHeaderSupplementaryView:(SIXSoundHeaderSupplementaryView *)headerView didClickedBtnType:(NSString *)type ;

@end
