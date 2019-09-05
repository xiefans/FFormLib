//
//  ExampleViewController.m
//  FansFormFramework
//
//  Created by fans on 2019/9/4.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "ExampleSingleViewController.h"
#import <Masonry.h>
@interface ExampleSingleViewController ()

@property (nonatomic, strong) UILabel *tipTitleLb;
@property (nonatomic, strong) UILabel *showTitleLb;
@property (nonatomic, strong) UILabel *operationTitleLb;

@end

@implementation ExampleSingleViewController
@synthesize topView = _topView;
@synthesize bottomView = _bottomView;
@synthesize contentView = _contentView;
@synthesize tipLb = _tipLb;

#pragma mark - Overrides
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = [SingleModel titleWithType:self.type];
    self.tipLb.text = [SingleModel tipWithType:self.type];
    
    [self configUI];
    [self configLayout];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - Template Method
- (void)eventOfShowClick {
    self.showItem.manager.show = !self.showItem.manager.isShow;
}

- (void)eventOfEditClick {
    self.showItem.manager.edit = !self.showItem.manager.isEdit;
}

- (void)eventOfMustClick {
    self.showItem.manager.must = !self.showItem.manager.isMust;
}

- (void)eventOfCheckClick {
    __weak typeof(self)sself = self;
    BOOL res = [self.scrollItem.manager checkMustWithErrorComplete:^(__kindof FFViewManager *obj, NSString *message) {
        __strong typeof(sself)self = sself;
        if (message) {
            [self showTip:message];
        } else {
            if (obj.viewType == FFViewManagerViewTypeInput) {
                [self showTip:[NSString stringWithFormat:@"请输入%@", obj.title]];
            } else {
                [self showTip:[NSString stringWithFormat:@"请选择%@", obj.title]];
            }
        }
    }];
    
    if (res) {
        [self showJson:self.scrollItem.manager.makeJSONString];
    }
}

- (void)showJson:(NSString *)json {
    [self showTip:@"Success"];
}

- (FFView *)getSingleItem {
    return [FFView formViewWithKey:@"test"];
}

#pragma mark - Public Method
- (void)showTip:(NSString *)tip {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Tip" message:tip preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Ok"
                                              style:UIAlertActionStyleCancel
                                            handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Private Method
- (void)configUI {
    [self.view addSubview:self.tipTitleLb];
    [self.view addSubview:self.topView];
    [self.topView addSubview:self.tipLb];
    [self.view addSubview:self.showTitleLb];
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.scrollItem];
    [self.view addSubview:self.operationTitleLb];
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.showBtn];
    [self.bottomView addSubview:self.mustBtn];
    [self.bottomView addSubview:self.editBtn];
    [self.bottomView addSubview:self.checkBtn];
}

- (void)configLayout {
    
    [self.tipTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16.f);
        make.right.offset(-16.f);
        make.top.equalTo(self.mas_topLayoutGuide).offset(16.f);
        make.height.mas_greaterThanOrEqualTo(0.f);
    }];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipTitleLb.mas_bottom).offset(8.f);
        make.left.right.equalTo(self.view);
        make.height.mas_greaterThanOrEqualTo(0.f);
    }];
    
    [self.tipLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16.f);
        make.top.offset(0.f);
        make.right.offset(-16.f);
        make.bottom.offset(-16.f);
    }];
    
    [self.showTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom);
        make.left.right.equalTo(self.tipTitleLb);
        make.height.mas_greaterThanOrEqualTo(0.f);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.showTitleLb.mas_bottom).offset(8.f);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.operationTitleLb.mas_top);
    }];
    
    [self.scrollItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
    }];
    
    [self.operationTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_greaterThanOrEqualTo(0.f);
        make.left.right.equalTo(self.showTitleLb);
        make.bottom.equalTo(self.bottomView.mas_top).offset(-8.f);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.mas_bottomLayoutGuide).offset(-16.f);
        make.height.mas_equalTo(100.f);
    }];
    
    NSArray *items = @[self.showBtn, self.editBtn, self.mustBtn, self.checkBtn];
    [items mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomView);
        make.height.mas_equalTo(40.f);
    }];
    [items mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:16.f leadSpacing:16.f tailSpacing:16.f];
}

#pragma mark - Lazy Load
- (FFScrollContainerItem *)scrollItem {
    if (!_scrollItem) {
        _scrollItem = [FFScrollContainerItem formViewWithKey:@"supper"];
    }
    return _scrollItem;
}

- (__kindof FFView *)showItem {
    if (!_showItem) {
        _showItem = [self getSingleItem];
    }
    return _showItem;
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] init];
    }
    return _topView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
    }
    return _bottomView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}

- (UILabel *)tipLb {
    if (!_tipLb) {
        _tipLb = [[UILabel alloc] init];
        _tipLb.font = [UIFont systemFontOfSize:14.f];
        _tipLb.textColor = [UIColor grayColor];
        _tipLb.numberOfLines = 0;
    }
    return _tipLb;
}

- (UILabel *)tipTitleLb {
    if (!_tipTitleLb) {
        _tipTitleLb = [[UILabel alloc] init];
        _tipTitleLb.font = [UIFont systemFontOfSize:18.f weight:UIFontWeightMedium];
        _tipTitleLb.text = SingleDetailExampleTipTitle;
    }
    return _tipTitleLb;
}

- (UILabel *)showTitleLb {
    if (!_showTitleLb) {
        _showTitleLb = [[UILabel alloc] init];
        _showTitleLb.font = [UIFont systemFontOfSize:18.f weight:UIFontWeightMedium];
        _showTitleLb.text = SingleDetailExampleShowTitle;
    }
    return _showTitleLb;
}

- (UILabel *)operationTitleLb {
    if (!_operationTitleLb) {
        _operationTitleLb = [[UILabel alloc] init];
        _operationTitleLb.font = [UIFont systemFontOfSize:18.f weight:UIFontWeightMedium];
        _operationTitleLb.text = SingleDetailExampleOperationTitle;
    }
    return _operationTitleLb;
}

- (UIButton *)showBtn {
    if (!_showBtn) {
        _showBtn = [[UIButton alloc] init];
        [_showBtn setTitle:@"Show" forState:UIControlStateNormal];
        _showBtn.backgroundColor = [UIColor orangeColor];
        _showBtn.layer.cornerRadius = 5.f;
        _showBtn.layer.masksToBounds = YES;
        _showBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [_showBtn addTarget:self action:@selector(eventOfShowClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showBtn;
}

- (UIButton *)editBtn {
    if (!_editBtn) {
        _editBtn = [[UIButton alloc] init];
        [_editBtn setTitle:@"Edit" forState:UIControlStateNormal];
        _editBtn.backgroundColor = [UIColor orangeColor];
        _editBtn.layer.cornerRadius = 5.f;
        _editBtn.layer.masksToBounds = YES;
        _editBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [_editBtn addTarget:self action:@selector(eventOfEditClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editBtn;
}

- (UIButton *)mustBtn {
    if (!_mustBtn) {
        _mustBtn = [[UIButton alloc] init];
        [_mustBtn setTitle:@"Must" forState:UIControlStateNormal];
        _mustBtn.backgroundColor = [UIColor orangeColor];
        _mustBtn.layer.cornerRadius = 5.f;
        _mustBtn.layer.masksToBounds = YES;
        _mustBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [_mustBtn addTarget:self action:@selector(eventOfMustClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mustBtn;
}

- (UIButton *)checkBtn {
    if (!_checkBtn) {
        _checkBtn = [[UIButton alloc] init];
        [_checkBtn setTitle:@"Check" forState:UIControlStateNormal];
        _checkBtn.backgroundColor = [UIColor orangeColor];
        _checkBtn.layer.cornerRadius = 5.f;
        _checkBtn.layer.masksToBounds = YES;
        _checkBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [_checkBtn addTarget:self action:@selector(eventOfCheckClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkBtn;
}

@end
