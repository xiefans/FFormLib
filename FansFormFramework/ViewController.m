//
//  ViewController.m
//  FFFramework
//
//  Created by fans on 2019/7/22.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "ViewController.h"
#import "SingleModel.h"
#import "FFTool.h"
#import <Masonry.h>

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) UILabel *coryrightLb;

@end

@implementation ViewController

#pragma mark - Overrides
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = FrameworkName;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configData];
    
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.coryrightLb];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide);
        make.left.right.bottom.equalTo(self.view);
    }];
}

#pragma mark - Private Method
- (void)configData {
    NSMutableArray *temp = [NSMutableArray new];
    
    for (SingleModelType type = SingleModelTypeSignleInput; type <= SingleModelTypeAutoHeightContainer; type ++) {
        SingleModel *model = [[SingleModel alloc] initWithType:type];
        [temp addObject:model];
    }
    
    self.dataSource = [temp copy];
}

#pragma mark - Protocol
#pragma mark <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.detailTextLabel.numberOfLines = 0;
    }
    
    SingleModel *model = self.dataSource[indexPath.row];
    
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = model.subTitle;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (!headerView) {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"header"];
        headerView.textLabel.numberOfLines = 0;
    }
    headerView.textLabel.text = @"【tip】所有非容器视图都要添加在容器视图中才可以使用";
    
    return headerView;
}

#pragma mark <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SingleModel *model = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:model.controller animated:YES];
}

#pragma mark - Lazy Load
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UILabel *)coryrightLb {
    if (!_coryrightLb) {
        _coryrightLb = [[UILabel alloc] initWithFrame:CGRectMake(0.f, -30.f, FFScreenWidth, 30.f)];
        _coryrightLb.textColor = [UIColor grayColor];
        _coryrightLb.textAlignment = NSTextAlignmentCenter;
        _coryrightLb.font = [UIFont systemFontOfSize:15.f];
        _coryrightLb.text = Copyright;
    }
    return _coryrightLb;
}

@end
