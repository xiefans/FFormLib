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

@property (nonatomic, strong) NSMutableDictionary *map;

@end

@implementation FFContainerView


- (void)layoutSubviews {
    
    __weak typeof(self)weakSelf = self;
    
    __block FFView *lastView = nil;
    
    CGPoint offset = self.scrollView.contentOffset;
    self.scrollView.frame = self.bounds;
    
    if (self.scrollViewHeight) {
        self.scrollView.fans_height = self.scrollViewHeight;
    }
    
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(__kindof FFView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (![obj isKindOfClass:[FFView class]]) {
            return ;
        }
        
        [obj.manager setRefreshBlock:^(FFViewManager *manager) {
            __strong typeof(weakSelf)self = weakSelf;
            [self setNeedsLayout];
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
    
    self.scrollView.contentSize = CGSizeMake(0, lastView.fans_bottom + self.paddingInsets.bottom);
    self.scrollView.contentOffset = CGPointMake(MAX(0.f, offset.x), MAX(0.f, offset.y));
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithKey:(NSString *)key {
    return [self initWithManager:[FFContainerManager managerWithKey:key]];
}

- (instancetype)initWithManager:(__kindof FFViewManager *)manager {
    if (self = [super initWithManager:manager]) {
        
        self.paddingInsets = FFContainerViewNormalPadding;
        
        [super addSubview:self.scrollView];
    }
    return self;
}

- (FFContainerManager *)manager {
    return [super manager];
}


- (void)addSubview:(__kindof FFView *)view {
    [self.scrollView addSubview:view];
    [self.manager addSubManager:view.manager];
    [self.map setObject:view forKey:view.key];
}

- (void)removeSubviewForKey:(NSString *)key {
    FFView *view = [self subviewForKey:key];
    [view removeFromSuperview];
    [self.manager removeSubManagerForKey:key];
    [self.map removeObjectForKey:key];
}

- (FFView *)subviewForKey:(NSString *)key {
    return self.map[key];
}

- (NSArray<FFView *> *)subviews {
    return [super subviews];
}

- (NSMutableDictionary *)map {
    if (!_map) {
        _map = [NSMutableDictionary new];
    }
    return _map;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

@end
