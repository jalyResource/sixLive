//
//  SIXTabBar.m
//  sixLive
//
//  Created by li’Pro on 2017/7/3.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXTabBar.h"

@interface SIXTabBar ()
/** 放 按钮 */
@property (strong, nonatomic) NSMutableArray<UIButton *> *arrTabBarButton;

@end

@implementation SIXTabBar

+ (instancetype)homeTabBar {
    SIXTabBar *tabBar = [[SIXTabBar alloc] init];
    
    tabBar.arrTabBarModel = [SIXTabBarModel defaultTabBarModelArray];
    tabBar.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
    
    return tabBar;
}

- (void)setArrTabBarModel:(NSArray<SIXTabBarModel *> *)arrTabBarModel {
    _arrTabBarModel = arrTabBarModel;
    [self.arrTabBarButton makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (NSUInteger i = 0; i<arrTabBarModel.count; i++) {
        SIXTabBarModel *model = arrTabBarModel[i];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        UIImage *normalImg = [UIImage imageNamed:@"live_list_icon_local"];
//        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [btn setImage:normalImg forState:UIControlStateNormal];
//        [btn setImage:[UIImage imageNamed:model.imageSelected] forState:UIControlStateSelected];
//        [btn setBackgroundImage:normalImg forState:UIControlStateNormal];
        
        
//        btn.backgroundColor = [UIColor randomColor];
        
        [self addSubview:btn];
        [self.arrTabBarButton addObject:btn];
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    UIButton *btn = nil;
    CGFloat x = 0, y = 0, w = self.width / self.arrTabBarButton.count, h = self.width;
    
    for (NSUInteger i = 0; i < self.arrTabBarButton.count; i++) {
        btn = self.arrTabBarButton[i];
        btn.frame = CGRectMake(x, y, w, h);
        
        x += w;
    }
}


- (NSMutableArray<UIButton *> *)arrTabBarButton {
    if (!_arrTabBarButton) {
        _arrTabBarButton = [NSMutableArray new];
    }
    return _arrTabBarButton;
}

@end




@implementation SIXTabBarModel


+ (instancetype)instanceWithDic:(NSDictionary *)dic {
    SIXTabBarModel *model = [SIXTabBarModel new];
    model.imageSelected = [NSString stringWithFormat:@"%@", dic[@"imageSelected"]];
    model.image = [NSString stringWithFormat:@"%@", dic[@"image"]];
    
    return model;
}

/**
 获取主页 tabBar 的模型数组
 */
+ (NSArray<SIXTabBarModel *> *)defaultTabBarModelArray {
    static NSArray<SIXTabBarModel *> *attModel = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"tabBar_button_info" ofType:@"plist"];
        NSArray<NSDictionary *> *arrDic = [NSArray arrayWithContentsOfFile:filePath];
        
        NSMutableArray<SIXTabBarModel *> *arrTemp = [[NSMutableArray alloc] initWithCapacity:arrDic.count];
        for (NSDictionary *dic in arrDic) {
            [arrTemp addObject:[self instanceWithDic:dic]];
        }
        
        attModel = arrTemp.copy;
    });
    
    
    return attModel;
}

@end





























