//
//  ViewController.m
//  FansFormFramework
//
//  Created by fans on 2019/7/22.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "ViewController.h"
#import "FansFormCore.h"
#import "FansFormTool.h"

@interface ViewController ()

@property (nonatomic, strong) FansFormContainerView *formView;

@property (nonatomic, strong) UIButton *checkBtn;

@end

@implementation ViewController

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

    CGRect layoutFrame = self.view.safeAreaLayoutGuide.layoutFrame;
    self.formView.frame = layoutFrame;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"好的";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _formView = [FansFormContainerView formViewWithKey:@"jsonform"];
    
    [_formView addSubview:[FFInputView formViewWithKey:@"1"
                                                       title:@"名称："
                                                 placeholder:@"请输入名称"
                                                        must:YES]];
    [_formView addSubview:[FFFixHeightInputItem formViewWithKey:@"3"
                                                       title:@"名称3："
                                                 placeholder:@"请输入名称3"
                                                      fixHeight:100.f
                                                        must:YES]];
    
    [_formView addSubview:[FFAutoHeightInputItem formViewWithKey:@"2"
                                                       title:@"性别："
                                                 placeholder:@"请输入性别"
                                                        must:YES]];
    
    [_formView addSubview:[FFInputView formViewWithKey:@"3"
                                                       title:@"名称3："
                                                 placeholder:@"请输入名称3"
                                                        must:NO]];
    
    
    
    //这里测试递归检查
    FansFormContainerView *temp = [FansFormContainerView formViewWithKey:@"jjj2"];
    temp.size = CGSizeMake(0.f, 120.f);
    [temp addSubview:[FFInputView formViewWithKey:@"jj1"
                                            title:@"组中1："
                                      placeholder:@"请输入组中1"
                                             must:NO]];
    [temp addSubview:[FFInputView formViewWithKey:@"jj2"
                                            title:@"组中2："
                                      placeholder:@"请输入组中2"
                                             must:YES]];
    [_formView addSubview:temp];
    [self.view addSubview:self.formView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.checkBtn];
}

- (void)eventOfCheck {
    //检查必填项
    FansFormViewManager *manager = FansMagicCheckMust(self.formView.manager);
    
    NSLog(@"%@",manager);
}

- (UIButton *)checkBtn {
    if (!_checkBtn) {
        _checkBtn = [[UIButton alloc] init];
        [_checkBtn setTitle:@"check" forState:UIControlStateNormal];
        [_checkBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_checkBtn addTarget:self action:@selector(eventOfCheck) forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkBtn;
}

@end
