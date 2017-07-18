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
#import "SIXSelectTypeViewController.h"
#import "SIXTitleListView.h"
#import "SIXThreeLineAnimationButton.h"



@interface SIXHomeViewController ()<UIScrollViewDelegate, SIXTitleListViewDelagate, SIXSelectTypeViewControllerDelegate>
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


/**
 通过右上角按钮，进入选择类型界面
 */
@property (strong, nonatomic) SIXSelectTypeViewController *selectTypeViewController;

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
    
    NSArray<NSString *> *arrTitle = @[@"热门", @"手机红人", @"附近", @"好声音", @"舞蹈", @"搞笑", @"唠嗑", @"男神"];
    self.viewTopTitle.arrTitle = arrTitle;
    [self.headerBar addSubview:self.viewTopTitle];
    
    UIColor *colorBg = [[UIColor colorWithHex:0xdd0000] colorWithAlphaComponent:0.9];
    self.headerBar.backgroundColor = colorBg;
    self.customStatusBar.backgroundColor = colorBg;
    
    // right header btn
    SIXThreeLineAnimationButton *btnAnimation = [[SIXThreeLineAnimationButton alloc] initWithFrame:self.headerBar.btnRight.frame];
    [self setHeaderRightButtonWith:btnAnimation];
    // left header btn
    [self.headerBar.btnLeft setImage:[UIImage imageNamed:@"home_button_search_normal"] forState:UIControlStateNormal];
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

    // 默认将“热门”添加到第一页
    SIXHotTopicListViewController *hotTopicVC = [[SIXHotTopicListViewController alloc] initWithParams:dicParamsHot];
    hotTopicVC.view.frame = CGRectMake(0, 0, SIX_SCREEN_WIDTH, SIX_SCREEN_HEIGHT);
    [self.scrollView addSubview:hotTopicVC.view];
    [self addChildViewController:hotTopicVC];
    self.hotTopicViewController = hotTopicVC;
    
    CGFloat contentWidth = self.arrDicParams.count * LOBBY_SCROLLVIEW_WIDTH;
    self.scrollView.contentSize = CGSizeMake(contentWidth, SIX_TABBAR_HEIGHT);
}



#pragma -mark 
#pragma -mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat offsetX = scrollView.contentOffset.x;
//    NSLog(@"offsetX : %f", offsetX);
    
    self.viewTopTitle.contentOffset = scrollView.contentOffset;
    self.viewTopTitle.userInteractionEnabled = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSUInteger index = scrollView.contentOffset.x/LOBBY_SCROLLVIEW_WIDTH;
//    DLog(@"index : %lu  %s",index,  __func__);
    [self addSubListViewToScrollViewAtIndex:index];
    self.viewTopTitle.currentIndex = index;
    self.viewTopTitle.userInteractionEnabled = YES;
}
// decelerate is true if it will continue moving afterwards
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (NO == decelerate) {
//        NSLog(@"放的正好");
        [self scrollViewDidEndDecelerating:scrollView];
    }
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
    UIView *viewOfIndex = nil;
    switch (index) {
        case EnumLiveListTypeHot:   { // 热门
            viewOfIndex = self.hotTopicViewController.view;
            break;
        } 
        case EnumLiveListTypeRed:   { // 手机红人
            viewOfIndex = self.redViewController.view;
            break;
        } 
        case EnumLiveListTypeLocal: { // 附近
            viewOfIndex = self.localViewController.view;
            break;
        } 
        case EnumLiveListTypeSound: { // 好声音
            viewOfIndex = self.soundViewController.view; 
            break;
        } 
        case EnumLiveListTypeDance: { // 舞蹈
            viewOfIndex = self.danceViewController.view;
            break;
        } 
        case EnumLiveListTypeFunny: { // 搞笑
            viewOfIndex = self.funnyViewController.view;
            break;
        } 
        case EnumLiveListTypeChat:  { // 唠嗑
            viewOfIndex = self.chatViewController.view;
            break;
        } 
        case EnumLiveListTypeMale:  { // 男神
            viewOfIndex = self.maleViewController.view;
            break;
        } 
    }
    
    if (viewOfIndex.superview != self.scrollView) {
        [self.scrollView addSubview:viewOfIndex];
    }
}





#pragma -mark 
#pragma -mark  SIXNavigationBarDelegate methods
- (void)headerLeftButtonClicked {
    DLog(@"点击搜索");
}
- (void)headerRightButtonClicked {
    self.headerBar.btnRight.hidden = YES;
//    DLog(@"%s", __func__);
    
    NSUInteger index = self.scrollView.contentOffset.x / self.scrollView.width;
    // 设置“好声音” 界面的 具体类型
    if ( EnumLiveListTypeSound == index ) {
        self.selectTypeViewController.typeOfSound = self.soundViewController.dicParams[@"type"];
    } else {
        self.selectTypeViewController.typeOfSound = nil;
    }
    // 设置当前选中控制器 的类型
    self.selectTypeViewController.currentIndex = index;

    // 添加 view，设置动画
    [self.view addSubview:self.selectTypeViewController.view];
    SIXCollectionView *collectionView = self.selectTypeViewController.collectionView;
    collectionView.height = 0;
    
    [self.selectTypeViewController.btnRightHeader startAnimation];
    collectionView.alpha = 0.7;

    [UIView animateWithDuration:0.16 animations:^{
        collectionView.height = [self.selectTypeViewController collectionViewHeight];
        collectionView.alpha = 1;
        self.selectTypeViewController.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.25];
    } completion:^(BOOL finished) {
    }];
}



#pragma -mark 
#pragma -mark SIXTitleListViewDelagate
- (void)titleListView:(SIXTitleListView *)titleListView didClickedAtIndex:(NSUInteger)index {
    self.scrollView.contentOffset = CGPointMake(index * LOBBY_SCROLLVIEW_WIDTH, 0);
    
//    CGRect rect = self.scrollView.bounds;
//    rect.origin.x = index * rect.size.width;
//    [self.scrollView scrollRectToVisible:rect animated:YES];
    
    [self scrollViewDidEndDecelerating:self.scrollView];
}

#pragma -mark 
#pragma -mark SIXSelectTypeViewControllerDelegate
/**
 * 点击 section 0，选择 某个 分类类型
 */
- (void)selectTypeViewController:(SIXSelectTypeViewController *)viewController didSelectLiveListType:(EnumLiveListType)type {
    [self titleListView:self.viewTopTitle didClickedAtIndex:type];
}
/**
 * 点击 section 1，选中好声音的 某个具体类型
 */
- (void)selectTypeViewController:(SIXSelectTypeViewController *)viewController didSelectSoundType:(NSString *)type {
    [self titleListView:self.viewTopTitle didClickedAtIndex:EnumLiveListTypeSound];
    [self.soundViewController soundHeaderSupplementaryView:nil didClickedBtnType:type];
}

/**
 * 从父控件移除
 */
- (void)selectTypeViewControllerDidRemoveFromSuperView {
    self.headerBar.btnRight.hidden = NO;
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
        _redViewController.view.frame = CGRectMake(index * LOBBY_SCROLLVIEW_WIDTH , 0, SIX_SCREEN_WIDTH, SIX_SCREEN_HEIGHT);
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
        _localViewController.view.frame = CGRectMake(index * LOBBY_SCROLLVIEW_WIDTH, 0, SIX_SCREEN_WIDTH, SIX_SCREEN_HEIGHT);
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
        _soundViewController.view.frame = CGRectMake(index * LOBBY_SCROLLVIEW_WIDTH, 0, SIX_SCREEN_WIDTH, SIX_SCREEN_HEIGHT);
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
        _danceViewController.view.frame = CGRectMake(index * LOBBY_SCROLLVIEW_WIDTH, 0, SIX_SCREEN_WIDTH, SIX_SCREEN_HEIGHT);
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
        _funnyViewController.view.frame = CGRectMake(index * LOBBY_SCROLLVIEW_WIDTH, 0, SIX_SCREEN_WIDTH, SIX_SCREEN_HEIGHT);
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
        _chatViewController.view.frame = CGRectMake(index * LOBBY_SCROLLVIEW_WIDTH, 0, SIX_SCREEN_WIDTH, SIX_SCREEN_HEIGHT);
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
        _maleViewController.view.frame = CGRectMake(index * LOBBY_SCROLLVIEW_WIDTH, 0, SIX_SCREEN_WIDTH, SIX_SCREEN_HEIGHT);
    }
    return _maleViewController;
}


/**
 * 进入选择类型界面 VC 
 */
- (SIXSelectTypeViewController *)selectTypeViewController {
    if (!_selectTypeViewController) {
        _selectTypeViewController = [[SIXSelectTypeViewController alloc] init];
        CGRect frame = [UIScreen mainScreen].bounds;
        frame.size.height -= SIX_TABBAR_HEIGHT;
        _selectTypeViewController.view.frame = frame;
        _selectTypeViewController.delegate = self;
    }
    return _selectTypeViewController;
}


- (SIXTitleListView *)viewTopTitle {
    if (!_viewTopTitle) {
        CGFloat width = SIX_SCREEN_WIDTH - 2 * SIX_NAVIGATIONBAR_HEIGHT;
        CGRect frame = CGRectMake(SIX_NAVIGATIONBAR_HEIGHT, 12, width, 25);
        _viewTopTitle = [[SIXTitleListView alloc] initWithFrame:frame];
        _viewTopTitle.delegate = self;
        
    }
    return _viewTopTitle;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        CGRect frame = [UIScreen mainScreen].bounds;
        frame.size.width = LOBBY_SCROLLVIEW_WIDTH;
        _scrollView = [[UIScrollView alloc] initWithFrame:frame];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

@end



















