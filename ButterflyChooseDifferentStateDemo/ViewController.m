//
//  ViewController.m
//  ButterflyChooseDifferentStateDemo
//
//  Created by XiangTaiMini on 2017/2/23.
//  Copyright © 2017年 Butterfly. All rights reserved.
//

#import "ViewController.h"
#import "ButterflyStateHeaderView.h"

@interface ViewController ()<UITableViewDelegate , UITableViewDataSource , ButterflyStateHeaderViewDelegate>

@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic, nullable, strong) ButterflyStateHeaderView *headerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.headerView];
}

#pragma mark - ButterflyStateHeaderViewDelegate
-(void)butterflyStateHeaderViewItemSelectIndex:(NSInteger)index {
//    NSLog(@"+++ %ld",(long)index);
}

#pragma mark - UITableViewDataSource/UITableViewDelegate 
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = @"蝴蝶";
    return cell;
}

#pragma mark - Getter Method
-(UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, Screen_Width, Screen_Height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

-(ButterflyStateHeaderView *)headerView {
    
//    NSArray *states = @[@"未使用",@"已使用",@"已过期"];
    NSArray *titleArray = @[@"全部",@"待付款",@"待确认",@"待出游",@"退款中",@"待评价",@"待晒单"];
    if (!_headerView) {
        _headerView = [[ButterflyStateHeaderView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 50)];
        _headerView.backgroundColor = [UIColor whiteColor];
        _headerView.delegate = self;
        _headerView.titles = titleArray;
        _headerView.fontSize = 15;
        _headerView.rowMaxCount = 5;
//        _headerView.defaultTitleColor = [UIColor blackColor];
//        _headerView.selectTitleColor = [UIColor greenColor];
//        _headerView.bottomSlideViewColor = [UIColor greenColor];
    }
    return _headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
