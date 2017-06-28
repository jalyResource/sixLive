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
#import "SIXTitleListView.h"

@interface SIXHomeViewController ()<UIScrollViewDelegate>
/** UI */
@property (strong, nonatomic) SIXTitleListView *viewTopTitle;

@property (strong, nonatomic) UIScrollView *scrollView;

//@property (strong, nonatomic) SIXCommonListViewController *commonListViewController;

@end

@implementation SIXHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
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
//    NSArray<NSDictionary *> *arrParams = @[dicParamsHot, dicParamsMobileRed, dicParamsGoodVoice, dicParamsDance, dicParamsFunny, dicParamsChat, dicParamsMale];
    NSArray<NSDictionary *> *arrParams = @[dicParamsHot];
    NSArray<NSString *> *arrVCClass = @[@"SIXHotTopicListViewController", @"SIXCommonListViewController"];

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
    
    for (NSUInteger i = 0; i<arrParams.count; i++) {
        NSDictionary *dicParam = arrParams[i];
//        Class c = NSClassFromString(arrVCClass[i]);
//        id target = [c alloc];
        
        SIXHotTopicListViewController *commonListViewController = [[SIXHotTopicListViewController alloc] initWithParams:dicParam];
        
//        SIXCommonListViewController *commonListViewController = [self getVCWithTarget:target param:dicParam];
        [self addChildViewController:commonListViewController];
        [self.view addSubview:commonListViewController.view];
        
        CGRect frame = CGRectMake(i * SIX_SCREEN_WIDTH, 0, SIX_SCREEN_WIDTH, SIX_SCREEN_HEIGHT);
        commonListViewController.view.frame = frame;
        [self.scrollView addSubview:commonListViewController.view];
    }
    
    self.scrollView.contentSize = CGSizeMake(arrParams.count * SIX_SCREEN_WIDTH, SIX_TABBAR_HEIGHT);
}

- (__kindof SIXCommonListViewController *)getVCWithTarget:(Class)target param:(NSDictionary *)param {
    
    NSMethodSignature *sig = [target methodSignatureForSelector:@selector(initWithParams:)];
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sig];
    invocation.target = target;
    invocation.selector = @selector(initWithParams:);
    [invocation setArgument:&param atIndex:2];
    [invocation invoke];
    
    id retVC = nil;
    if ( sig.methodReturnLength) {
        [invocation getReturnValue:&retVC];
    }
    return retVC;
}



- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.scrollView.frame = self.view.bounds;
}





#pragma -mark 
#pragma -mark  SIXNavigationBarDelegate methods
- (void)headerLeftButtonClicked {
    DLog(@"点击搜索");
}
- (void)headerRightButtonClicked {
    DLog(@"%s", __func__);
}

#pragma -mark 
#pragma -mark getters
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



















