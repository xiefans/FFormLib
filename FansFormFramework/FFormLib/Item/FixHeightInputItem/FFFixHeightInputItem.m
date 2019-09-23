//
//  FFFixHeightInputItem.m
//  FFFramework
//
//  Created by fans on 2019/7/30.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FFFixHeightInputItem.h"
#import "FFConstant.h"
#import "FFTool.h"

@interface FFFixHeightInputItem ()

@end

@implementation FFFixHeightInputItem

@synthesize titleLb = _titleLb;
@synthesize placeholderLb = _placeholderLb;
@synthesize textView = _textView;
@synthesize lineView = _lineView;
@synthesize titleToInputGap = _titleToInputGap;
@synthesize titleWidth = _titleWidth;
@synthesize mustLb = _mustLb;

#pragma mark - Overrides
- (CGSize)size {
    if ([super size].height == 0.f) {
        return CGSizeMake([super size].width, FFViewFixHeightNormalHeight);
    }
    return [super size];
}

- (instancetype)initWithManager:(__kindof FFViewManager *)manager {
    self = [super initWithManager:manager];
    if (self) {
        self.paddingInsets = FFItemViewNormalPadding;
        __weak typeof(self)sself = self;
        [manager setDidSetContent:^(FFViewManager *manager, id content) {
            __strong typeof(sself)self = sself;
            self.textView.text = content;
        }];
        
        [manager setWillGetContent:^id(FFViewManager *manager, id content) {
            __strong typeof(sself)self = sself;
            
            NSString *tempContent = self.textView.text.length == 0 ? nil : self.textView.text;
            
            self.placeholderLb.hidden = tempContent;
            
            return tempContent;
        }];
        
        [manager setWillGetValue:^id(FFViewManager *manager, id value) {
            return manager.content;
        }];
        
        [manager setDidSetTitle:^(FFViewManager *manager, NSString *title) {
            __strong typeof(sself)self = sself;
            self.titleLb.text = title;
        }];
        
        [self addSubview:self.titleLb];
        [self addSubview:self.textView];
        [self addSubview:self.placeholderLb];
        [self addSubview:self.lineView];
        [self addSubview:self.mustLb];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLb.frame = CGRectMake(
                                    self.paddingInsets.left,
                                    self.paddingInsets.top,
                                    self.titleWidth,
                                    MIN(FFViewNormalHeight, self.ff_height) - self.paddingInsets.top - self.paddingInsets.bottom
                                    );
    CGPoint center = self.titleLb.center;
    [self.titleLb sizeToFit];
    self.titleLb.ff_centerY = center.y;
    self.titleLb.ff_width = self.titleWidth;
    
    CGFloat x = self.titleLb.ff_right + self.titleToInputGap;
    self.textView.frame = CGRectMake(
                                     x,
                                     self.titleLb.ff_y,
                                     self.ff_width - x - self.paddingInsets.right,
                                     MAX(self.ff_height - (self.titleLb.ff_y * 2.f - self.paddingInsets.top + self.paddingInsets.bottom), 0.f)
                                     );
    self.placeholderLb.frame = self.textView.frame;
    self.lineView.frame = CGRectMake(
                                     self.titleLb.ff_x,
                                     self.ff_height - FFViewLineNormalHeight,
                                     self.textView.ff_right - self.titleLb.ff_left,
                                     FFViewLineNormalHeight
                                     );
    
    [self.mustLb sizeToFit];
    self.mustLb.ff_origin = CGPointMake(self.titleLb.ff_x - self.mustLb.ff_width - FFViewMustRedFormTitleGap, 0.f);
    self.mustLb.ff_centerY = self.titleLb.ff_centerY;
}

- (void)changeMust:(BOOL)isMust {
    
    self.mustLb.hidden = !isMust;
}

- (void)changeEdit:(BOOL)isEdit {
    [super changeEdit:isEdit];
    
    self.textView.editable = isEdit;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (CGRectContainsPoint(CGRectMake(self.textView.ff_x, 0, self.textView.ff_width, self.ff_height), point)) {
        return self.textView;
    }
    return nil;
}

#pragma mark - Public Method

+ (instancetype)inputWithKey:(NSString *)key
                       title:(NSString *)title
                 placeholder:(NSString *)placeholder
                        must:(BOOL)must {
    return [self inputWithKey:key
                        title:title
                  placeholder:placeholder
                    fixHeight:0.f
                         must:must];
}

+ (instancetype)inputWithKey:(NSString *)key
                       title:(NSString *)title
                 placeholder:(NSString *)placeholder
                   fixHeight:(CGFloat)fixHeight
                        must:(BOOL)must {
    FFFixHeightInputItem *item = [self formViewWithKey:key];
    item.manager.title = title;
    item.manager.must = must;
    item.placeholderLb.text = placeholder;
    if (fixHeight) {
        item.size = CGSizeMake(0.f, fixHeight);
    }
    return item;
}

#pragma mark - Lazy Load
- (void)setTitleToInputGap:(CGFloat)titleToInputGap {
    if (_titleToInputGap == titleToInputGap) {
        return;
    }
    _titleToInputGap = titleToInputGap;
    [self setNeedsLayout];
}

- (CGFloat)titleToInputGap {
    if (_titleToInputGap) {
        return _titleToInputGap;
    }
    return FFViewNormalGap;
}

- (void)setTitleWidth:(CGFloat)titleWidth {
    if (_titleWidth == titleWidth) {
        return;
    }
    _titleWidth = titleWidth;
    [self setNeedsLayout];
}

- (CGFloat)titleWidth {
    if (_titleWidth) {
        return _titleWidth;
    }
    return FFViewTitleNormalWidth;
}

- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = [UIFont systemFontOfSize:FFViewTitleNormalFontSize];
        _titleLb.textColor = [UIColor ff_colorWithHexValue:FFViewTitleNormalTextColor];
    }
    return _titleLb;
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.textColor = [UIColor ff_colorWithHexValue:FFViewContentNormalTextColor];
        _textView.font = [UIFont systemFontOfSize:FFViewContentNormalFontSize];
        _textView.delegate = self;
        _textView.backgroundColor = [UIColor ff_colorWithHexValue:0xEEEEEE];
    }
    return _textView;
}

- (UITextView *)placeholderLb {
    if (!_placeholderLb) {
        _placeholderLb = [[UITextView alloc] init];
        _placeholderLb.font = [UIFont systemFontOfSize:FFViewContentNormalFontSize];
        _placeholderLb.textColor = [UIColor ff_colorWithHexValue:FFViewPlaceholderNormalTextColor];
        _placeholderLb.editable = NO;
        _placeholderLb.backgroundColor = [UIColor clearColor];
    }
    return _placeholderLb;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor ff_colorWithHexValue:FFViewLineViewNormalColor];
    }
    return _lineView;
}

- (UILabel *)mustLb {
    if (!_mustLb) {
        _mustLb = [[UILabel alloc] init];
        _mustLb.text = @"*";
        _mustLb.textColor = [UIColor redColor];
        _mustLb.hidden = YES;
    }
    return _mustLb;
}

@end


@implementation FFFixHeightInputItem (TextViewDelegate)

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if (self.shouldBeginEditing) {
        return self.shouldBeginEditing(self);
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (self.didEndEditing) {
        self.didEndEditing(self);
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    
    NSString *content = textView.text;
    if (content.length == 0) {
        self.placeholderLb.hidden = NO;
    } else {
        self.placeholderLb.hidden = YES;
    }
}

@end
