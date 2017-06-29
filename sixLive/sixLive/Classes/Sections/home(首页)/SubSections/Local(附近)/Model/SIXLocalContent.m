//
//  SIXLocalContent.m
//  sixLive
//
//  Created by li’Pro on 2017/6/29.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXLocalContent.h"

@implementation SIXLocalContent

+ (instancetype)instanceWithDictionary:(NSDictionary *)dic {
    if (nil == dic) {
        return nil;
    }
    SIXLocalContent *localContent = [[SIXLocalContent alloc] init];
    
    localContent.pid = [NSString stringWithFormat:@"%@", dic[@"pid"]];
    localContent.ptitle = [NSString stringWithFormat:@"%@", dic[@"ptitle"]];
    localContent.arrRoomList = [SIXUser userArrayWithJSONArray:dic[@"roomList"]];
    localContent.pagename = [NSString stringWithFormat:@"%@", dic[@"pagename"]];
    localContent.arrProvince = [SIXProvince provinceArrayWithJSONArray:dic[@"provinceNumAry"]];

    return localContent;
}

+ (NSArray<SIXLocalContent *> *)localContentArrayWithJSONArray:(NSArray<NSDictionary *> *)array {
    if (0 == array.count) {
        return nil;
    }
    
    NSMutableArray<SIXLocalContent *> *arrTemp = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSDictionary *dic in array) {
        [arrTemp addObject:[self instanceWithDictionary:dic]];
    }
    return arrTemp.copy;
}

@end





@implementation SIXProvince

+ (instancetype)instanceWithDictionary:(NSDictionary *)dic {
    if (nil == dic) {
        return nil;
    }
    SIXProvince *province = [[SIXProvince alloc] init];
    
    province.pid = [NSString stringWithFormat:@"%@", dic[@"pid"]];
    province.title = [NSString stringWithFormat:@"%@", dic[@"title"]];
    province.num = [dic[@"num"] integerValue];
    
    return province;
}

+ (NSArray<SIXProvince *> *)provinceArrayWithJSONArray:(NSArray<NSDictionary *> *)array {
    if (0 == array.count) {
        return nil;
    }
    
    NSMutableArray<SIXProvince *> *arrTemp = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSDictionary *dic in array) {
        [arrTemp addObject:[self instanceWithDictionary:dic]];
    }
    return arrTemp.copy;
}

@end



























