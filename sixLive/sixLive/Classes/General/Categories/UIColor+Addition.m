//
//  UIColor+Addition.m
//  sixLive
//
//  Created by li’Pro on 2017/6/27.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "UIColor+Addition.h"

@implementation UIColor (Addition)

+ (UIColor *)colorWithHex:(NSUInteger)hex {
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0  
                           green:((float)((hex & 0xFF00) >> 8))/255.0  
                            blue:((float)(hex & 0xFF))/255.0 alpha:1.0]; 
}

@end
