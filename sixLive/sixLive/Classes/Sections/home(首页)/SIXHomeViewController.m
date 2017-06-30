//
//  SIXLiveViewController.m
//  sixLive
//
//  Created by li’Pro on 2017/6/27.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXHomeViewController.h"
#import "SIXCommonListViewController.h"
#import "SIXHotTopicListViewController.h"
#import "SIXLocalListViewController.h"
#import "SIXSoundViewController.h"
#import "SIXTitleListView.h"


typedef NS_ENUM(NSUInteger, EnumLiveListType) {
    EnumLiveListTypeHot   = 0, // 热门
    EnumLiveListTypeRed   = 1, // 手机红人
    EnumLiveListTypeLocal = 2, // 附近
    EnumLiveListTypeSound = 3, // 好声音
    EnumLiveListTypeDance = 4, // 舞蹈
    EnumLiveListTypeFunny = 5, // 搞笑
    EnumLiveListTypeChat  = 6, // 唠嗑
    EnumLiveListTypeMale  = 7  // 男神
};

@interface SIXHomeViewController ()<UIScrollViewDelegate>
/** UI */
@property (strong, nonatomic) SIXTitleListView *viewTopTitle;

@property (strong, nonatomic) UIScrollView *scrollView;

/** data */
@property (strong, nonatomic) NSArray<NSDictionary *> *arrDicParams;
/// EnumLiveListTypeHot   = 0, // 热门
@property (strong, nonatomic) SIXHotTopicListViewController *hotTopicViewController;
/// EnumLiveListTypeRed   = 1, // 手机红人
@property (strong, nonatomic) SIXCommonListViewController *redViewController;
/// EnumLiveListTypeLocal = 2, // 附近
@property (strong, nonatomic) SIXLocalListViewController *localViewController;
/// EnumLiveListTypeSound = 3, // 好声音
@property (strong, nonatomic) SIXSoundViewController *soundViewController;
/// EnumLiveListTypeDance = 4, // 舞蹈
@property (strong, nonatomic) SIXCommonListViewController *danceViewController;
/// EnumLiveListTypeFunny = 5, // 搞笑
@property (strong, nonatomic) SIXCommonListViewController *funnyViewController;
/// EnumLiveListTypeChat  = 6, // 唠嗑
@property (strong, nonatomic) SIXCommonListViewController *chatViewController;
/// EnumLiveListTypeMale  = 7  // 男神
@property (strong, nonatomic) SIXCommonListViewController *maleViewController;

@end

@implementation SIXHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self addSubviews];
    [self configSubControllers];
    [self setUpHeaderBar];
}

- (void)setUpHeaderBar {
    [self.view bringSubviewToFront:self.headerBar];
    [self.view bringSubviewToFront:self.customStatusBar];
    
    NSArray<NSString *> *arrTitle = @[@"热门", @"手机红人", @"好声音（全部）", @"舞蹈", @"搞笑", @"唠嗑", @"男神"];
    self.viewTopTitle.arrTitle = arrTitle;
    [self.headerBar addSubview:self.viewTopTitle];
    
    UIColor *colorBg = [[UIColor redColor] colorWithAlphaComponent:0.85];
    self.headerBar.backgroundColor = colorBg;
    self.customStatusBar.backgroundColor = colorBg;
}

- (void)addSubviews {
    [self.view addSubview:self.scrollView];
}

- (void)configSubControllers {
    NSDictionary *dicParamsHot = @{
                                         @"av" : @(2.1),
                                         @"p"  : @(0),
                                         @"rate": @1,
                                         @"size" : @0,
                                         @"type" : @"", // 热门
                                         @"padapi" : @"coop-mobile-getlivelistnew.php"
                                         };
    NSDictionary *dicParamsLocal = @{       // 附近
                                @"p"  : @(0),
                                @"size" : @0,
                                @"padapi" : @"coop-mobile-getlivelistlocation.php",
                                @"pid" : @""
                                };
    
    NSDictionary *dicParamsMobileRed = @{
                                         @"av" : @(2.1),
                                         @"p"  : @(0),
                                         @"rate": @1,
                                         @"size" : @0,
                                         @"type" : @"mlive", // 手机红人
                                         @"padapi" : @"coop-mobile-getlivelistnew.php"
                                         };
    /*
     好声音 type：
					全部：u0 ,炽星 ： r10,   超星:r5,   巨星：r4, 明星 ： r1,  红人： r2
     */
    NSDictionary *dicParamsGoodVoice = @{
                                     @"av" : @(2.1),
                                     @"p"  : @(0),
                                     @"rate": @1,
                                     @"size" : @0,
                                     @"type" : @"u0", // 全部
                                     @"padapi" : @"coop-mobile-getlivelistnew.php"
                                     };
    NSDictionary *dicParamsDance = @{
                                         @"av" : @(2.1),
                                         @"p"  : @(0),
                                         @"rate": @1,
                                         @"size" : @0,
                                         @"type" : @"u1", // 舞蹈
                                         @"padapi" : @"coop-mobile-getlivelistnew.php"
                                         };
    NSDictionary *dicParamsFunny = @{
                                     @"av" : @(2.1),
                                     @"p"  : @(0),
                                     @"rate": @1,
                                     @"size" : @0,
                                     @"type" : @"u2", // 搞笑
                                     @"padapi" : @"coop-mobile-getlivelistnew.php"
                                     };
    NSDictionary *dicParamsChat = @{
                                     @"av" : @(2.1),
                                     @"p"  : @(0),
                                     @"rate": @1,
                                     @"size" : @0,
                                     @"type" : @"u3", // 唠嗑
                                     @"padapi" : @"coop-mobile-getlivelistnew.php"
                                     };
    NSDictionary *dicParamsMale = @{
                                     @"av" : @(2.1),
                                     @"p"  : @(0),
                                     @"rate": @1,
                                     @"size" : @0,
                                     @"type" : @"male",  // 男神
                                     @"padapi" : @"coop-mobile-getlivelistnew.php"
                                     };
    // 热门，手机红人，附近，好声音，舞蹈，搞笑，唠嗑，男神
    self.arrDicParams = @[dicParamsHot, dicParamsMobileRed, dicParamsLocal, dicParamsGoodVoice, dicParamsDance, dicParamsFunny, dicParamsChat, dicParamsMale];

    /*
     // 说明 type： 热门 ："", 手机红人：mlive   , 舞蹈：u1，搞笑：u2，唠嗑：u3，男神：male，
     好声音 type：
					全部：u0 ,炽星 ： r10,   超星:r5,   巨星：r4, 明星 ： r1,  红人： r2
     
     -----------
     av:2.1
     p : 0
     rate : 1
     size ： 0
     type : ""
     // 说明 type： 热门 ："", 手机红人：mlive
     */
    // 默认将“热门”添加到第一页
    SIXHotTopicListViewController *hotTopicVC = [[SIXHotTopicListViewController alloc] initWithParams:dicParamsHot];
    hotTopicVC.view.frame = CGRectMake(0, 0, SIX_SCREEN_WIDTH, SIX_SCREEN_HEIGHT);
    [self.scrollView addSubview:hotTopicVC.view];
    [self addChildViewController:hotTopicVC];
    self.hotTopicViewController = hotTopicVC;
    
    self.scrollView.contentSize = CGSizeMake(self.arrDicParams.count * SIX_SCREEN_WIDTH, SIX_TABBAR_HEIGHT);
}

- (__kindof SIXCommonListViewController *)getVCWithTarget:(Class)target param:(NSDictionary *)param {
    
    NSMethodSignature *sig = [target methodSignatureForSelector:@selector(initWithParams:)];
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sig];
    invocation.target = target;
    invocation.selector = @selector(initWithParams:);
    [invocation setArgument:&param atIndex:2];
    [invocation invoke];
    
    id retVC = nil;
    if ( sig.methodReturnLength ) {
        [invocation getReturnValue:&retVC];
    }
    return retVC;
}



#pragma -mark 
#pragma -mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSUInteger index = scrollView.contentOffset.x/scrollView.width;
    DLog(@"index : %lu  %s",index,  __func__);
    [self addSubListViewToScrollViewAtIndex:index];
}





/**
 将指定下表的 列表添加到 scrollView
 
 @param index 
         EnumLiveListTypeHot   = 0, // 热门
         EnumLiveListTypeRed   = 1, // 手机红人
         EnumLiveListTypeLocal = 2, // 附近
         EnumLiveListTypeSound = 3, // 好声音
         EnumLiveListTypeDance = 4, // 舞蹈
         EnumLiveListTypeFunny = 5, // 搞笑
         EnumLiveListTypeChat  = 6, // 唠嗑
         EnumLiveListTypeMale  = 7  // 男神
 */
- (void)addSubListViewToScrollViewAtIndex:(NSUInteger)index {
    switch (index) {
        case EnumLiveListTypeHot:   { // 热门
            [self.scrollView addSubview:self.hotTopicViewController.view];
            break;
        } 
        case EnumLiveListTypeRed:   { // 手机红人
            [self.scrollView addSubview:self.redViewController.view];
            break;
        } 
        case EnumLiveListTypeLocal: { // 附近
            [self.scrollView addSubview:self.localViewController.view];
            break;
        } 
        case EnumLiveListTypeSound: { // 好声音
            [self.scrollView addSubview:self.soundViewController.view];
            break;
        } 
        case EnumLiveListTypeDance: { // 舞蹈
            [self.scrollView addSubview:self.danceViewController.view];
            break;
        } 
        case EnumLiveListTypeFunny: { // 搞笑
            [self.scrollView addSubview:self.funnyViewController.view];
            break;
        } 
        case EnumLiveListTypeChat:  { // 唠嗑
            [self.scrollView addSubview:self.chatViewController.view];
            break;
        } 
        case EnumLiveListTypeMale:  { // 男神
            [self.scrollView addSubview:self.maleViewController.view];
            break;
        } 
    }
}





#pragma -mark 
#pragma -mark  SIXNavigationBarDelegate methods
- (void)headerLeftButtonClicked {
    DLog(@"点击搜索");
}
- (void)headerRightButtonClicked {
    DLog(@"%s", __func__);
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.scrollView.frame = self.view.bounds;
}

#pragma -mark 
#pragma -mark getters
// EnumLiveListTypeRed   = 1, // 手机红人
//@property (strong, nonatomic) SIXCommonListViewController *redViewController;
- (SIXCommonListViewController *)redViewController {
    if (!_redViewController) {
        NSUInteger index = EnumLiveListTypeRed;
        _redViewController = [[SIXCommonListViewController alloc] initWithParams:self.arrDicParams[index]];
        [self addChildViewController:_redViewController];
        _redViewController.view.frame = CGRectMake(index * SIX_SCREEN_WIDTH, 0, SIX_SCREEN_WIDTH, SIX_SCREEN_HEIGHT);
    }
    return _redViewController;
}
// EnumLiveListTypeLocal = 2, // 附近
//@property (strong, nonatomic) SIXLocalListViewController *localViewController;
- (SIXLocalListViewController *)localViewController {
    if (!_localViewController) {
        NSUInteger index = EnumLiveListTypeLocal;
        _localViewController = [[SIXLocalListViewController alloc] initWithParams:self.arrDicParams[index]];
        [self addChildViewController:_localViewController];
        _localViewController.view.frame = CGRectMake(index * SIX_SCREEN_WIDTH, 0, SIX_SCREEN_WIDTH, SIX_SCREEN_HEIGHT);
    }
    return _localViewController;
}
// EnumLiveListTypeSound = 3, // 好声音
//@property (strong, nonatomic) SIXSoundViewController *soundViewController;
- (SIXSoundViewController *)soundViewController {
    if (!_soundViewController) {
        NSUInteger index = EnumLiveListTypeSound;
        _soundViewController = [[SIXSoundViewController alloc] initWithParams:self.arrDicParams[index]];
        [self addChildViewController:_soundViewController];
        _soundViewController.view.frame = CGRectMake(index * SIX_SCREEN_WIDTH, 0, SIX_SCREEN_WIDTH, SIX_SCREEN_HEIGHT);
    }
    return _soundViewController;
}

// EnumLiveListTypeDance = 4, // 舞蹈
//@property (strong, nonatomic) SIXCommonListViewController *danceViewController;
- (SIXCommonListViewController *)danceViewController {
    if (!_danceViewController) {
        NSUInteger index = EnumLiveListTypeDance;
        _danceViewController = [[SIXCommonListViewController alloc] initWithParams:self.arrDicParams[index]];
        [self addChildViewController:_danceViewController];
        _danceViewController.view.frame = CGRectMake(index * SIX_SCREEN_WIDTH, 0, SIX_SCREEN_WIDTH, SIX_SCREEN_HEIGHT);
    }
    return _danceViewController;
}
// EnumLiveListTypeFunny = 5, // 搞笑
//@property (strong, nonatomic) SIXCommonListViewController *funnyViewController;
- (SIXCommonListViewController *)funnyViewController {
    if (!_funnyViewController) {
        NSUInteger index = EnumLiveListTypeFunny;
        _funnyViewController = [[SIXCommonListViewController alloc] initWithParams:self.arrDicParams[index]];
        [self addChildViewController:_funnyViewController];
        _funnyViewController.view.frame = CGRectMake(index * SIX_SCREEN_WIDTH, 0, SIX_SCREEN_WIDTH, SIX_SCREEN_HEIGHT);
    }
    return _funnyViewController;
}
// EnumLiveListTypeChat  = 6, // 唠嗑
//@property (strong, nonatomic) SIXCommonListViewController *chatViewController;
- (SIXCommonListViewController *)chatViewController {
    if (!_chatViewController) {
        NSUInteger index = EnumLiveListTypeChat;
        _chatViewController = [[SIXCommonListViewController alloc] initWithParams:self.arrDicParams[index]];
        [self addChildViewController:_chatViewController];
        _chatViewController.view.frame = CGRectMake(index * SIX_SCREEN_WIDTH, 0, SIX_SCREEN_WIDTH, SIX_SCREEN_HEIGHT);
    }
    return _chatViewController;
}
// EnumLiveListTypeMale  = 7  // 男神
//@property (strong, nonatomic) SIXCommonListViewController *maleViewController;
- (SIXCommonListViewController *)maleViewController {
    if (!_maleViewController) {
        NSUInteger index = EnumLiveListTypeMale;
        _maleViewController = [[SIXCommonListViewController alloc] initWithParams:self.arrDicParams[index]];
        [self addChildViewController:_maleViewController];
        _maleViewController.view.frame = CGRectMake(index * SIX_SCREEN_WIDTH, 0, SIX_SCREEN_WIDTH, SIX_SCREEN_HEIGHT);
    }
    return _maleViewController;
}


- (SIXTitleListView *)viewTopTitle {
    if (!_viewTopTitle) {
        CGFloat width = SIX_SCREEN_WIDTH - 2 * SIX_NAVIGATIONBAR_HEIGHT;
        CGRect frame = CGRectMake(SIX_NAVIGATIONBAR_HEIGHT, 12, width, 25);
        _viewTopTitle = [[SIXTitleListView alloc] initWithFrame:frame];
        
    }
    return _viewTopTitle;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

@end



















