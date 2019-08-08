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
    __block CGFloat useHeight = self.paddingInsets.top; // 已经使用的高度， 只在横向布局时使用到了
    __block CGFloat useWidth = self.paddingInsets.left; // 已经使用的宽度
    [self.ff_allItem enumerateObjectsUsingBlock:^(__kindof FFView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (!obj.manager.isShow) {
            return ;
        }
        
        [obj.manager setRefreshBlock:^(FFViewManager *manager) {
            __strong typeof(weakSelf)self = weakSelf;
            [self ff_refreshSize];
            [self setNeedsLayout];
            [self layoutIfNeeded];
        }];
        
        CGFloat x = 0.f;
        CGFloat y = 0.f;
        CGFloat width = 0.f;
        
        switch (self.layoutDirection) {
            case FFContainerViewLayoutDirectionVertical:
                x = self.paddingInsets.left + obj.marginInsets.left;
                y = (lastView ? 0.f : self.paddingInsets.top) + lastView.fans_bottom + obj.marginInsets.top + lastView.marginInsets.bottom;
                width = (
                         obj.size.width > 0.f ?
                         obj.size.width :
                         self.fans_width
                         ) - obj.marginInsets.left - obj.marginInsets.right - self.paddingInsets.right;
                break;
            case FFContainerViewLayoutDirectionHorizontal:{
                // 判断宽度是否还可以放得下当前的视图
                useWidth = lastView ? (lastView.fans_right + lastView.marginInsets.right) : self.paddingInsets.left; /**< 目前已使用的宽度 */
                CGFloat remainingWidth = self.fans_width - useWidth - obj.marginInsets.left - obj.marginInsets.right - self.paddingInsets.right;
                
                width = obj.size.width - obj.marginInsets.left - obj.marginInsets.right;
                if (width <= 0.f) {
                    width = self.fans_width - self.paddingInsets.left - self.paddingInsets.right - obj.marginInsets.left - obj.marginInsets.right;
                }
                if (remainingWidth >= width && lastView) {
                    // 可以放得下
                    x = useWidth + obj.marginInsets.left;
                    y = lastView.fans_y - lastView.marginInsets.top + obj.marginInsets.top;
                } else {
                    // 放不下
                    x = self.paddingInsets.left + obj.marginInsets.left;
                    y = useHeight + obj.marginInsets.top;
                    useWidth = self.paddingInsets.left;
                    // 这里是折行了, 证明之前一个view 是 那一行最后一个视图。 需要接受边距控制
                    if (lastView) {
                        lastView.fans_width = MAX(0.f, lastView.fans_width - self.paddingInsets.right);
                    }
                }
            }
                break;
        }
        
        CGFloat height = MAX(obj.size.height, 0.f);
        obj.frame = CGRectMake(x, y, MAX(width, 0.f), MAX(height, 0.f));
        useHeight = MAX(useHeight, obj.fans_bottom + obj.marginInsets.bottom);
        lastView = obj;
    }];
    
    return useHeight + self.paddingInsets.bottom;
}

- (void)ff_addItem:(__kindof FFView *)item {
    [self addSubview:item];
    [super ff_addItem:item];
    [self ff_refreshSize];
}

- (void)ff_removeItemForKey:(NSString *)key {
    [super ff_removeItemForKey:key];
    [self ff_refreshSize];
}

- (void)ff_refreshSize {
    self.size = CGSizeMake(self.size.width, [self mathHeight]);
    self.fans_height = self.size.height;
    [self.manager excuteRefreshBlock];
}

@end
