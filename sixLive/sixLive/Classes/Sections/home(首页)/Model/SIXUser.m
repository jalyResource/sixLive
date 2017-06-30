//
//  SIXUser.m
//  sixLive
//
//  Created by li’Pro on 2017/6/28.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXUser.h"

@implementation SIXUser
- (void)setPospic:(NSString *)pospic {
//    _s --> _b
    _pospic = [pospic stringByReplacingOccurrencesOfString:@"_s." withString:@"_b." options:NSBackwardsSearch range:NSMakeRange(pospic.length - 10, 10)];
}

- (NSString *)tagname {
    if ( nil == _tagname || 0 == _tagname.length) {
        if (self.recordtype > 1) {
            return @"手机直播";
        }
    }
    
    return _tagname;
}

+ (instancetype)instanceWithDictionary:(NSDictionary *)dic {
    SIXUser *user = [[SIXUser alloc] init];
    
    user.uid = dic[@"uid"];
    user.username = dic[@"username"];
    user.pospic = dic[@"pospic"];
    user.picuser = dic[@"picuser"];
    user.tagname = dic[@"tagname"];
    user.count = [dic[@"count"] integerValue];
    user.recordtype = [dic[@"recordtype"] integerValue];
    
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
