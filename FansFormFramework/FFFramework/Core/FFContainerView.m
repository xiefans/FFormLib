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

- (instancetype)initWithManager:(__kindof FFViewManager *)manager {
    if (self = [super initWithManager:manager]) {
        
        self.paddingInsets = FFContainerViewNormalPadding;
    }
    return self;
}

- (FFContainerManager *)manager {
    return [super manager];
}


- (void)ff_addItem:(__kindof FFView *)view {
    [self.manager addSubManager:view.manager];
    [self.map setObject:view forKey:view.key];
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
