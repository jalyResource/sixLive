//
//  SIXSelectTypeBtnModel.h
//  sixLive
//
//  Created by li’Pro on 2017/6/30.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import <Foundation/Foundation.h>


/** 按表演类型分类 模型 */
@interface SIXSelectTypeBtnModel : NSObject

@property (copy, nonatomic) NSString *imageName;

@property (copy, nonatomic) NSString *title;

@property (assign, nonatomic, getter=isSelected) BOOL selected;

+ (NSArray<SIXSelectTypeBtnModel *> *)defaultTypeBtnModelArray ;

@end



/** 按 主播等级分类 模型 */
@interface SIXSelectLevelBtnModel : SIXSelectTypeBtnModel

//@property (copy, nonatomic) NSString *imageName;
//
//@property (copy, nonatomic) NSString *title;
//
//@property (assign, nonatomic, getter=isSelected) BOOL selected;

+ (NSArray<SIXSelectLevelBtnModel *> *)defaultLevelBtnModelArray ;

@end

















