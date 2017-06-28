//
//  SIXCommonListViewController.h
//  sixLive
//
//  Created by li’Pro on 2017/6/28.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXViewController.h"
#import "SIXCollectionViewListLayout.h"
#import "SIXListCollectionViewCell.h"


/// 默认 URL 为 /coop/mobile/index.php，外界只需传入 params
@interface SIXCommonListViewController : SIXViewController<UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) NSDictionary *params;

- (instancetype)initWithParams:(NSDictionary *)params ;

@end
