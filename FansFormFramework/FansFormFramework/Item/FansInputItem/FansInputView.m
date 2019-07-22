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
@implementation FansInputView

@synthesize titleLb = _titleLb;
@synthesize textView = _textView;

#pragma mark - Overrides
- (instancetype)init {
    self = [super init];
    if (self) {
        [self addSubview:self.titleLb];
        [self addSubview:self.textView];
    }
    return self;
}

- (void)layoutSubviews {
    CGFloat height = MIN(FansFormItemNormalHeight, self.fans_height);
    self.titleLb.frame = CGRectMake(0,
                                    0,
                                    FansFormItemTitleNormalWidth,
                                    height);
    self.textView.frame = CGRectMake(
                                     self.titleLb.fans_right + FansFormItemHorizontalNormalGap,
                                     0,
                                     self.fans_width - self.titleLb.fans_right,
                                     height
                                     );
}

#pragma mark - Protocol
#pragma mark <FansFormItemViewInterface>
- (CGSize)getLayoutSize {
    return CGSizeMake(
                      [UIApplication sharedApplication].delegate.window.fans_width,
                      FansFormItemNormalHeight
                      );
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
    }
    return _textView;
}


@end
