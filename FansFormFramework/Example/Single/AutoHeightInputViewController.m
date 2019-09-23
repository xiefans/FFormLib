//
//  AutoHeightInputViewController.m
//  FansFormFramework
//
//  Created by fans on 2019/9/4.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "AutoHeightInputViewController.h"
#import "FFCore.h"
#import <Masonry.h>

@interface AutoHeightInputViewController ()

@end

@implementation AutoHeightInputViewController

#pragma mark - Overrides
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.scrollItem ff_addItem:self.showItem];
    // 设置格式校验
    [self.scrollItem.manager addFormatCheck:[FFFormatLengthCheck formatCheckWithMaxLength:100] forKey:@"test"];
}

#pragma mark - Overrides Template Method
- (FFView *)getSingleItem {
    return [FFAutoHeightInputItem inputWithKey:@"test"
                                         title:@"备注"
                                   placeholder:@"请输入备注"
                                          must:YES];
}

@end
