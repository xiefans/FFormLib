//
//  FansFormContainerView.m
//  FansFormFramework
//
//  Created by fans on 2019/7/25.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FansFormContainerView.h"
#import "FansFormTool.h"

@interface FansFormContainerView ()

@property (nonatomic, strong) NSMutableDictionary *map;

@end

@implementation FansFormContainerView


- (void)layoutSubviews {
    
    __weak typeof(self)weakSelf = self;
    
    __block FansFormView *lastView = nil;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof FansFormView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj.manager setRefreshBlock:^(FansFormViewManager *manager) {
            __strong typeof(weakSelf)self = weakSelf;
            [self setNeedsLayout];
        }];
        
        CGFloat normalHeight = 55.0f;
        CGFloat x = self.paddingInsets.left + obj.marginInsets.left;
        CGFloat y = (lastView ? 0.f : self.paddingInsets.top) + lastView.fans_bottom + obj.marginInsets.top + lastView.marginInsets.bottom;
        CGFloat width = (obj.size.width > 0.f ? obj.size.width : self.fans_width) - x - obj.marginInsets.right - self.paddingInsets.right;
        CGFloat height = 0.f;
        if (obj.manager.isShow) {
            height = obj.size.height > 0.f ? obj.size.height : normalHeight;
        }
        
        obj.frame = CGRectMake(x, y, MAX(width, 0.f), MAX(height, 0.f));
       
        lastView = obj;
    }];
    
}

- (instancetype)initWithKey:(NSString *)key {
    return [self initWithManager:[FansFormContainerManager managerWithKey:key]];
}

- (FansFormContainerManager *)manager {
    return [super manager];
}


- (void)addSubview:(__kindof FansFormView *)view {
    [super addSubview:view];
    [self.manager addSubManager:view.manager];
    [self.map setObject:view forKey:view.key];
}

- (void)removeSubviewForKey:(NSString *)key {
    FansFormView *view = [self subviewForKey:key];
    [view removeFromSuperview];
    [self.manager removeSubManagerForKey:key];
    [self.map removeObjectForKey:key];
}

- (FansFormView *)subviewForKey:(NSString *)key {
    return self.map[key];
}

- (NSArray<FansFormView *> *)subviews {
    return [super subviews];
}



- (NSMutableDictionary *)map {
    if (!_map) {
        _map = [NSMutableDictionary new];
    }
    return _map;
}

@end
