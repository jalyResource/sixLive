//
//  NSString+Addition.m
//  sixLive
//
//  Created by li’Pro on 2017/6/28.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "NSString+Addition.h"

@implementation NSString (Addition)


- (CGFloat)textWidthWithFont:(UIFont *)font height:(CGFloat)height {
    NSString *text = self;
    return [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size.width;
}

- (CGFloat)textHeightWithFont:(UIFont *)font width:(CGFloat)width {
    NSString *text = self;
    return [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size.height;
}


@end
