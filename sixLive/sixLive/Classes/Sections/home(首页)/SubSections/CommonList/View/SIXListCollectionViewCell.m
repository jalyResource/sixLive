//
//  SIXListCollectionViewCell.m
//  sixLive
//
//  Created by li’Pro on 2017/6/28.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXListCollectionViewCell.h"

@interface SIXListCollectionViewCell ()
/** 背景图 */
@property (strong, nonatomic) UIImageView *imgViewBackground;
@property (strong, nonatomic) UIImageView *imgViewShadow;
/** 右上角 标签 */
@property (strong, nonatomic) UILabel *lblTag;

@property (strong, nonatomic) UILabel *lblName;

@property (strong, nonatomic) UILabel *lblCount;

/** 放在 cell 右侧，挡住 刷新控件 */
@property (strong, nonatomic) UIView *viewRightTemp;

@end

@implementation SIXListCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}
#pragma -mark 
#pragma -mark privete
- (void)setUp {
    [self.contentView addSubview:self.imgViewBackground];
    
    [self.contentView addSubview:self.imgViewShadow];
    
    [self.contentView addSubview:self.lblTag];
    
    [self.contentView addSubview:self.lblName];
    
    [self.contentView addSubview:self.lblCount];
    
    [self.contentView addSubview:self.viewRightTemp];
}

- (void)setUser:(SIXUser *)user {
    _user = user;
    
    [self.imgViewBackground sd_setImageWithURL:[NSURL URLWithString:user.pospic] placeholderImage:[self getPlaceholderImage]];
    self.lblTag.text = user.tagname;
    self.lblName.text = user.username;
    self.lblCount.text = [NSString stringWithFormat:@"%lu人", user.count];
    
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
}

/**
 根据屏幕,返回不同大小的占位图

 @return 占位图
 */
- (UIImage *)getPlaceholderImage {
    NSString *imgName = @"live_list_placeholder_1242";
    if (SIX_SCREEN_WIDTH == 320) {
        imgName = @"live_list_placeholder_640";
    } else if (SIX_SCREEN_WIDTH == 375) {
        imgName = @"live_list_placeholder_750";
    } 
    return [UIImage imageNamed:imgName];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    
    self.imgViewBackground.frame = self.contentView.bounds;
    
    CGFloat shadowH = 40;
    CGFloat shadowY = self.contentView.height - shadowH;

    self.imgViewShadow.frame = CGRectMake(0, shadowY, self.width, shadowH);
    
    CGFloat labWidth = [self.lblTag.text textWidthWithFont:self.lblTag.font height:23] + 10;
    self.lblTag.frame = CGRectMake(self.contentView.width - labWidth - 5, 5, labWidth, 23);
    self.lblTag.hidden = self.lblTag.text.length == 0;
    
    // count
    labWidth = [self.lblCount.text textWidthWithFont:self.lblCount.font height:14];
    self.lblCount.frame = CGRectMake(self.contentView.width - 5 - labWidth, self.contentView.height - 23, labWidth, 17);
    
    // name
    labWidth = self.lblCount.frame.origin.x - 7 - 3;
    self.lblName.frame = CGRectMake(7, self.contentView.height - 7 - 16, labWidth, 16);
    
    // view temp
    CGRect frameViewTemp = self.contentView.frame;
    frameViewTemp.origin.x = frameViewTemp.size.width;
    frameViewTemp.origin.y = 0;
    frameViewTemp.size.width = 2;
    self.viewRightTemp.frame = frameViewTemp;
    
    [CATransaction commit];
}




#pragma -mark 
#pragma -mark getters
- (UIImageView *)imgViewBackground {
    if (!_imgViewBackground) {
        _imgViewBackground = [[UIImageView alloc] init];
        _imgViewBackground.backgroundColor = [UIColor clearColor];
        _imgViewBackground.contentMode = UIViewContentModeScaleAspectFill;
        _imgViewBackground.layer.masksToBounds = YES;
    }
    return _imgViewBackground;
}
- (UIImageView *)imgViewShadow {
    if (!_imgViewShadow) {
        _imgViewShadow = [[UIImageView alloc] init];
        _imgViewShadow.backgroundColor = [UIColor clearColor];
        _imgViewShadow.contentMode = UIViewContentModeScaleToFill;
        _imgViewShadow.image = [UIImage imageNamed:@"live_lobby_image_anchor_shadow"];
        _imgViewShadow.layer.masksToBounds = YES;
    }
    return _imgViewShadow;
}

- (UILabel *)lblTag {
    if (!_lblTag) {
        _lblTag = [[UILabel alloc] init];
        _lblTag.backgroundColor = [UIColor clearColor];
        _lblTag.font = [UIFont systemFontOfSize:12];
        _lblTag.textColor = [UIColor whiteColor];
        _lblTag.textAlignment = NSTextAlignmentCenter;
        _lblTag.layer.borderColor = [UIColor whiteColor].CGColor;
        _lblTag.layer.borderWidth = 1.;
        _lblTag.layer.cornerRadius = 4.;
        _lblTag.layer.masksToBounds = YES;
    }
    return _lblTag;
}

- (UILabel *)lblName {
    if (!_lblName) {
        _lblName = [[UILabel alloc] init];
        _lblName.backgroundColor = [UIColor clearColor];
        _lblName.font = [UIFont systemFontOfSize:13];
        _lblName.textColor = [UIColor whiteColor];
    }
    return _lblName;
}

- (UILabel *)lblCount {
    if (!_lblCount) {
        _lblCount = [[UILabel alloc] init];
        _lblCount.backgroundColor = [UIColor clearColor];
        _lblCount.font = [UIFont systemFontOfSize:12];
        _lblCount.textColor = [UIColor whiteColor];
    }
    return _lblCount;
}


- (UIView *)viewRightTemp {
    if (!_viewRightTemp) {
        _viewRightTemp = [[UIView alloc] init];
        _viewRightTemp.backgroundColor = SIX_BACKGROUND_COLOR;
    }
    return _viewRightTemp;
}

@end













