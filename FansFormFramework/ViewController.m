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

@property (nonatomic, strong) FansFormManager *formManager;

@end

@implementation ViewController

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

    CGRect layoutFrame = self.view.safeAreaLayoutGuide.layoutFrame;
    FansFormManager *manage = self.view.fans_subItem;
    manage.contentView.frame = layoutFrame;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"好的";
    self.view.backgroundColor = [UIColor whiteColor];
    
    FansFormManager *formManager = [[FansFormManager alloc] initWithKey:@"jsonform"];
    formManager.package = YES;
    [formManager addSubItem:[FansInputItem itemWithTitle:@"测试1"
                                       placeholder:@"没有"
                                            forKey:@"param1"].changeToMust];
    
    [formManager addSubItem:[FansInputItem itemWithTitle:@"测试2"
                                       placeholder:@"没有2"
                                            forKey:@"param2"]];
    
    [formManager addSubItem:[FansInputItem itemWithTitle:@"测试3"
                                       placeholder:@"没有3"
                                            forKey:@"param3"]];
    
    [self.view fans_addSubItem:formManager];
    
    [formManager.contentView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(action)]];
    
}

- (void)action {
    NSLog(@"dict :%@ \n json : %@",self.view.fans_subItem.makeDictionary,self.view.fans_subItem.makeJSONString);
    
    FansFormManager *manager = self.view.fans_subItem;
    
    if ([manager itemForKey:@"param1"].isShow) {
        [manager itemForKey:@"param1"].show = NO;
    } else {
        [manager itemForKey:@"param1"].show = YES;
    }
}


@end
