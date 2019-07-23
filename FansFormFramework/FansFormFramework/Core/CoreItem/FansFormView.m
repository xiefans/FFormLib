//
//  FansFormView.m
//  FansFormFramework
//
//  Created by fans on 2019/7/22.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FansFormView.h"
#import "FansFormItemConstant.h"
#import "FansFormTool.h"

@interface FansFormView ()

@end

@implementation FansFormView

#pragma mark - Overrides
- (void)layoutSubviews {
    
    self.scrollView.frame = self.bounds;
    
    __weak typeof(self)weakSelf = self;
    __block UIView *lastView = nil;
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(UIView *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        __strong typeof(weakSelf)self = weakSelf;
        
        UIView *itemView = obj;
        
        CGFloat height = FansFormItemNormalHeight - self.insets.top - self.insets.bottom;
        CGFloat width = self.scrollView.fans_width - self.insets.left - self.insets.right;
        
        switch (self.direction) {
            case FansFormArrangeVerticalDirection:
                itemView.frame = CGRectMake(
                                            self.insets.left,
                                            lastView ? lastView.fans_bottom : self.insets.top,
                                            width,
                                            itemView.fans_height
                                            );
                break;
            
            case FansFormArrangeHorizontalDirection:
                itemView.frame = CGRectMake(
                                            lastView ? lastView.fans_right : self.insets.left,
                                            self.insets.top,
                                            itemView.fans_width,
                                            height
                                            );
                break;
        }
        
        lastView = itemView;
    }];
    
    
    [self.scrollView setContentSize:CGSizeMake(
                                               lastView.fans_right + self.insets.right,
                                               lastView.fans_bottom + self.insets.bottom
                                               )];
}


#pragma mark - Public Method

+ (instancetype)formView {
    return [[self alloc] initWithDirection:FansFormArrangeVerticalDirection];
}

+ (instancetype)formViewWithDirection:(FansFormArrangeDirection)direction {
    return [[self alloc] initWithDirection:direction];
}

- (instancetype)initWithDirection:(FansFormArrangeDirection)direction {
    if (self = [super init]) {
        _direction = direction;
        _insets = UIEdgeInsetsMake(5, 15, 5, 15);
        [self addSubview:self.scrollView];
    }
    return self;
}

#pragma mark - Private Method

#pragma mark - Private Method
- (void)fans_sizeToFit {
    [self setNeedsLayout];
}

#pragma mark - Setter Getter
- (void)setInsets:(UIEdgeInsets)insets {
    _insets = insets;
    
    [self setNeedsLayout];
}

#pragma mark - Lazy Load
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    return _scrollView;
}

@end
