//
//  ScrollContainerViewController.m
//  FansFormFramework
//
//  Created by fans on 2019/9/4.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "ScrollContainerViewController.h"

static NSString * const NAME_KEY = @"name";
static NSString * const PHONE_KEY = @"phone";
static NSString * const ADDRESS_KEY = @"address";
static NSString * const RECEIPT_KEY = @"receipt";

@interface ScrollContainerViewController ()

@end

@implementation ScrollContainerViewController

#pragma mark - Overrides
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.mustBtn setTitle:@"layout" forState:UIControlStateNormal];
    [self addUI];
    [self configFormat];
}

#pragma mark - Private Method
- (void)addUI {
    [self.scrollItem ff_addItem:[FFInputSingleItem inputWithKey:NAME_KEY
                                                          title:@"名称"
                                                    placeholder:@"请输入名称(3-6)"
                                                           must:YES]];
    
    FFInputSingleItem *phoneItem = [FFInputSingleItem inputWithKey:PHONE_KEY
                                                             title:@"手机号"
                                                       placeholder:@"请输入手机号"
                                                              must:YES];
    phoneItem.textField.keyboardType = UIKeyboardTypePhonePad;
    [self.scrollItem ff_addItem:phoneItem];
    
    __weak typeof(self)sself = self;
    [self.scrollItem ff_addItem:[FFSelectItem actionWithTitle:@"开票"
                                                  placeholder:@"请选择是否开票"
                                                         must:NO
                                                          key:RECEIPT_KEY
                                                    didAction:^(__kindof FFSelectItem *actionView) {
        [sself eventOfSelectReceiptWithItem:actionView];
    }]];
    
    [self.scrollItem ff_addItem:[FFFixHeightInputItem inputWithKey:ADDRESS_KEY
                                                             title:@"收货地址"
                                                       placeholder:@"请输入地址"
                                                         fixHeight:150.f
                                                              must:YES]];
}

- (void)configFormat {
    [self.scrollItem.manager addFormatCheck:[FFFormcatSpecificCheck formcatCheckWithCheckType:FFFormcatSpecificCheckTypeMobilePhone]
                                     forKey:PHONE_KEY];
    [self.scrollItem.manager addFormatCheck:[FFFormatLengthCheck formatCheckWithMinLength:3 maxLength:6]
                                     forKey:NAME_KEY];
}

#pragma mark - Actions
- (void)eventOfSelectReceiptWithItem:(FFSelectItem *)selectItem {
    
    FFViewManager *manager = selectItem.manager;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Tip" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"需要" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        manager.value = @"1";
        manager.content = @"需要";
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"不需要" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        manager.value = @"0";
        manager.content = @"不需要";
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Overrides Template Method
- (void)eventOfShowClick {
    self.scrollItem.manager.show = !self.scrollItem.manager.isShow;
}

- (void)eventOfEditClick {
    self.scrollItem.manager.edit = !self.scrollItem.manager.isEdit;
}

- (void)eventOfMustClick {
    
    if (self.scrollItem.layoutDirection == FFContainerViewLayoutDirectionVertical) {
        self.scrollItem.layoutDirection = FFContainerViewLayoutDirectionHorizontal;
    } else {
        self.scrollItem.layoutDirection = FFContainerViewLayoutDirectionVertical;
    }
}

- (void)showJson:(NSString *)json {
    [self showTip:json];
}

@end
