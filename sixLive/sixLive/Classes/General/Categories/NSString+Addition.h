//
//  NSString+Addition.h
//  sixLive
//
//  Created by li’Pro on 2017/6/28.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Addition)

/**
 * 计算文字宽度
 */
- (CGFloat)textWidthWithFont:(UIFont *)font height:(CGFloat)height ;
/**
 * 计算文字高度
 */
- (CGFloat)textHeightWithFont:(UIFont *)font width:(CGFloat)width ;

@end
