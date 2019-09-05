//
//  FasnFormAHInputItem.m
//  FFFramework
//
//  Created by 谢帆 on 2019/7/28.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FFAutoHeightInputItem.h"
#import "FFTool.h"

@interface FFAutoHeightInputItem ()

@end

@implementation FFAutoHeightInputItem

@synthesize titleLb = _titleLb;
@synthesize placeholderLb = _placeholderLb;
@synthesize textView = _textView;
@synthesize lineView = _lineView;
@synthesize titleToInputGap = _titleToInputGap;
@synthesize titleWidth = _titleWidth;
@synthesize mustLb = _mustLb;

+ (instancetype)formViewWithKey:(NSString *)key
                          title:(NSString *)title
                    placeholder:(NSString *)placeholder
                           must:(BOOL)must {
    FFAutoHeightInputItem *item = [self formViewWithKey:key];
    item.manager.title = title;
    item.placeholderLb.text = placeholder;
    item.manager.must = must;
    return item;
}

- (void)dealloc {
    [self.textView removeObserver:self forKeyPath:@"text"];
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
            return self.textView.text.length == 0 ? nil : self.textView.text;
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
        
        [self.textView addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
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

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    
    if (object == self.textView && [keyPath isEqualToString:@"text"]) {
        
        NSString *content = change[NSKeyValueChangeNewKey];
        [self ff_refreshHeightWithContent:content];
    }
}

- (void)ff_refreshHeightWithContent:(NSString *)content {
    if (content.length == 0) {
        self.placeholderLb.hidden = NO;
    } else {
        self.placeholderLb.hidden = YES;
    }
    CGSize size = [content boundingRectWithSize:CGSizeMake(self.textView.ff_width, CGFLOAT_MAX)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName : self.textView.font}
                                        context:nil].size;
    CGFloat height = self.ff_height;
    self.ff_height = MAX(FFViewNormalHeight,
                           (self.titleLb.ff_y * 2.f - self.paddingInsets.top + self.paddingInsets.bottom) + size.height);
    if (height != self.ff_height) {
        [self.manager excuteRefreshBlock];
    }
}

- (void)changeMust:(BOOL)isMust {
    self.mustLb.hidden = !isMust;
}

- (void)changeEdit:(BOOL)isEdit {
    [super changeEdit:isEdit];
    
    self.textView.editable = isEdit;
}

- (CGSize)size {
    return CGSizeMake([super size].width, self.ff_height);
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (CGRectContainsPoint(CGRectMake(self.textView.ff_x, 0, self.textView.ff_width, self.ff_height), point)) {
        return self.textView;
    }
    return nil;
}

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
        _textView.contentInset = UIEdgeInsetsZero;
        _textView.textContainer.lineFragmentPadding = 0;
        _textView.textContainerInset = UIEdgeInsetsZero;
        _textView.scrollEnabled = NO;
        _textView.delegate = self;
        _textView.backgroundColor = [UIColor clearColor];
    }
    return _textView;
}

- (UITextView *)placeholderLb {
    if (!_placeholderLb) {
        _placeholderLb = [[UITextView alloc] init];
        _placeholderLb.font = [UIFont systemFontOfSize:FFViewContentNormalFontSize];
        _placeholderLb.textColor = [UIColor ff_colorWithHexValue:FFViewPlaceholderNormalTextColor];
        _placeholderLb.contentInset = UIEdgeInsetsZero;
        _placeholderLb.textContainerInset = UIEdgeInsetsZero;
        _placeholderLb.editable = NO;
        _placeholderLb.backgroundColor = [UIColor clearColor];
        _placeholderLb.textContainer.lineFragmentPadding = 0;
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


@implementation FFAutoHeightInputItem (TextViewDelegate)

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
    [self ff_refreshHeightWithContent:textView.text];
}

@end
