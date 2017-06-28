//
//  SIXEvent.m
//  sixLive
//
//  Created by li’Pro on 2017/6/28.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXEvent.h"

@implementation SIXEvent

+ (instancetype)instanceWithDictionary:(NSDictionary *)dic {
    if (nil == dic) {
        return nil;
    }
    SIXEvent *event = [[SIXEvent alloc] init];
    event.type = [dic[@"type"] integerValue];
    event.count = [dic[@"count"] integerValue];
    event.title = [NSString stringWithFormat:@"%@", dic[@"title"]];
    event.image = [NSString stringWithFormat:@"%@", dic[@"image"]];
    event.bannerimg = [NSString stringWithFormat:@"%@", dic[@"bannerimg"]];
    
    return event;
}

+ (NSArray<SIXEvent *> *)eventArrayWithJSONArray:(NSArray<NSDictionary *> *)array {
    if (0 == array.count) {
        return @[];
    }
    
    NSMutableArray<SIXEvent *> *arrTemp = [[NSMutableArray alloc] initWithCapacity:array.count];
    SIXEvent *event = nil;
    for (NSDictionary *dic in array) {
        event = [self instanceWithDictionary:dic];
        [arrTemp addObject:event];
    }
    
    return arrTemp.copy;
}

@end
