//
//  SIXProvinceListViewController.m
//  sixLive
//
//  Created by li’Pro on 2017/6/29.
//  Copyright © 2017年 li’Pro. All rights reserved.
//

#import "SIXProvinceListViewController.h"
#import "SIXLocalContent.h"
#import "SIXProvinceCell.h"

NSString *const CellReuseID = @"SIXProvinceListViewController.h";

@interface SIXProvinceListViewController ()<UITableViewDelegate, UITableViewDataSource>
/** UI */
@property (strong, nonatomic) UILabel *lblTopLine;

@property (copy, nonatomic) NSArray<SIXProvince *> *arrProvince;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation SIXProvinceListViewController

- (instancetype)initWithProvinceArray:(NSArray<SIXProvince *> *)arrProvince {
    if (self = [super init]) {
        self.arrProvince = arrProvince;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpHeaderBar];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.lblTopLine];
}

- (void)setUpHeaderBar {
    self.headerBar.hidden = YES;
    self.customStatusBar.hidden = YES;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.lblTopLine.frame = CGRectMake(10, 0, SIX_SCREEN_WIDTH - 20, 0.5);
    self.tableView.frame = self.view.bounds;
}




#pragma -mark 
#pragma -mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrProvince.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SIXProvince *province = self.arrProvince[indexPath.row];
    
    SIXProvinceCell *cell = [tableView dequeueReusableCellWithIdentifier:CellReuseID];
    
    cell.province = province;
    cell.current = [province.pid isEqualToString:self.currentPId];
    
    
    return cell;
}
#pragma -mark 
#pragma -mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SIXProvince *province = self.arrProvince[indexPath.row];
    self.currentPId = province.pid;
//    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [tableView reloadData];
    
    if (self.blockRowClicked) {
        self.blockRowClicked(province);
    }
}


#pragma -mark 
#pragma -mark getters
- (UILabel *)lblTopLine {
    if (!_lblTopLine) {
        _lblTopLine = [[UILabel alloc] init];
        _lblTopLine.backgroundColor = [UIColor colorWithHex:0xcccccc];
    }
    return _lblTopLine;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[SIXProvinceCell class] forCellReuseIdentifier:CellReuseID];
        
        _tableView.rowHeight = 54.;
        _tableView.separatorColor = [UIColor colorWithHex:0xcccccc];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _tableView;
}



@end

























