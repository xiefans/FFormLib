//
//  FFAHContainerItem.m
//  FansFormFramework
//
//  Created by 谢帆 on 2019/8/2.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FFAutoHeightContainerItem.h"
#import "FFTool.h"
@implementation FFAutoHeightContainerItem

- (instancetype)initWithManager:(__kindof FFViewManager *)manager {
    if (self = [super initWithManager:manager]) {
        self.size = CGSizeMake(0.f, 0.f);
    }
    return self;
}

- (void)layoutSubviews {
    [self mathHeight];
}

- (CGFloat)mathHeight {
    
    __weak typeof(self)weakSelf = self;
    
    __block FFView *lastView = nil;
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof FFView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj.manager setRefreshBlock:^(FFViewManager *manager) {
            __strong typeof(weakSelf)self = weakSelf;
            [self setNeedsLayout];
            [self layoutIfNeeded];
        }];
        
        CGFloat normalHeight = FFViewNormalHeight;
        CGFloat x = self.paddingInsets.left + obj.marginInsets.left;
        CGFloat y = (lastView ? 0.f : self.paddingInsets.top) + lastView.fans_bottom + obj.marginInsets.top + lastView.marginInsets.bottom;
        CGFloat width = (obj.size.width > 0.f ? obj.size.width : self.fans_width) - x - obj.marginInsets.right - self.paddingInsets.right;
        CGFloat height = MAX(obj.size.height, normalHeight);
        
        obj.frame = CGRectMake(x, y, MAX(width, 0.f), MAX(height, 0.f));
        
        if (obj.manager.isShow) {
            lastView = obj;
        }
    }];
    
    return lastView.fans_bottom + self.paddingInsets.bottom + lastView.marginInsets.bottom;
}

- (void)ff_addSubview:(__kindof FFView *)view {
    [self addSubview:view];
    [super ff_addSubview:view];
    self.fans_height = [self mathHeight];
    [self.manager excuteRefreshBlock];
}

- (void)ff_removeSubviewForKey:(NSString *)key {
    [super ff_removeSubviewForKey:key];
    self.fans_height = [self mathHeight];
    [self.manager excuteRefreshBlock];
}

@end
