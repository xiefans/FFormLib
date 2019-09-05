//
//  AutoHeightContainerViewController.m
//  FansFormFramework
//
//  Created by fans on 2019/9/5.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "AutoHeightContainerViewController.h"

static NSString * const NAME_KEY = @"name";
static NSString * const PHONE_KEY = @"phone";
static NSString * const ADDRESS_KEY = @"address";
static NSString * const RECEIPT_KEY = @"receipt";

@interface AutoHeightContainerViewController ()

@end

@implementation AutoHeightContainerViewController


#pragma mark - Overrides
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.mustBtn setTitle:@"layout" forState:UIControlStateNormal];
    [self addUI];
    [self configFormat];
}

- (FFView *)getSingleItem {
    return [FFAutoHeightContainerItem formViewWithKey:@"test" layoutDirection:FFContainerViewLayoutDirectionVertical];
}

#pragma mark - Private Method
- (void)addUI {
    [self.scrollItem ff_addItem:self.showItem];
    [self.showItem ff_addItem:[FFAutoHeightInputItem formViewWithKey:NAME_KEY
                                                               title:@"名称"
                                                         placeholder:@"请输入名称(3-6)"
                                                                must:YES]];
    [self.showItem ff_addItem:[FFAutoHeightInputItem formViewWithKey:@"dz"
                                                               title:@"对照"
                                                         placeholder:@"我在autoHeight中"
                                                                must:NO]];
    
    FFInputSingleItem *phoneItem = [FFInputSingleItem formViewWithKey:PHONE_KEY
                                                                title:@"手机号"
                                                          placeholder:@"请输入手机号"
                                                                 must:YES];
    phoneItem.textField.keyboardType = UIKeyboardTypePhonePad;
    [self.scrollItem ff_addItem:phoneItem];
    
    __weak typeof(self)sself = self;
    [self.scrollItem ff_addItem:[FFSelectItem formViewWithTitle:@"开票"
                                                    placeholder:@"请选择是否开票"
                                                           must:NO
                                                            key:RECEIPT_KEY
                                                      didAction:^(__kindof FFSelectItem *actionView) {
                                                          [sself eventOfSelectReceiptWithItem:actionView];
                                                      }]];
    
    [self.scrollItem ff_addItem:[FFFixHeightInputItem formViewWithKey:ADDRESS_KEY
                                                                title:@"收货地址"
                                                          placeholder:@"请输入地址"
                                                            fixHeight:150.f
                                                                 must:YES]];
    
}

- (void)configFormat {
    [self.scrollItem.manager addFormatCheck:[FFFormcatSpecificCheck formcatCheckWithCheckType:FFFormcatSpecificCheckTypeMobilePhone]
                                     forKey:PHONE_KEY];
    [self.showItem.manager addFormatCheck:[FFFormatLengthCheck formatCheckWithMinLength:3 maxLength:6]
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
- (void)eventOfMustClick {
    FFContainerView *view = self.showItem;
    if (view.layoutDirection == FFContainerViewLayoutDirectionVertical) {
        [view.ff_allItem enumerateObjectsUsingBlock:^(__kindof FFView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.size = CGSizeMake(FFScreenWidth / 2, obj.size.height);
        }];
        view.layoutDirection = FFContainerViewLayoutDirectionHorizontal;
    } else {
        
        [view.ff_allItem enumerateObjectsUsingBlock:^(__kindof FFView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.size = CGSizeMake(FFScreenWidth, obj.size.height);
        }];
        view.layoutDirection = FFContainerViewLayoutDirectionVertical;
    }
    
    [self.scrollItem reloadLayout];
}

- (void)showJson:(NSString *)json {
    [self showTip:json];
}


@end
