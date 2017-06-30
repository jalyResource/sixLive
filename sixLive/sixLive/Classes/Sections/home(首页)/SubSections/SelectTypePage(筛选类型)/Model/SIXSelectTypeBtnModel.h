//
//  SIXSelectTypeBtnModel.h
//  sixLive
//
//  Created by li’Pro on 2017/6/30.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SIXSelectTypeBtnModel : NSObject

@property (copy, nonatomic) NSString *imageName;

@property (copy, nonatomic) NSString *title;

@property (assign, nonatomic, getter=isSelected) BOOL selected;

+ (NSArray<SIXSelectTypeBtnModel *> *)defaultTypeBtnModelArray ;

@end
