//
//  UIView+SIXRefresh.m
//  sixLive
//
//  Created by li’Pro on 2017/7/3.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "UIView+SIXRefresh.h"

@implementation UIView (SIXRefresh)

#pragma -mark 
#pragma -mark getters
- (CGFloat)six_x {
    return self.frame.origin.x;
}
- (CGFloat)six_y {
    return self.frame.origin.y;
}
- (CGFloat)six_width {
    return self.frame.size.width;
}
- (CGFloat)six_height {
    return self.frame.size.height;
}



#pragma -mark 
#pragma -mark setters
- (void)setSix_x:(CGFloat)six_x {
    CGRect rect = self.frame;
    rect.origin.x = six_x;
    self.frame = rect;
}
- (void)setSix_y:(CGFloat)six_y {
    CGRect rect = self.frame;
    rect.origin.y = six_y;
    self.frame = rect;
}
- (void)setSix_width:(CGFloat)six_width {
    CGRect rect = self.frame;
    rect.size.width = six_width;
    self.frame = rect;
}
- (void)setSix_height:(CGFloat)six_height {
    CGRect rect = self.frame;
    rect.size.height = six_height;
    self.frame = rect;
}

@end
