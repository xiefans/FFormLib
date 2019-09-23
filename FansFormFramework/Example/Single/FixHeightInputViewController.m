//
//  FixHeightInputViewController.m
//  FansFormFramework
//
//  Created by fans on 2019/9/4.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FixHeightInputViewController.h"
#import "FFCore.h"
#import <Masonry.h>

@interface FixHeightInputViewController ()

@end

@implementation FixHeightInputViewController

#pragma mark - Overrides
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.scrollItem ff_addItem:self.showItem];
    
    // 设置格式校验
    [self.scrollItem.manager addFormatCheck:[FFFormatLengthCheck formatCheckWithMaxLength:20] forKey:@"test"];
}

#pragma mark - Overrides Template Method
- (FFView *)getSingleItem {
    return [FFFixHeightInputItem inputWithKey:@"test"
                                        title:@"地址"
                                  placeholder:@"请输入地址"
                                    fixHeight:150.f
                                         must:YES];
}

@end
