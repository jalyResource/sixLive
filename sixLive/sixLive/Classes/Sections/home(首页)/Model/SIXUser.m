//
//  SIXUser.m
//  sixLive
//
//  Created by li’Pro on 2017/6/28.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXUser.h"

@implementation SIXUser

+ (instancetype)instanceWithDictionary:(NSDictionary *)dic {
    SIXUser *user = [[SIXUser alloc] init];
    
    user.uid = dic[@"uid"];
    user.username = dic[@"username"];
    user.pic = dic[@"pic"];
    user.picuser = dic[@"picuser"];
    user.tagname = dic[@"tagname"];
    user.count = [dic[@"count"] integerValue];
    
    return user;
}

+ (NSArray<SIXUser *> *)userArrayWithJSONArray:(NSArray<NSDictionary *> *)array {
    if (array.count == 0) {
        return @[];
    }
    
    NSMutableArray<SIXUser *> *arrTemp = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSDictionary *dic in array) {
        [arrTemp addObject:[self instanceWithDictionary:dic]];
    }
    return arrTemp;
}

@end
