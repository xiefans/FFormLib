//
//  FansFormView.m
//  FansFormFramework
//
//  Created by fans on 2019/7/25.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FansFormView.h"
#import "FansFormTool.h"
@interface FansFormView ()

@property (nonatomic, strong) __kindof FansFormViewManager * manager;

@end

@implementation FansFormView

+ (instancetype)formViewWithKey:(NSString *)key {
    return [[self alloc] initWithKey:key];
}

+ (instancetype)formViewWithManager:(__kindof FansFormViewManager *)manager {
    return [[self alloc] initWithManager:manager];
}

- (instancetype)initWithKey:(NSString *)key {
    return [self initWithManager:[FansFormViewManager managerWithKey:key]];
}

- (instancetype)initWithManager:(__kindof FansFormViewManager *)manager {
    if (self = [super init]) {
        _manager = manager;
        
        __weak typeof(self)weakSelf = self;
        [manager setChangeEdit:^(FansFormViewManager *manager, BOOL isEdit) {
            // 改变自己的edit状态
            __strong typeof(weakSelf)self = weakSelf;
            
            [self changeEdit:isEdit];
        }];
        
        [manager setChangeMust:^(FansFormViewManager *manager, BOOL isMust) {
            // 改变自己的必填状态
            __strong typeof(weakSelf)self = weakSelf;
            
            [self changeMust:isMust];
        }];
        
        [manager setChangeShow:^(FansFormViewManager *manager, BOOL isShow) {
            // 改变自己的显示状态
            __strong typeof(weakSelf)self = weakSelf;
            
            [self changeShow:isShow];
        }];
    }
    return self;
}

- (NSString *)key {
    return _manager.key;
}

- (void)reloadLayout {
    [_manager excuteRefreshBlock];
}

- (void)changeEdit:(BOOL)isEdit {
    
    if (isEdit) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = _changeTempBackgroundColor;
    } else {
        self.userInteractionEnabled = NO;
        _changeTempBackgroundColor = self.backgroundColor;
        self.backgroundColor = [UIColor fans_colorWithHexValue:0xeeeeee];
    }
    
//    NSLog(@"%@ changeEdit Fail. because the class not implement", self.class);
}

- (void)changeShow:(BOOL)isShow {
    
    if (isShow) {
        self.hidden = NO;
    } else {
        self.hidden = YES;
    }
//    NSLog(@"%@ changeShow Fail. because the class not implement", self.class);
}

- (void)changeMust:(BOOL)isMust {
    NSLog(@"%@ changeMust Fail. because the class not implement", self.class);
}

- (void)setShow:(BOOL)show {
    _manager.show = show;
}

- (BOOL)isShow {
    return _manager.isShow;
}

- (void)setMust:(BOOL)must {
    _manager.must = must;
}

- (BOOL)isMust {
    return _manager.isMust;
}

- (void)setEdit:(BOOL)edit {
    _manager.edit = edit;
}

- (BOOL)isEdit {
    return _manager.isEdit;
}


- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
}

- (void)setSize:(CGSize)size {
    _size = size;
    
    [super setFrame:CGRectMake(
                               self.frame.origin.x,
                               self.frame.origin.y,
                               size.width,
                               size.height
                               )];
}

@end
