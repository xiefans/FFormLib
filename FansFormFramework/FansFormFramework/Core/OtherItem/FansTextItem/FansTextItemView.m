//
//  FansTextItemView.m
//  FansFormFramework
//
//  Created by fans on 2019/7/24.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FansTextItemView.h"
#import "FansFormTool.h"
@interface FansTextItemView ()<UITextViewDelegate>

@end

@implementation FansTextItemView

@synthesize titleLb = _titleLb;
@synthesize lineView = _lineView;
@synthesize textView = _textView;
@synthesize placeholderLb = _placeholderLb;

#pragma mark - Overrides
- (instancetype)init {
    self = [super init];
    if (self) {
        [self addSubview:self.titleLb];
        [self addSubview:self.textView];
        [self addSubview:self.placeholderLb];
        [self addSubview:self.lineView];
        
        self.frame = CGRectMake(0, 0, FansFormItemNormalWidth, FansTextItemViewNormalHeight);
    }
    return self;
}

- (void)layoutSubviews {
    
    CGFloat gap = 3.f;
    
    [self.titleLb sizeToFit];
    self.titleLb.frame = CGRectMake(
                                    FansFormItemHorizontalNormalGap,
                                    gap,
                                    FansFormItemTitleNormalWidth,
                                    self.titleLb.fans_height
                                    );
    
    self.titleLb.fans_centerY = (FansFormItemNormalHeight + gap)/ 2.f;
    
    self.textView.frame = CGRectMake(
                                      self.titleLb.fans_right + FansFormItemHorizontalNormalGap,
                                      self.titleLb.fans_y,
                                      self.fans_width - (self.titleLb.fans_right + FansFormItemHorizontalNormalGap),
                                      MAX(self.fans_height - self.titleLb.fans_y * 2, 0.f)
                                      );
    CGFloat lineWidth = 0.5f;
    self.lineView.frame = CGRectMake(
                                     0.f,
                                     self.fans_height - lineWidth,
                                     self.fans_width,
                                     lineWidth
                                     );
    self.placeholderLb.frame = self.textView.frame;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (CGRectContainsPoint(self.textView.frame, point)) {
        return self.textView;
    } else {
        return nil;
    }
}

#pragma mark - Public Method
- (void)checkContent:(NSString *)content {
    if (content && content.length != 0) {
        self.placeholderLb.hidden = YES;
    } else {
        self.placeholderLb.hidden = NO;
    }
}

#pragma mark - Protocol
#pragma mark <UITextViewDelegate>
- (void)textViewDidChange:(UITextView *)textView {
    [self checkContent:textView.text];
}

#pragma mark - Lazy Load
- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.textColor = [UIColor fans_colorWithHexValue:FansFormItemTitleNoramlColor];
        _titleLb.font = [UIFont systemFontOfSize:15.f];
    }
    return _titleLb;
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        
        _textView.font = [UIFont systemFontOfSize:15.f];
        _textView.textColor = [UIColor fans_colorWithHexValue:FansFormItemValueNoramlColor];
        _textView.backgroundColor = [UIColor fans_colorWithHexValue:0xeeeeee];
        _textView.delegate = self;
    }
    return _textView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor fans_colorWithHexValue:FansFormItemLineNoramlColor];
    }
    return _lineView;
}

- (UITextView *)placeholderLb {
    if (!_placeholderLb) {
        _placeholderLb = [[UITextView alloc] init];
        _placeholderLb.textColor = [UIColor fans_colorWithHexValue:0xD3D3D3];
        _placeholderLb.font = self.textView.font;
        _placeholderLb.backgroundColor = [UIColor clearColor];
        _placeholderLb.editable = NO;
        _placeholderLb.scrollEnabled = NO;
    }
    return _placeholderLb;
}


@end
