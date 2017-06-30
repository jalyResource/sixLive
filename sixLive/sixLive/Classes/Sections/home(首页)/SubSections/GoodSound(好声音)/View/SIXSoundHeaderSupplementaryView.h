//
//  SIXSoundHeaderSupplementaryView.h
//  sixLive
//
//  Created by li’Pro on 2017/6/29.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXCollectionSupplementaryView.h"
@class SIXSoundHeaderSupplementaryView;

@protocol SIXSoundHeaderSupplementaryViewDelegate <NSObject>

@optional
/**
 点击 好声音 顶部分类按钮的回调方法

 @param headerView 顶部分类工具条
 @param type 新选择的 type 类型
 */
- (void)soundHeaderSupplementaryView:(SIXSoundHeaderSupplementaryView *)headerView didClickedBtnType:(NSString *)type ;

@end


@interface SIXSoundHeaderSupplementaryView : SIXCollectionSupplementaryView

@property (weak, nonatomic) id<SIXSoundHeaderSupplementaryViewDelegate> delegate;

@property (strong, nonatomic) NSMutableDictionary *dicParams;
@property (copy, nonatomic) NSString *type;


@end






@interface SIXSoundHeaderBtnModel : NSObject
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *image_normal;
@property (copy, nonatomic) NSString *image_selected;
@property (copy, nonatomic) NSString *type;
/**
 从 plist 文件加载数据，创建模型数组
 
 @return 模型数组
 */
+ (NSArray<SIXSoundHeaderBtnModel *> *)defaultArrayOfModel ;

@end
