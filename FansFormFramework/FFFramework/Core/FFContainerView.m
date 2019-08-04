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


- (void)ff_addSubview:(__kindof FFView *)view {
    [self.manager addSubManager:view.manager];
    [self.map setObject:view forKey:view.key];
}

- (void)ff_removeSubviewForKey:(NSString *)key {
    FFContainerView *containerView = [self ff_containerForSubKey:key];
    
    if (containerView) {
        FFView *view = [self ff_subviewForKey:key];
        [view removeFromSuperview];
        [containerView.manager removeSubManagerForKey:key];
        [containerView.map removeObjectForKey:key];
    }
}

- (FFView *)ff_subviewForKey:(NSString *)key {
    FFView *item = self.map[key];
    if (!item) {
        for (FFView *sub in self.ff_subviews) {
            if ([sub isKindOfClass:[FFContainerView class]]) {
                item = [((FFContainerView *)sub) ff_subviewForKey:key];
            }
            
            if (item) {
                break;
            }
        }
    }
    return item;
}

- (FFContainerView *)ff_containerForSubKey:(NSString *)key {
    FFView *item = self.map[key];
    if (!item) {
        for (FFView *sub in self.ff_subviews) {
            if ([sub isKindOfClass:[FFContainerView class]]) {
                item = [((FFContainerView *)sub) ff_subviewForKey:key];
            }
            if (item) {
                return ((FFContainerView *)sub);
            }
        }
    }
    return self;
}

- (NSArray<FFView *> *)ff_subviews {
    return [self subviews];
}

- (NSMutableDictionary *)map {
    if (!_map) {
        _map = [NSMutableDictionary new];
    }
    return _map;
}

@end
