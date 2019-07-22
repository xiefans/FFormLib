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
#import "FansFormItemConstant.h"
@interface FansFormView ()

@property (nonatomic, strong) id<FansFormManagerInterface> manager;
@property (nonatomic, strong) NSMutableArray *layoutItems;

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation FansFormView

@synthesize getSizeBlock = _getSizeBlock;
@synthesize refreshBlock = _refreshBlock;
@synthesize must = _must;

#pragma mark - Overrides
- (void)layoutSubviews {
    
    self.scrollView.frame = self.bounds;
    
    __weak typeof(self)weakSelf = self;
    __block UIView *lastView = nil;
    [_layoutItems enumerateObjectsUsingBlock:^(id<FansFormItemInterface>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        __strong typeof(weakSelf)self = weakSelf;
        
        UIView *itemView = obj.contentView;
        
        if (!itemView.superview) {
            [self.scrollView addSubview:itemView];
        }
        
        CGFloat height = FansFormItemNormalHeight - self.insets.top - self.insets.bottom;
        CGFloat width = self.scrollView.fans_width - self.insets.left - self.insets.right;
        if (obj.getSizeBlock) {
            obj.getSizeBlock(obj, &width, &height);
        }
        
        
        switch (self.direction) {
            case FansFormContainerArrangeVerticalDirection:
                itemView.frame = CGRectMake(
                                            self.insets.left,
                                            lastView ? lastView.fans_bottom : self.insets.top,
                                            width,
                                            obj.isShow ? height : 0.f
                                            );
                break;
            
            case FansFormContainerArrangeHorizontalDirection:
                itemView.frame = CGRectMake(
                                            lastView ? lastView.fans_right : self.insets.left,
                                            self.insets.top,
                                            obj.isShow ? width : 0.f,
                                            height
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

- (NSArray<FansFormItemInterface> *)subItems {
    return (NSArray<FansFormItemInterface> *)self.layoutItems;
}

#pragma mark <FansFormManagerInterface>
- (id<FansFormItemInterface>)itemForKey:(NSString *)key {
    return [_manager itemForKey:key];
}

- (NSString *)toJSONString {
    return [_manager toJSONString];
}

- (NSDictionary *)toDictionary {
    return [_manager toDictionary];
}

#pragma mark <FansFormItemInterface>


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


- (void)addParam:(id)param key:(NSString *)key {
    [self.layoutItems enumerateObjectsUsingBlock:^(id<FansFormItemInterface>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj addParam:param key:key];
    }];
}

- (UIView *)contentView {
    return self;
}

- (void)edit {
    [self.layoutItems enumerateObjectsUsingBlock:^(id<FansFormItemInterface>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj edit];
    }];
}

- (void)hide {
    [self.layoutItems enumerateObjectsUsingBlock:^(id<FansFormItemInterface>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj hide];
    }];
}

- (BOOL)isEdit {
    return YES;
}

- (BOOL)isShow {
    return YES;
}

- (NSString *)key {
    return @"";
}

- (void)noEdit {
    [self.layoutItems enumerateObjectsUsingBlock:^(id<FansFormItemInterface>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj noEdit];
    }];
}

- (NSDictionary *)params {
    return nil;
}

- (NSString *)requestContent {
    return nil;
}

- (void)setRequestContent:(NSString *)requestContent {
    [self.layoutItems enumerateObjectsUsingBlock:^(id<FansFormItemInterface>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setRequestContent:requestContent];
    }];
}

- (void)setShowContent:(NSString *)content {
    [self.layoutItems enumerateObjectsUsingBlock:^(id<FansFormItemInterface>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setShowContent:content];
    }];
}

- (void)show {
    [self.layoutItems enumerateObjectsUsingBlock:^(id<FansFormItemInterface>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj show];
    }];
}

- (NSString *)showContent {
    return nil;
}

- (NSString *)title {
    return nil;
}


@end
