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
    
    __block CGFloat maxHeight = 0.f;
    
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(__kindof FFView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (![obj isKindOfClass:[FFView class]]) {
            return ;
        }
        
        [obj.manager setRefreshBlock:^(FFViewManager *manager) {
            __strong typeof(weakSelf)self = weakSelf;
            [self setNeedsLayout];
            [self layoutIfNeeded];
        }];
        
        CGFloat x = 0.f;
        CGFloat y = 0.f;
        CGFloat width = 0.f;
        if (self.layoutDirection == FFContainerViewLayoutDirectionVertical) {
            x = self.paddingInsets.left + obj.marginInsets.left;
            y = (lastView ? 0.f : self.paddingInsets.top) + lastView.fans_bottom + obj.marginInsets.top + lastView.marginInsets.bottom;
            width = (obj.size.width > 0.f ? MIN(obj.size.width, self.fans_width) : self.fans_width) - x - obj.marginInsets.right - self.paddingInsets.right;
        } else {
            y = self.paddingInsets.top + obj.marginInsets.top;
            x = (lastView ? 0.f : self.paddingInsets.left) + lastView.fans_right + obj.marginInsets.left + lastView.marginInsets.right;
            width = (obj.size.width > 0.f ? MIN(obj.size.width, self.fans_width) : self.fans_width);
        }
        
        
        CGFloat height = obj.size.height;
        if (maxHeight < height) {
            maxHeight = height;
        }
        
        obj.frame = CGRectMake(x, y, MAX(width, 0.f), MAX(height, 0.f));
        
        if (obj.manager.isShow) {
            lastView = obj;
        }
    }];
    
    if (self.layoutDirection == FFContainerViewLayoutDirectionVertical) {
        self.scrollView.contentSize = CGSizeMake(0.f, lastView.fans_bottom + self.paddingInsets.bottom);
    } else {
        self.scrollView.contentSize = CGSizeMake(lastView.fans_right + self.paddingInsets.right, maxHeight);
    }
    
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

- (void)ff_addItem:(__kindof FFView *)view {
    [self.scrollView addSubview:view];
    [super ff_addItem:view];
}

- (NSArray<FFView *> *)ff_allItem {
    return [self.scrollView subviews];
}

- (void)scrollItemForKey:(NSString *)key toPosition:(FFScrollContainerItemScrollPosition)position {
    [self scrollItemForKey:key toPosition:position animation:NO];
}

- (void)scrollItemForKey:(NSString *)key
              toPosition:(FFScrollContainerItemScrollPosition)position
               animation:(BOOL)animation {
    
    FFView *item = [self ff_deepItemForKey:key];
    if (!item) {
        return;
    }
    CGRect itemFrame = CGRectZero;
    if (item.superview == self.scrollView) {
        itemFrame = item.frame;
    } else {
        itemFrame = [item.superview convertRect:item.frame toView:self.scrollView];
    }
    CGFloat itemX = itemFrame.origin.x;
    CGFloat itemY = itemFrame.origin.y;
    CGFloat itemBottom = CGRectGetMaxY(itemFrame);
    CGFloat itemRight = CGRectGetMaxX(itemFrame);
    CGFloat itemCenterY = (itemFrame.origin.y + CGRectGetMaxY(itemFrame)) / 2.f;
    CGFloat itemCenterX = (itemFrame.origin.x + CGRectGetMaxX(itemFrame)) / 2.f;
    CGPoint offset = self.scrollView.contentOffset;
    
    //滑到中心
    if (position == FFScrollContainerItemScrollPositionCenter) {
        CGFloat x = 0.f;
        if (itemCenterX > (self.scrollView.contentOffset.x + self.scrollView.fans_halfWidth)) {
            //向左滑
            x = MIN(itemCenterX - self.scrollView.fans_halfWidth,
                    MAX(self.scrollView.contentSize.width - self.scrollView.fans_width, 0.f));
        } else {
            //向右滑
            x = MAX(itemCenterX - self.scrollView.fans_halfWidth, 0.f);
        }
        
        CGFloat y = 0.f;
        if (itemCenterY > (self.scrollView.contentOffset.y + self.scrollView.fans_halfHeight)) {
            y = MIN(itemCenterY - self.scrollView.fans_halfHeight,
                            MAX(self.scrollView.contentSize.height - self.scrollView.fans_height, 0.f));
        } else {
            //下滑
            y = MAX(itemCenterY - self.scrollView.fans_halfHeight, 0.f);
        }
        offset = CGPointMake(x, y);
    } else {
        CGFloat x = offset.x;
        CGFloat y = offset.y;
        if ((position & FFScrollContainerItemScrollPositionTop)) {
            y = MIN(itemY,
                    MAX(self.scrollView.contentSize.height - self.scrollView.fans_height, 0.f));
        } else if (position & FFScrollContainerItemScrollPositionBottom){
            y = MAX(itemBottom - self.scrollView.fans_height, 0.f);
        }
        
        if (position & FFScrollContainerItemScrollPositionLeft) {
            x = MAX(MIN(itemX - self.paddingInsets.left, self.scrollView.contentSize.width - self.scrollView.fans_width), 0.f);
        } else if (position & FFScrollContainerItemScrollPositionRight) {
            x = MAX(itemRight + self.paddingInsets.right - self.scrollView.fans_width, 0.f);
        }
        offset = CGPointMake(x, y);
    }
    
    if (offset.y == self.scrollView.contentOffset.y && offset.x == self.scrollView.contentOffset.x) {
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
