//
//  FansFormManager.m
//  FansFormFramework
//
//  Created by fans on 2019/7/22.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FansFormManager.h"
#if DEBUG

static BOOL const kIsLogInCommandLine = YES;

#else

static BOOL const kIsLogInCommandLine = NO;

#endif


@interface FansFormManager ()

@property (nonatomic, strong) NSMutableDictionary *itemMap;
@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, strong) FansFormView *formView;

@end

@implementation FansFormManager

#pragma mark - Overrides
- (NSDictionary *)makeDictionary {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    
    [self.subItems enumerateObjectsUsingBlock:^(FansFormAbstractItem *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *temp = [obj makeDictionary];
        
        [temp enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id  _Nonnull subItem, BOOL * _Nonnull stop) {
            [dict setObject:subItem forKey:key];
        }];
    }];
    
    if (self.isPackage && self.key) {
        return @{self.key : dict};
    }
    
    return dict;
}

- (UIView *)contentView {
    return self.formView;
}

#pragma mark - Public Method
+ (instancetype)managerWithDirection:(FansFormArrangeDirection)direction {
    return [[self alloc] initWithDirection:direction];
}

- (FansFormAbstractItem *)itemForKey:(NSString *)key {
    FansFormAbstractItem *item = self.itemMap[key];
    
    if (!item && kIsLogInCommandLine) {
        NSLog(@"Item(key : %@) not found in %@",key , self.class);
    }
    
    return self.itemMap[key];
}

- (void)addSubItem:(FansFormAbstractItem *)item {
    if (item) {
        __weak typeof(self)weakSelf = self;
        [item setRefreshBlock:^(FansFormAbstractItem *item) {
            __strong typeof(weakSelf)self = weakSelf;
            [self.formView setNeedsLayout];
        }];
        [self.itemMap setObject:item forKey:item.key];
        [self.formView.scrollView addSubview:item.contentView];
    }
}

- (void)removeSubItemForKey:(NSString *)key {
    FansFormAbstractItem * item = [self itemForKey:key];
    if (item) {
        [item.contentView removeFromSuperview];
        [self.itemMap removeObjectForKey:key];
        [self.formView setNeedsLayout];
    }
}

- (NSArray<FansFormAbstractItem *> *)subItems {
    return (NSArray<FansFormAbstractItem *> *)self.itemMap.allValues;
}

#pragma mark - Private Method
- (instancetype)initWithDirection:(FansFormArrangeDirection)direction {
    if (self = [super initWithKey:[NSString stringWithFormat:@"%@",self.class]]) {
        _formView = [FansFormView formViewWithDirection:direction];
    }
    return self;
}

- (instancetype)initWithKey:(NSString *)key {
    if (self = [super initWithKey:key]) {
        _formView = [FansFormView formView];
    }
    return self;
}



#pragma mark - Lazy Load
- (NSMutableDictionary *)itemMap {
    if (!_itemMap) {
        _itemMap = [NSMutableDictionary new];
    }
    return _itemMap;
}

@end
