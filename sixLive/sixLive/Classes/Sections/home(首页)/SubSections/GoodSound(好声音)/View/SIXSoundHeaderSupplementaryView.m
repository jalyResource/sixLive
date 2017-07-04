//
//  SIXSoundHeaderSupplementaryView.m
//  sixLive
//
//  Created by li’Pro on 2017/6/29.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXSoundHeaderSupplementaryView.h"


@interface SIXSoundHeaderSupplementaryView ()
/** 所有 btn 放在此数组中  */
@property (strong, nonatomic) NSMutableArray<UIButton *> *arrOfBtn;
/** 分割线 */
@property (strong, nonatomic) UILabel *lblHorizentalLine;
@property (strong, nonatomic) UILabel *lblVerticalLeft;
@property (strong, nonatomic) UILabel *lblVerticalRight;
/** 按钮对应接口参数中 type 值数组 */
@property (strong, nonatomic) NSArray<NSString *> *arrOfType;

@end

@implementation SIXSoundHeaderSupplementaryView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}
- (void)setUp {
    self.arrOfBtn = [[NSMutableArray alloc] initWithCapacity:6];
    // 添加 6 个按钮
    NSArray<SIXSoundHeaderBtnModel *> *arrOfBtnModel = [SIXSoundHeaderBtnModel defaultArrayOfModel];
    // @[@"u0", @"r10", @"r5", @"r4", @"r1", @"r2"];
    self.arrOfType = [arrOfBtnModel valueForKey:@"type"];
    
    for (NSUInteger i = 0; i<arrOfBtnModel.count; i++) {
        SIXSoundHeaderBtnModel *model = arrOfBtnModel[i];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitleColor:[UIColor colorWithHex:0x929292] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHex:0xdf1691] forState:UIControlStateSelected];
        [btn setTitle:model.title forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:model.image_normal] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:model.image_selected] forState:UIControlStateSelected];
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 3.5, 0, 0);
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 3.5);
        btn.tag = 100 + i;
        btn.exclusiveTouch = YES;
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
        [self.arrOfBtn addObject:btn];
    }
    // 添加分割线
    [self addSubview:self.lblVerticalLeft];
    [self addSubview:self.lblVerticalRight];
    [self addSubview:self.lblHorizentalLine];
}

- (void)btnClicked:(UIButton *)sender {
    NSUInteger index = sender.tag % 100;
    
    NSString *type = self.arrOfType[index];
    [self setType:type];
    
    
//     明日任务：添加代理方法，通知 VC loadData 刷新界面
    if (self.delegate && [self.delegate respondsToSelector:@selector(soundHeaderSupplementaryView:didClickedBtnType:)]) {
        [self.delegate soundHeaderSupplementaryView:self didClickedBtnType:type];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    CGFloat width = self.width / 3.0;
    CGFloat height = self.height / 2.0;
    CGFloat x = 0, y = 0;
    for (NSUInteger i = 0; i<self.arrOfBtn.count; i++) {
        x = width * ( i % 3);
        y = height * (i / 3);
        UIButton *btn = self.arrOfBtn[i];
        btn.frame = CGRectMake(x, y, width, height);
    }
    
    self.lblHorizentalLine.frame = CGRectMake(10, height, self.width - 20, 0.5);
    self.lblVerticalLeft.frame = CGRectMake(width, 0, 0.5, self.height);
    self.lblVerticalRight.frame = CGRectMake(width * 2, 0, 0.5, self.height);
    
    [CATransaction commit];
}


+ (CGSize)viewSize {
    return CGSizeMake(SIX_SCREEN_WIDTH, 87);
}

- (void)setDicParams:(NSMutableDictionary *)dicParams {
    _dicParams = dicParams;
    self.type = dicParams[@"type"];
}
- (void)setType:(NSString *)type {
    _type = type;
    
    [self.arrOfBtn enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selected = NO;
    }];
    
    
    NSInteger index = -1;
    index = [self.arrOfType indexOfObject:type];
    UIButton *btnSelected = nil;
    if (index >= 0 && index < self.arrOfBtn.count) {
        btnSelected = self.arrOfBtn[index];
    }
    btnSelected.selected = YES;
}

#pragma -mark 
#pragma -mark getters
- (UILabel *)lblVerticalLeft {
    if (!_lblVerticalLeft) {
        _lblVerticalLeft = [[UILabel alloc] init];
        _lblVerticalLeft.backgroundColor = [UIColor colorWithHex:0xcccccc];
    }
    return _lblVerticalLeft;
}
- (UILabel *)lblVerticalRight {
    if (!_lblVerticalRight) {
        _lblVerticalRight = [[UILabel alloc] init];
        _lblVerticalRight.backgroundColor = [UIColor colorWithHex:0xcccccc];
    }
    return _lblVerticalRight;
}
- (UILabel *)lblHorizentalLine {
    if (!_lblHorizentalLine) {
        _lblHorizentalLine = [[UILabel alloc] init];
        _lblHorizentalLine.backgroundColor = [UIColor colorWithHex:0xcccccc];
    }
    return _lblHorizentalLine;
}

@end




@implementation SIXSoundHeaderBtnModel


+ (instancetype)instanceWithDic:(NSDictionary *)dic {
    SIXSoundHeaderBtnModel *model = [[SIXSoundHeaderBtnModel alloc] init];
    model.title = [NSString stringWithFormat:@"%@", dic[@"title"]];
    model.image_normal = [NSString stringWithFormat:@"%@", dic[@"image_normal"]];
    model.image_selected = [NSString stringWithFormat:@"%@", dic[@"image_selected"]];
    model.type = [NSString stringWithFormat:@"%@", dic[@"type"]];
    
    return model;
}

+ (NSArray<SIXSoundHeaderBtnModel *> *)defaultArrayOfModel {
    static NSMutableArray<SIXSoundHeaderBtnModel *> *arrTemp = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 找到 plist 路径，生成字典数组
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"lobby_live_sound_btn_kind" ofType:@"plist"];
        NSArray<NSDictionary *> *array = [NSArray arrayWithContentsOfFile:filePath];
        
        // 根据 数组创建模型
        arrTemp = [[NSMutableArray alloc] initWithCapacity:array.count];
        for (NSDictionary *dic in array) {
            [arrTemp addObject:[self instanceWithDic:dic]];
        }
    });
    
    return arrTemp.copy;
}

@end


















