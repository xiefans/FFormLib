//
//  FansInputView.m
//  FansFormFramework
//
//  Created by fans on 2019/7/22.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FansInputView.h"
#import "FansFormTool.h"
#import "FansFormItemConstant.h"
@implementation FansInputView {
    CGSize _showSize;
}

@synthesize titleLb = _titleLb;
@synthesize textView = _textView;

#pragma mark - Overrides
- (instancetype)init {
    self = [super init];
    if (self) {
        [self addSubview:self.titleLb];
        [self addSubview:self.textView];
        
        _showSize = CGSizeMake(
                               [UIApplication sharedApplication].delegate.window.fans_width,
                               FansFormItemNormalHeight
                               );
        
        _show = YES;
    }
    return self;
}

- (void)layoutSubviews {
    CGFloat gap = 3.f;
    CGFloat height = MIN(FansFormItemNormalHeight, self.fans_height - gap * 2);
    self.titleLb.frame = CGRectMake(
                                    0,
                                    gap,
                                    FansFormItemTitleNormalWidth,
                                    height
                                    );
    self.textView.frame = CGRectMake(
                                     self.titleLb.fans_right + FansFormItemHorizontalNormalGap,
                                     gap,
                                     self.fans_width - (self.titleLb.fans_right + FansFormItemHorizontalNormalGap),
                                     height
                                     );
}

#pragma mark - Setter Getter
- (void)setShow:(BOOL)show {
    _show = show;
    
    if (show) {
        _showSize = CGSizeMake(
                               [UIApplication sharedApplication].delegate.window.fans_width,
                               FansFormItemNormalHeight
                               );
    } else {
        _showSize = CGSizeMake(
                               0,
                               0
                               );
    }
    
    self.hidden = !show;
}

#pragma mark - Protocol
#pragma mark <FansFormItemViewInterface>
- (CGSize)getLayoutSize {
    return _showSize;
}


#pragma mark - Lazy Load
- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.textColor = [UIColor lightGrayColor];
        _titleLb.font = [UIFont systemFontOfSize:15];
    }
    return _titleLb;
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.font = [UIFont systemFontOfSize:14];
        _textView.textColor = [UIColor grayColor];
        _textView.backgroundColor = [UIColor lightGrayColor];
    }
    return _textView;
}


@end
