//
//  SIXHttpRequest.h
//  sixLive
//
//  Created by li’Pro on 2017/6/28.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessBlock)(NSDictionary *responseObject);
typedef void(^FailureBlock)(NSError *error);


typedef NS_ENUM(NSUInteger, EnumHttpCode) {
    EnumHttpCodeFaile   =  402, // 失败
    EnumHttpCodeSuccess =  001 // 成功
};

@interface SIXHttpRequest : NSObject

+ (instancetype)shareHttpRequest ;


- (void)GET:(NSString *)link paramaters:(NSDictionary *)params success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock ;

- (void)POST:(NSString *)link paramaters:(NSDictionary *)params success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock ;

@end
