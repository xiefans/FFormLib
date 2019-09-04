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

@property (nonatomic, strong) FFScrollContainerItem *scrollItem;

@end

@implementation AutoHeightInputViewController

#pragma mark - Overrides
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.contentView addSubview:self.scrollItem];
    [self.scrollItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
    }];
    
    [self.scrollItem ff_addItem:[FFAutoHeightInputItem formViewWithKey:@"test"
                                                                 title:@"备注"
                                                           placeholder:@"请输入备注"
                                                                  must:YES]];
    // 设置格式校验
    [self.scrollItem.manager addFormatCheck:[FFFormatLengthCheck formatCheckWithMaxLength:100] forKey:@"test"];
}

#pragma mark - Overrides Template Method
- (void)eventOfShowClick {
    FFInputSingleItem *item = [self.scrollItem ff_itemForKey:@"test"];
    item.manager.show = !item.manager.isShow;
}

- (void)eventOfEditClick {
    FFInputSingleItem *item = [self.scrollItem ff_itemForKey:@"test"];
    item.manager.edit = !item.manager.isEdit;
}

- (void)eventOfMustClick {
    FFInputSingleItem *item = [self.scrollItem ff_itemForKey:@"test"];
    item.manager.must = !item.manager.isMust;
}

- (void)eventOfCheckClick {
    __weak typeof(self)sself = self;
    BOOL res = [self.scrollItem.manager checkMustWithErrorComplete:^(__kindof FFViewManager *obj, NSString *message) {
        __strong typeof(sself)self = sself;
        if (message) {
            [self showTip:message];
        } else {
            [self showTip:[NSString stringWithFormat:@"请输入%@", obj.title]];
        }
    }];
    
    if (res) {
        [self showTip:@"Success"];
    }
}

#pragma mark - Lazy Load
- (FFScrollContainerItem *)scrollItem {
    if (!_scrollItem) {
        _scrollItem = [FFScrollContainerItem formViewWithKey:@"supper"];
    }
    return _scrollItem;
}

@end
