//
//  SIXLocalContent.h
//  sixLive
//
//  Created by li’Pro on 2017/6/29.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SIXProvince;
@interface SIXLocalContent : NSObject


/**
 省份 id
 */
@property (copy, nonatomic) NSString *pid;

/**
 省份名
 */
@property (copy, nonatomic) NSString *ptitle;
/**
 主播列表 : SIXUser
 */
@property (copy, nonatomic) NSArray<SIXUser *> *arrRoomList;

@property (copy, nonatomic) NSString *pagename;
/**
 省份 列表 : SIXProvince
 */
@property (copy, nonatomic) NSArray<SIXProvince *> *arrProvince;

+ (instancetype)instanceWithDictionary:(NSDictionary *)dic ;
/*
 {
 "flag":"001",
 "content":{
     "pid":"1",
     "ptitle":"北京",
     "roomList":Array[13],
     "pagename":"index",
     "recid":"14987077179855-0",
     "provinceNumAry":Array[30]
 }
 */
@end




@interface SIXProvince : NSObject

@property (copy, nonatomic) NSString *pid;

@property (copy, nonatomic) NSString *title;

@property (assign, nonatomic) NSUInteger num;


+ (instancetype)instanceWithDictionary:(NSDictionary *)dic ;

+ (NSArray<SIXProvince *> *)provinceArrayWithJSONArray:(NSArray<NSDictionary *> *)array ;

/*
 "pid":1,
 "title":"北京",
 "num":13
 */

@end





















