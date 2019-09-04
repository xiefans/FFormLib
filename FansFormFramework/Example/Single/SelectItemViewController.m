//
//  SelectItemViewController.m
//  FansFormFramework
//
//  Created by fans on 2019/9/4.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "SelectItemViewController.h"
#import "FFCore.h"
#import <Masonry.h>

@interface SelectItemViewController ()

@end

@implementation SelectItemViewController


#pragma mark - Overrides
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.scrollItem ff_addItem:self.showItem];
    
    // 设置格式校验
    [self.scrollItem.manager addFormatCheck:[FFFormatLengthCheck formatCheckWithMaxLength:100] forKey:@"test"];
}

#pragma mark - Overrides Template Method
- (FFView *)getSingleItem {
    __weak typeof(self)sself = self;
    return [FFSelectItem formViewWithTitle:@"性别"
                               placeholder:@"请选择性别"
                                      must:YES
                                       key:@"test"
                                 didAction:^(__kindof FFActionView *actionView){
                                     
                                     [sself eventOfSelectForManager:actionView.manager];
                                 }];
}

#pragma mark - Actions
- (void)eventOfSelectForManager:(FFViewManager *)manager {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Sex"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        manager.content = @"男";
        manager.value = @"男";
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        manager.content = @"女";
        manager.value = @"女";
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}


@end
