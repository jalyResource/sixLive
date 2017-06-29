//
//  SIXProvinceCell.m
//  sixLive
//
//  Created by li’Pro on 2017/6/29.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXProvinceCell.h"
#import "SIXLocalContent.h"

@interface SIXProvinceCell ()

@property (strong, nonatomic) UILabel *lblProvince;

@property (strong, nonatomic) UIImageView *imgViewIcon;

@end

@implementation SIXProvinceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    [self addSubview:self.lblProvince];
    
    [self addSubview:self.imgViewIcon];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.lblProvince.frame = CGRectMake(10, 0, 200, self.height);
    
    CGFloat x = SIX_SCREEN_WIDTH - 30;
    self.imgViewIcon.frame = CGRectMake(x, 18, 20, 20);
}

#pragma -mark 
#pragma -mark setters
- (void)setProvince:(SIXProvince *)province {
    _province = province;
    self.lblProvince.text = province.title;
}
- (void)setCurrent:(BOOL)current {
    _current = current;
    UIImage *img = nil;
    if (current) {
        img = [UIImage imageNamed:@"live_list_icon_menu_cell_selected"];
    } else {
        img = [UIImage imageNamed:@"live_list_icon_menu_cell_normal"];
    }
    self.imgViewIcon.image = img;
}

#pragma -mark 
#pragma -mark getters
- (UILabel *)lblProvince {
    if (!_lblProvince) {
        _lblProvince = [[UILabel alloc] init];
        _lblProvince.font = [UIFont systemFontOfSize:14];
        _lblProvince.textColor = [UIColor colorWithHex:0x333333];
    }
    return _lblProvince;
}

- (UIImageView *)imgViewIcon {
    if (!_imgViewIcon) {
        _imgViewIcon = [[UIImageView alloc] init];
    }
    return _imgViewIcon;
}

@end





















