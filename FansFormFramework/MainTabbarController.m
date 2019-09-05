//
//  MainTabbarController.m
//  FansFormFramework
//
//  Created by fans on 2019/9/5.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "MainTabbarController.h"
#import "ViewController.h"

@interface MainTabbarController ()

@property (nonatomic, strong) UIViewController *singleVC;

@end

@implementation MainTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewControllers = @[self.singleVC];
}

- (UIViewController *)singleVC {
    if (!_singleVC) {
        ViewController *vc = [[ViewController alloc] init];
        vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:nil tag:0];
        _singleVC = [[UINavigationController alloc] initWithRootViewController:vc];
    }
    return _singleVC;
}

@end
