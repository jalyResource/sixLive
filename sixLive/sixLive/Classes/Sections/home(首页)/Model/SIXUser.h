//
//  SIXUser.h
//  sixLive
//
//  Created by li’Pro on 2017/6/28.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SIXUser : NSObject

@property (copy, nonatomic) NSString *uid;

@property (copy, nonatomic) NSString *username;
/** 直播列表图片 */
@property (copy, nonatomic) NSString *pic;
/** 用户头像 */
@property (copy, nonatomic) NSString *picuser;
/** 右上角 标签 */
@property (copy, nonatomic) NSString *tagname;
/** 在线人数 */
@property (assign, nonatomic) NSUInteger count;


+ (instancetype)instanceWithDictionary:(NSDictionary *)dic ;

+ (NSArray<SIXUser *> *)userArrayWithJSONArray:(NSArray<NSDictionary *> *)array ;

/*
 wealthrank": 25,
 "username": "\u820c\u5996\u5e7d\u5170\u4ee3\u7406\u5145\u79d2\u8fd4\u2602",
 "pic": "https:\/\/vi3.6rooms.com\/live\/2016\/08\/14\/18\/1010v1471170206243454463_s.jpg",
 "rid": "29775",
 "h264": "true",
 "isRecommend": 1,
 "ut": 1,
 "rtype": "u1",
 "count": 2299,
 "honor": "",
 "uid": "58660581",
 "sex": "0",
 "goldAnchor": 1, // 头条
 "zy": 0,
 "score": "7.00",
 "isSproutingAnchor": 0,
 "recscore": 0,
 "anchorTm": "1416319556",
 "ltype": 1,
 "sound": 0,
 "alevel": "r10",
 "isvideo": 0,
 "videotype": 5,
 "recordtype": 2,
 "flvtitle": "v58660581-110613755",
 "secflvtitle": "",
 "tagid": 7,
 "mgid": 3,
 "pospic": "https:\/\/vi3.6rooms.com\/live\/2016\/08\/14\/18\/1010v1471170206243454463_s.jpg",
 "tala": 0,
 "talc": 0,
 "province": 12,
 "realstarttime": 1498610784,
 "tagname": "\u6e38\u620f",
 "largepic": "https:\/\/vi2.6rooms.com\/live\/2017\/06\/28\/08\/1007v1498610789779344208_l.jpg"
 */

@end
