//
//  ScrollContainerViewController.m
//  FansFormFramework
//
//  Created by fans on 2019/9/4.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "ScrollContainerViewController.h"

static NSString * const NAME_KEY = @"name";
static NSString * const ADDRESS_KEY = @"address";

@interface ScrollContainerViewController ()

@end

@implementation ScrollContainerViewController

#pragma mark - Overrides
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addUI];
}

#pragma mark - Private Method
- (void)addUI {
    [self.scrollItem ff_addItem:[FFInputSingleItem formViewWithKey:NAME_KEY
                                                             title:@"名称"
                                                       placeholder:@"请输入名称"
                                                              must:YES]];
    [self.scrollItem ff_addItem:[FFFixHeightInputItem formViewWithKey:ADDRESS_KEY
                                                                title:@"收货地址"
                                                          placeholder:@"请输入地址"
                                                            fixHeight:150.f
                                                                 must:YES]];
}

#pragma mark - Overrides Template Method
- (void)eventOfShowClick {
    self.scrollItem.manager.show = !self.scrollItem.manager.isShow;
}

- (void)eventOfEditClick {
    self.scrollItem.manager.edit = !self.scrollItem.manager.isEdit;
}

- (void)eventOfMustClick {
    [self showTip:@"容器视图不能设置必填和非必填\n"];
}

@end
