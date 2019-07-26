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
    
    [_formView addSubview:[FansFormInputView formViewWithKey:@"1"]];
    [_formView addSubview:[FansFormInputView formViewWithKey:@"2"]];
    
    [_formView subviewForKey:@"1"].backgroundColor = [UIColor redColor];
    [_formView subviewForKey:@"2"].backgroundColor = [UIColor blueColor];
    [_formView subviewForKey:@"1"].marginInsets = UIEdgeInsetsMake(0, 10, 50, 10);
    [_formView subviewForKey:@"1"].size = CGSizeMake(FANSScreenWidth, 0);
    
    [self.view addSubview:self.formView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    NSLog(@"%@",_formView.manager.makeJSONString);
    FansFormView *formView = [_formView subviewForKey:@"1"];
    formView.edit = !formView.isEdit;
    
}

@end
