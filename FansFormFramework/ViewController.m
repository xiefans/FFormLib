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

    _formView.paddingInsets = UIEdgeInsetsMake(15, 5, 5, 5);
    
    [_formView addSubview:[FansFormInputView formViewWithKey:@"1"
                                                       title:@"名称："
                                                 placeholder:@"请输入名称"
                                                        must:NO]];
    [_formView addSubview:[FansFormInputView formViewWithKey:@"2"
                                                       title:@"性别："
                                                 placeholder:@"请输入性别"
                                                        must:NO]];
    
    [self.view addSubview:self.formView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"%@",_formView.manager.makeJSONString);
    FansFormView *formView = [_formView subviewForKey:@"1"];
    formView.edit = !formView.isEdit;
    
}

@end
