//
//  FFScrollContainerItem.m
//  FansFormFramework
//
//  Created by 谢帆 on 2019/8/2.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FFScrollContainerItem.h"
#import "FFTool.h"
@implementation FFScrollContainerItem

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
            [self layoutIfNeeded];
        }];
        
        CGFloat x = self.paddingInsets.left + obj.marginInsets.left;
        CGFloat y = (lastView ? 0.f : self.paddingInsets.top) + lastView.fans_bottom + obj.marginInsets.top + lastView.marginInsets.bottom;
        CGFloat width = (obj.size.width > 0.f ? obj.size.width : self.fans_width) - x - obj.marginInsets.right - self.paddingInsets.right;
        CGFloat height = obj.size.height;
        
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
        
        [self addSubview:self.scrollView];
    }
    return self;
}

- (FFContainerManager *)manager {
    return [super manager];
}

- (void)ff_addSubview:(__kindof FFView *)view {
    [self.scrollView addSubview:view];
    [super ff_addSubview:view];
}

- (NSArray<FFView *> *)ff_subviews {
    return [self.scrollView subviews];
}

- (void)scrollItemForKey:(NSString *)key toPosition:(FFScrollContainerItemScrollPosition)position {
    [self scrollItemForKey:key toPosition:position animation:NO];
}

- (void)scrollItemForKey:(NSString *)key
              toPosition:(FFScrollContainerItemScrollPosition)position
               animation:(BOOL)animation {
    
    FFView *item = [self ff_subviewForKey:key];
    if (!item) {
        return;
    }
    CGRect itemFrame = CGRectZero;
    if (item.superview == self.scrollView) {
        itemFrame = item.frame;
    } else {
        itemFrame = [item.superview convertRect:item.frame toView:self.scrollView];
    }
    CGFloat itemY = itemFrame.origin.y;
    CGFloat itemBottom = CGRectGetMaxY(itemFrame);
    CGFloat itemCenterY = (itemFrame.origin.y + CGRectGetMaxY(itemFrame)) / 2.f;
    CGPoint offset = self.scrollView.contentOffset;
    switch (position) {
        case FFScrollContainerItemScrollPositionTop:
            offset = CGPointMake(0.f, MIN(itemY,
                                          MAX(self.scrollView.contentSize.height - self.scrollView.fans_height, 0.f)));
            break;
        case FFScrollContainerItemScrollPositionBottom:
            offset = CGPointMake(0.f, MAX(itemBottom - self.scrollView.fans_height, 0.f));
            break;
        case FFScrollContainerItemScrollPositionCenter: {
            //判断方向
            if (itemCenterY > (self.scrollView.contentOffset.y + self.scrollView.fans_halfHeight)) {
                //向上滑
                offset = CGPointMake(0.f, MIN(itemCenterY - self.scrollView.fans_halfHeight,
                                              MAX(self.scrollView.contentSize.height - self.scrollView.fans_height, 0.f)));
            } else {
                //下滑
                offset = CGPointMake(0.f, MAX(itemCenterY - self.scrollView.fans_halfHeight, 0.f));
            }
        }
            break;
    }
    
    if (offset.y == self.scrollView.contentOffset.y) {
        return;
    }
    [self.scrollView setContentOffset:offset animated:animation];
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

@end
