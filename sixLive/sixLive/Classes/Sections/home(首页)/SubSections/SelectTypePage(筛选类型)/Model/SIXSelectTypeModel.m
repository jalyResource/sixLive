//
//  SIXSelectTypeModel.m
//  sixLive
//
//  Created by li’Pro on 2017/6/30.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXSelectTypeModel.h"


@interface SIXSelectTypeModel ()

/** 按表演类型分类 模型 */
@property (strong, nonatomic) NSArray<SIXSelectTypeBtnModel *> *arrSelectTypeBtnModel;

/** 按 主播等级分类 模型 */
@property (strong, nonatomic) NSArray<SIXSelectLevelBtnModel *> *arrSelectLevelBtnModel;

@end


@implementation SIXSelectTypeModel

+(instancetype)shareTypeModel {
    static SIXSelectTypeModel *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arrSelectTypeBtnModel = [SIXSelectTypeBtnModel defaultTypeBtnModelArray];
        self.arrSelectLevelBtnModel = [SIXSelectLevelBtnModel defaultLevelBtnModelArray];
    }
    return self;
}


- (SIXSelectTypeBtnModel *)selectTypeBtnModelAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item >= self.arrSelectTypeBtnModel.count) {
        return nil;
    }
    return self.arrSelectTypeBtnModel[indexPath.item];
}
- (SIXSelectLevelBtnModel *)selectLevelBtnModelAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item >= self.arrSelectLevelBtnModel.count) {
        return nil;
    }
    return self.arrSelectLevelBtnModel[indexPath.item];
}

- (NSUInteger)numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return self.arrSelectTypeBtnModel.count;
    }
    return self.arrSelectLevelBtnModel.count;;
}

- (NSUInteger)numberOfSections {
    return 2;
}


@end














