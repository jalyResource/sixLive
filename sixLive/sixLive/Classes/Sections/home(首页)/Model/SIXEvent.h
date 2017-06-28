//
//  SIXEvent.h
//  sixLive
//
//  Created by li’Pro on 2017/6/28.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SIXEvent : NSObject
/**
 type = 1,展示标题
 */
@property (copy, nonatomic) NSString *title;
/**
 type = 1,展示图片
 */
@property (copy, nonatomic) NSString *image;
/**
 type = 2,轮播图
 */
@property (copy, nonatomic) NSString *bannerimg;
/**
 2:轮播图 ， 1:上下滚动展示
 */
@property (assign, nonatomic) NSUInteger type;
/**
 type = 1,  ** 人在看
 */
@property (assign, nonatomic) NSUInteger count;

+ (instancetype)instanceWithDictionary:(NSDictionary *)dic ;

+ (NSArray<SIXEvent *> *)eventArrayWithJSONArray:(NSArray<NSDictionary *> *)array ;
/*
"title":"美伢与萌兽",
"uid":"76813635",
"rid":"222399663",
"image":"https://vi2.6rooms.com/live/2017/05/16/17/1010v1494926145464687224_s.jpg",
"bannerimg":"https://vi1.6rooms.com/live/2017/05/17/10/1013v1494989972227129412.jpg",
"largepic":"",
"type":1,
"count":22107
*/
@end
























