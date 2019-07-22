//
//  FansFormView.m
//  FansFormFramework
//
//  Created by fans on 2019/7/22.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FansFormView.h"
#import "FansFormTool.h"
#import "FansFormManager.h"
@interface FansFormView ()

@property (nonatomic, strong) id<FansFormManagerInterface> manager;
@property (nonatomic, strong) NSMutableArray *layoutItems;

@end

@implementation FansFormView

#pragma mark - Overrides
- (void)layoutSubviews {
    
    __weak typeof(self)weakSelf = self;
    __block UIView *lastView = nil;
    [_layoutItems enumerateObjectsUsingBlock:^(id<FansFormItemInterface>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        __strong typeof(weakSelf)self = weakSelf;
        
        UIView<FansFormItemViewInterface> *itemView = obj.contentView;
        
        if (!itemView.superview) {
            [self addSubview:itemView];
        }
        
        itemView.frame = CGRectMake(0, lastView.fans_bottom, self.fans_width, itemView.getLayoutSize.height);
        
        lastView = itemView;
    }];
}


#pragma mark - Public Method

+ (instancetype)formView {
    return [[self alloc] initWithManager:[FansFormManager new]];
}

- (instancetype)initWithManager:(id<FansFormManagerInterface>)manager {
    if (self = [super init]) {
        _manager = manager;
        [self initTool];
    }
    return self;
}

- (void)initTool {
    _layoutItems = [NSMutableArray new];
}

#pragma mark - Protocol
#pragma mark <FansFormContainerInterface>
+ (instancetype)containerWithManager:(id<FansFormManagerInterface>)manager {
    return [[self alloc] initWithManager:manager];
}

- (void)addItem:(id<FansFormItemInterface>)item {
    [_manager addItem:item];
    
    [_layoutItems addObject:item];
}

#pragma mark <FansFormManagerInterface>
- (id<FansFormItemInterface>)itemForKey:(NSString *)key {
    return [_manager itemForKey:key];
}

- (void)setShowContent:(NSString *)content forItemKey:(NSString *)itemKey {
    [_manager setShowContent:content forItemKey:itemKey];
}

- (NSString *)showContentForItemkey:(NSString *)itemKey {
    return [_manager showContentForItemkey:itemKey];
}

- (void)setRequestContent:(NSString *)requestContent forItemkey:(NSString *)itemKey {
    [_manager setRequestContent:requestContent forItemkey:itemKey];
}

- (NSString *)requestContentForItemkey:(NSString *)itemKey {
    return [_manager requestContentForItemkey:itemKey];
}

- (void)addParam:(id)param key:(NSString *)key forItemKey:(NSString *)itemKey {
    [_manager addParam:param key:key forItemKey:itemKey];
}

- (NSDictionary *)paramsForItemKey:(NSString *)itemKey {
    return [_manager paramsForItemKey:itemKey];
}

- (void)noEditForItemKey:(NSString *)itemKey {
    [_manager noEditForItemKey:itemKey];
}

- (void)editForItemKey:(NSString *)itemKey {
    [_manager editForItemKey:itemKey];
}

- (void)showForKey:(NSString *)itemKey {
    [_manager showForKey:itemKey];
}

- (void)hideForKey:(NSString *)itemKey {
    [_manager hideForKey:itemKey];
}

#pragma mark <FansFormManagerInterface>
- (NSString *)key {
    return nil;
}

- (void)setRequestContent:(NSString *)requestContent {
    
}

- (NSString *)requestContent {
    return nil;
}

- (void)setShowContent:(NSString *)content {
    
}

- (NSString *)showContent {
    return nil;
}

- (void)addParam:(id)param key:(NSString *)key {
    
}

- (NSDictionary *)params {
    return nil;
}

- (UIView<FansFormItemViewInterface> *)contentView {
    return self;
}

- (void)noEdit {
    
}

- (void)edit {
    
}

- (void)show {
    
}

- (void)hide {
    
}

#pragma mark <FansFormItemViewInterface>
- (CGSize)getLayoutSize {
    return self.fans_size;
}

@end
