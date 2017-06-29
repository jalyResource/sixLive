//
//  SIXHttpRequest.m
//  sixLive
//
//  Created by li’Pro on 2017/6/28.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXHttpRequest.h"

NSString *const SIX_BASE_URL = @"http://v.6.cn";

static NSTimeInterval REQUEST_TIME_OUT = 15;


@interface SIXHttpRequest ()

@property (strong, nonatomic) AFHTTPSessionManager *manager;

@end

@implementation SIXHttpRequest

+ (instancetype)shareHttpRequest {
    static SIXHttpRequest *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SIXHttpRequest alloc] init];
    });
    
    return instance;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:SIX_BASE_URL]];
        self.manager.requestSerializer.timeoutInterval = REQUEST_TIME_OUT;
        //text/html
        self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        NSSet *myContentTypeSet = [NSSet setWithObjects:@"text/html",@"text/plain", nil];
        self.manager.responseSerializer.acceptableContentTypes = [self.manager.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:myContentTypeSet];
        
        
    }
    return self;
}


- (void)GET:(NSString *)link paramaters:(NSDictionary *)params success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock {
    [self.manager GET:link parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        ;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            // 判断 flag
            NSUInteger flag = [[((NSDictionary *)responseObject) objectForKey:@"flag"] integerValue];
            
            switch (flag) {
                case EnumHttpCodeFaile: {
                    NSError *error = [NSError errorWithDomain:link code:flag userInfo:responseObject];
                    failureBlock(error);
                    break;
                }
                default:
                    successBlock((NSDictionary *)responseObject);
                    break;
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

- (void)POST:(NSString *)link paramaters:(NSDictionary *)params success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock {
    [self.manager POST:link parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        ;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            // 判断 flag
            NSUInteger flag = [[((NSDictionary *)responseObject) objectForKey:@"flag"] integerValue];
            
            switch (flag) {
                case EnumHttpCodeFaile: {
                    NSError *error = [NSError errorWithDomain:link code:flag userInfo:responseObject];
                    failureBlock(error);
                    break;
                }
                default:
                    successBlock((NSDictionary *)responseObject);
                    break;
            }

        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}



@end























