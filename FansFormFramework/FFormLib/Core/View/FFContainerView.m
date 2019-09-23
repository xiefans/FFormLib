//
//  FFContainerView.m
//  FFFramework
//
//  Created by fans on 2019/7/25.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FFContainerView.h"
#import "FFTool.h"

@interface FFContainerView ()


@end

@implementation FFContainerView

+ (instancetype)containerWithKey:(NSString *)key {
    return [self formViewWithKey:key];
}

+ (instancetype)containerWithManager:(__kindof FFContainerManager *)manager {
    return [self formViewWithManager:manager];
}

+ (instancetype)containerWithKey:(NSString *)key layoutDirection:(FFContainerViewLayoutDirection)layoutDirection {
    return [self formViewWithKey:key layoutDirection:layoutDirection];
}

+ (instancetype)formViewWithKey:(NSString *)key layoutDirection:(FFContainerViewLayoutDirection)layoutDirection {
    return [[self alloc] initWithKey:key layoutDirection:layoutDirection];
}

- (instancetype)initWithKey:(NSString *)key layoutDirection:(FFContainerViewLayoutDirection)layoutDirection {
    if (self = [self initWithKey:key]) {
        _layoutDirection = layoutDirection;
    }
    return self;
}

- (instancetype)initWithKey:(NSString *)key {
    return [self initWithManager:[FFContainerManager managerWithKey:key]];
}

- (instancetype)initWithManager:(__kindof FFContainerManager *)manager {
    if (self = [super initWithManager:manager]) {
        manager.viewType = FFViewManagerViewTypeContainer;
        self.paddingInsets = FFContainerViewNormalPadding;
    }
    return self;
}

- (FFContainerManager *)manager {
    return [super manager];
}


- (void)ff_addItem:(__kindof FFView *)item {
    [self.manager addSubManager:item.manager];
    [self.map setObject:item forKey:item.key];
}

- (void)ff_removeItemForKey:(NSString *)key {
    FFView *view = [self ff_itemForKey:key];
    if (view) {
        [view removeFromSuperview];
        [self.manager removeSubManagerForKey:key];
        [self.map removeObjectForKey:key];
    }
}

- (FFView *)ff_itemForKey:(NSString *)key {
    return self.map[key];
}

- (FFView *)ff_deepItemForKey:(NSString *)key {
    FFView *item = self.map[key];
    if (!item) {
        for (FFView *sub in self.ff_allItem) {
            if ([sub isKindOfClass:[FFContainerView class]]) {
                item = [((FFContainerView *)sub) ff_itemForKey:key];
            }
            
            if (item) {
                break;
            }
        }
    }
    return item;
}

- (FFContainerView *)ff_deepContainerForSubKey:(NSString *)key {
    FFView *item = self.map[key];
    if (!item) {
        for (FFView *sub in self.ff_allItem) {
            if ([sub isKindOfClass:[FFContainerView class]]) {
                item = [((FFContainerView *)sub) ff_itemForKey:key];
            }
            if (item) {
                return ((FFContainerView *)sub);
            }
        }
    }
    return self;
}

- (void)setLayoutDirection:(FFContainerViewLayoutDirection)layoutDirection {
    if (_layoutDirection != layoutDirection) {
        _layoutDirection = layoutDirection;
        [self layoutSubviews];
    }
}

- (NSArray<FFView *> *)ff_allItem {
    return [self subviews];
}

- (NSMutableDictionary *)map {
    if (!_map) {
        _map = [NSMutableDictionary new];
    }
    return _map;
}

@end
