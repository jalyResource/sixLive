//
//  SIXSelectTypeBtnModel.m
//  sixLive
//
//  Created by li’Pro on 2017/6/30.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXSelectTypeBtnModel.h"

@implementation SIXSelectTypeBtnModel

+ (NSArray<SIXSelectTypeBtnModel *> *)defaultTypeBtnModelArray {
    static NSArray<SIXSelectTypeBtnModel *> *arrTypeBtnModel = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"lobby_live_select_type" ofType:@"plist"];
        NSArray<NSDictionary *> *arrDic = [NSArray arrayWithContentsOfFile:filePath];
        
        NSMutableArray<SIXSelectTypeBtnModel *> *arrTemp = [[NSMutableArray alloc] initWithCapacity:arrDic.count];
        for (NSDictionary *dic in arrDic) {
            [arrTemp addObject:[self instanceWithDic:dic]];
        }
        arrTypeBtnModel = arrTemp.copy;
    });
    
    return arrTypeBtnModel;
}


+ (instancetype)instanceWithDic:(NSDictionary *)dic {
    SIXSelectTypeBtnModel *model = [[SIXSelectTypeBtnModel alloc] init];
    
    model.imageName = [NSString stringWithFormat:@"%@", dic[@"imageName"]];
    model.title = [NSString stringWithFormat:@"%@", dic[@"title"]];
    
    return model;
}

@end
