//
//  SingleInputViewController.m
//  FansFormFramework
//
//  Created by fans on 2019/9/4.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "SingleInputViewController.h"

@interface SingleInputViewController ()

@end

@implementation SingleInputViewController

#pragma mark - Overrides
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.scrollItem ff_addItem:self.showItem];
    // 设置格式校验
    [self.scrollItem.manager addFormatCheck:[FFFormatLengthCheck formatCheckWithMinLength:6 maxLength:11] forKey:@"test"];
}

#pragma mark - Overrides Template Method
- (FFView *)getSingleItem {
    return [FFInputSingleItem inputWithKey:@"test"
                                     title:@"名称"
                               placeholder:@"请输入名称"
                                      must:YES];
}

@end
