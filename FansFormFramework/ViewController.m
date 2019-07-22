//
//  ViewController.m
//  FansFormFramework
//
//  Created by fans on 2019/7/22.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "ViewController.h"
#import "FansFormCore.h"
#import "FansFormSupportItem.h"

@interface ViewController ()

@property (nonatomic, strong) FansFormView *baseView;

@end

@implementation ViewController

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

    CGRect layoutFrame = self.view.safeAreaLayoutGuide.layoutFrame;
    _baseView.frame = layoutFrame;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"好的";
    self.view.backgroundColor = [UIColor whiteColor];
    
    FansFormView *baseView = [FansFormView formViewWithDirection:FansFormContainerArrangeVerticalDirection];
    
    [baseView addItem:[FansInputItem itemWithTitle:@"测试1"
                                       placeholder:@"没有"
                                            forKey:@"param1"].changeToMust];
    
    [baseView addItem:[FansInputItem itemWithTitle:@"测试2"
                                       placeholder:@"没有2"
                                            forKey:@"param2"]];
    
    [baseView addItem:[FansInputItem itemWithTitle:@"测试3"
                                       placeholder:@"没有3"
                                            forKey:@"param3"]];
    
    
    [self.view addSubview:baseView];
    
    [baseView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(action)]];
    
    _baseView = baseView;
}

- (void)action {
    NSLog(@"dict :%@ \n json : %@",_baseView.toDictionary,_baseView.toJSONString);
}


@end
