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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FansFormView *baseView = [FansFormView formView];
    baseView.frame = self.view.bounds;
    baseView.backgroundColor = [UIColor orangeColor];
    
    [baseView addItem:[FansInputItem itemWithTitle:@"测试1"
                                       placeholder:@"没有"
                                            forKey:@"param1"]];
    
    [baseView addItem:[FansInputItem itemWithTitle:@"测试2"
                                       placeholder:@"没有2"
                                            forKey:@"param2"]];
    
    
    [self.view addSubview:baseView];
}


@end
