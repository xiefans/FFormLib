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

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation FansFormView

@synthesize refreshBlock = _refreshBlock;

#pragma mark - Overrides
- (void)layoutSubviews {
    
    self.scrollView.frame = self.bounds;
    
    __weak typeof(self)weakSelf = self;
    __block UIView *lastView = nil;
    [_layoutItems enumerateObjectsUsingBlock:^(id<FansFormItemInterface>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        __strong typeof(weakSelf)self = weakSelf;
        
        UIView<FansFormItemViewInterface> *itemView = obj.contentView;
        
        if (!itemView.superview) {
            [self.scrollView addSubview:itemView];
        }
        
        switch (self.direction) {
            case FansFormContainerArrangeVerticalDirection:
                itemView.frame = CGRectMake(
                                            self.insets.left,
                                            lastView ? lastView.fans_bottom : self.insets.top,
                                            self.scrollView.fans_width - self.insets.left - self.insets.right,
                                            itemView.getLayoutSize.height
                                            );
                break;
            
            case FansFormContainerArrangeHorizontalDirection:
                itemView.frame = CGRectMake(
                                            lastView ? lastView.fans_right : self.insets.left,
                                            self.insets.top,
                                            itemView.getLayoutSize.width,
                                            self.scrollView.fans_height - self.insets.top - self.insets.bottom
                                            );
                break;
        }
        
        [obj setRefreshBlock:^(id<FansFormItemInterface> item) {
            [self setNeedsLayout];
        }];
        
        lastView = itemView;
    }];
    
    
    [self.scrollView setContentSize:CGSizeMake(
                                               lastView.fans_right + self.insets.right,
                                               lastView.fans_bottom + self.insets.bottom
                                               )];
}


#pragma mark - Public Method

+ (instancetype)formView {
    return [[self alloc] initWithManager:[FansFormManager new]];
}

+ (instancetype)formViewWithDirection:(FansFormContainerArrangeDirection)direction {
    return [[self alloc] initWithManager:[FansFormManager new]
                               direction:direction];
}

- (instancetype)initWithManager:(id<FansFormManagerInterface>)manager {
    return [self initWithManager:manager
                       direction:FansFormContainerArrangeVerticalDirection];
}

- (instancetype)initWithManager:(id<FansFormManagerInterface>)manager
                      direction:(FansFormContainerArrangeDirection)direction {
    if (self = [super init]) {
        _direction = direction;
        _manager = manager;
        _insets = UIEdgeInsetsMake(5, 15, 5, 15);
        [self initTool];
        [self addSubview:self.scrollView];
    }
    return self;
}

- (void)initTool {
    _layoutItems = [NSMutableArray new];
}

#pragma mark - Private Method

- (void)fans_sizeToFit {
    [self setNeedsLayout];
}

#pragma mark - Setter Getter
- (void)setInsets:(UIEdgeInsets)insets {
    _insets = insets;
    
    [self setNeedsLayout];
}

#pragma mark - Protocol
#pragma mark <FansFormContainerInterface>
+ (instancetype)containerWithManager:(id<FansFormManagerInterface>)manager {
    return [[self alloc] initWithManager:manager];
}

- (void)addItem:(id<FansFormItemInterface>)item {
    [_manager addItem:item];
    
    [_layoutItems addObject:item];
    
    [self fans_sizeToFit];
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
    
    [self fans_sizeToFit];
}

- (void)editForItemKey:(NSString *)itemKey {
    [_manager editForItemKey:itemKey];
    
    [self fans_sizeToFit];
}

- (void)showForKey:(NSString *)itemKey {
    [_manager showForKey:itemKey];
    
    [self fans_sizeToFit];
}

- (void)hideForKey:(NSString *)itemKey {
    [_manager hideForKey:itemKey];
    
    [self fans_sizeToFit];
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

- (BOOL)isEdit {
    return YES;
}

- (void)show {
    
}

- (void)hide {
    
}

- (BOOL)isShow {
    return YES;
}

#pragma mark <FansFormItemViewInterface>
- (CGSize)getLayoutSize {
    return self.fans_size;
}


#pragma mark - Lazy Load
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    return _scrollView;
}

@end
