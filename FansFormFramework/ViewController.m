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
    
    [self.view addSubview:self.formView];
}

@end
